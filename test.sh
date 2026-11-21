#!/usr/bin/env bash
set -euo pipefail

FAIL=0
pass() { printf "PASS  %s\n" "$1"; }
fail() { printf "FAIL  %s: %s\n" "$1" "$2"; FAIL=1; }

for tool in jq python3 zip unzip; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "FAIL  tool_available: $tool이 PATH에 없습니다"
    exit 2
  fi
done
pass "tool_available (jq | python3 | zip | unzip)"

SKILL_DIR="skills/fde-engagement"
SKILL_MD="$SKILL_DIR/SKILL.md"
STAGES="init qualify pilot baseline week showcase handoff"
TEMPLATES="brief qualify pilot baseline week showcase handoff failure-modes"

for f in .claude-plugin/plugin.json .claude-plugin/marketplace.json .codex-plugin/plugin.json marketplace.json; do
  if jq empty "$f" >/dev/null 2>&1; then pass "json_valid ($f)"; else fail "json_valid" "$f 파싱 실패"; fi
done

V_CLAUDE=$(jq -r '.version' .claude-plugin/plugin.json)
V_CODEX=$(jq -r '.version' .codex-plugin/plugin.json)
V_MKT_META=$(jq -r '.metadata.version' .claude-plugin/marketplace.json)
V_MKT_PLUGIN=$(jq -r '.plugins[] | select(.name == "fde-harness") | .version' .claude-plugin/marketplace.json)
if [ "$V_CLAUDE" != "null" ] && [ "$V_CLAUDE" = "$V_CODEX" ] && [ "$V_CLAUDE" = "$V_MKT_META" ] && [ "$V_CLAUDE" = "$V_MKT_PLUGIN" ]; then
  pass "version_sync ($V_CLAUDE)"
else
  fail "version_sync" "plugin=$V_CLAUDE codex=$V_CODEX marketplace.metadata=$V_MKT_META marketplace.plugin=$V_MKT_PLUGIN"
fi

SKILLS=$(find skills -mindepth 2 -maxdepth 2 -name SKILL.md -type f | wc -l | tr -d ' ')
if [ "$SKILLS" -eq 1 ]; then pass "skills_count (1)"; else fail "skills_count" "기대 1, 실제 $SKILLS"; fi

SPEC_OUT=$(python3 - "$SKILL_MD" <<'PY'
import re, sys, pathlib
p = pathlib.Path(sys.argv[1])
text = p.read_text(encoding="utf-8")
m = re.match(r"\A---\n(.*?)\n---\n", text, re.S)
errors = []
if not m:
    errors.append("frontmatter 없음")
else:
    fm = dict(line.split(": ", 1) for line in m.group(1).splitlines() if ": " in line)
    keys = set(fm)
    if keys != {"name", "description"}:
        errors.append(f"frontmatter 키는 name, description만 허용: {sorted(keys)}")
    name = fm.get("name", "")
    if not re.fullmatch(r"[a-z0-9-]{1,64}", name):
        errors.append(f"name 형식 위반: {name}")
    if name != p.parent.name:
        errors.append(f"name({name})과 폴더({p.parent.name}) 불일치")
    if "claude" in name or "anthropic" in name:
        errors.append("name에 예약어 포함")
    desc = fm.get("description", "")
    if not desc or len(desc) > 1024:
        errors.append(f"description 길이 {len(desc)}자 (1~1024)")
lines = text.count("\n")
if lines >= 500:
    errors.append(f"SKILL.md {lines}줄 (500줄 미만)")
print("\n".join(errors))
PY
)
if [ -z "$SPEC_OUT" ]; then pass "skill_spec (name | description | 500줄)"; else fail "skill_spec" "$SPEC_OUT"; fi

REF_FAIL=0
for ref in $(cat "$SKILL_MD" "$SKILL_DIR"/references/procedures/*.md | grep -oE '(references|assets)/[a-z/-]+\.md' | sort -u); do
  [ -f "$SKILL_DIR/$ref" ] || { REF_FAIL=1; fail "skill_ref" "$ref 참조되지만 $SKILL_DIR 안에 없음"; }
done
if grep -nE '\.\./|docs/|commands/|plugin|플러그인' "$SKILL_MD" "$SKILL_DIR"/references/procedures/*.md >/dev/null; then
  REF_FAIL=1; fail "skill_self_contained" "스킬 폴더 밖을 가리키는 표기: $(grep -lE '\.\./|docs/|commands/|plugin|플러그인' "$SKILL_MD" "$SKILL_DIR"/references/procedures/*.md | tr '\n' ' ')"
fi
[ "$REF_FAIL" -eq 0 ] && pass "skill_self_contained (모든 참조가 스킬 폴더 안)"

SYNC_FAIL=0
ACTUAL_COMMANDS=$(find commands -maxdepth 1 -name '*.md' -type f -exec basename {} .md \; | sort | tr '\n' ' ')
EXPECTED_COMMANDS=$(for s in $STAGES; do echo "fde-$s"; done | sort | tr '\n' ' ')
[ "$ACTUAL_COMMANDS" = "$EXPECTED_COMMANDS" ] || { SYNC_FAIL=1; fail "commands_set" "기대 [$EXPECTED_COMMANDS] 실제 [$ACTUAL_COMMANDS]"; }
for s in $STAGES; do
  c="fde-$s"
  f="commands/$c.md"
  [ -f "$SKILL_DIR/references/procedures/$s.md" ] || { SYNC_FAIL=1; fail "procedure_present ($s)" "절차 파일 없음"; }
  [ -f "$f" ] || continue
  name=$(sed -n 's/^name: //p' "$f" | head -1)
  [ "$name" = "$c" ] || { SYNC_FAIL=1; fail "command_name ($c)" "frontmatter name=$name"; }
  grep -qF "references/procedures/$s.md" "$f" || { SYNC_FAIL=1; fail "command_wraps_procedure ($c)" "절차 파일을 가리키지 않음"; }
  grep -qF "\`/$c" README.md || { SYNC_FAIL=1; fail "readme_lists_command ($c)" "README에 /$c 없음"; }
  grep -qF "references/procedures/$s.md" "$SKILL_MD" || { SYNC_FAIL=1; fail "skill_routes_stage ($s)" "SKILL.md 단계 판정 표에 없음"; }
  grep -qF "\`/$c" "$SKILL_DIR/references/methodology.md" || { SYNC_FAIL=1; fail "methodology_lists_command ($c)" "methodology.md에 없음"; }
done
[ "$SYNC_FAIL" -eq 0 ] && pass "stage_sync (command | procedure | README | SKILL | methodology)"

TPL_FAIL=0
for t in $TEMPLATES; do
  [ -f "$SKILL_DIR/assets/templates/$t.md" ] || { TPL_FAIL=1; fail "template_present" "$t.md 없음"; }
done
for t in qualify pilot baseline showcase handoff; do
  grep -q '^status: draft$' "$SKILL_DIR/assets/templates/$t.md" || { TPL_FAIL=1; fail "template_status ($t)" "status: draft 없음"; }
done
[ "$TPL_FAIL" -eq 0 ] && pass "templates (8 | status: draft)"

ZIP=$(scripts/build-skill-zip.sh)
ENTRIES=$(unzip -Z1 "$ZIP")
if echo "$ENTRIES" | grep -qx 'fde-engagement/SKILL.md' && ! echo "$ENTRIES" | grep -qx 'SKILL.md' && [ -z "$(echo "$ENTRIES" | grep -v '^fde-engagement/')" ]; then
  pass "skill_zip (최상위 fde-engagement/, $(echo "$ENTRIES" | grep -vc '/$') files)"
else
  fail "skill_zip" "ZIP 최상위가 fde-engagement/가 아님"
fi

if grep -rniE 'sr-harness|sr-obsidian' --exclude-dir=.git --exclude-dir=dist --exclude=test.sh . >/dev/null; then
  fail "standalone" "다른 하네스 참조: $(grep -rliE 'sr-harness|sr-obsidian' --exclude-dir=.git --exclude-dir=dist --exclude=test.sh . | tr '\n' ' ')"
else
  pass "standalone"
fi

echo
if [ "$FAIL" -eq 0 ]; then echo "ALL PASS"; exit 0; else echo "SOME FAIL"; exit 1; fi
