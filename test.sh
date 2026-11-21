#!/usr/bin/env bash
set -euo pipefail

FAIL=0
pass() { printf "PASS  %s\n" "$1"; }
fail() { printf "FAIL  %s: %s\n" "$1" "$2"; FAIL=1; }

if ! command -v jq >/dev/null 2>&1; then
  echo "FAIL  jq_available: jq가 PATH에 없습니다 (apt install jq / brew install jq)"
  exit 2
fi
pass "jq_available"

for f in .claude-plugin/plugin.json .codex-plugin/plugin.json marketplace.json; do
  if jq empty "$f" >/dev/null 2>&1; then pass "json_valid ($f)"; else fail "json_valid" "$f 파싱 실패"; fi
done

V_CLAUDE=$(jq -r '.version' .claude-plugin/plugin.json)
V_CODEX=$(jq -r '.version' .codex-plugin/plugin.json)
if [ "$V_CLAUDE" = "$V_CODEX" ] && [ "$V_CLAUDE" != "null" ]; then
  pass "version_sync ($V_CLAUDE)"
else
  fail "version_sync" "claude=$V_CLAUDE codex=$V_CODEX"
fi

EXPECTED_COMMANDS="fde-init fde-qualify fde-pilot fde-baseline fde-week fde-showcase fde-handoff"
ACTUAL_COMMANDS=$(find commands -maxdepth 1 -name '*.md' -type f -exec basename {} .md \; | sort | tr '\n' ' ')
EXPECTED_SORTED=$(printf '%s\n' $EXPECTED_COMMANDS | sort | tr '\n' ' ')
if [ "$ACTUAL_COMMANDS" = "$EXPECTED_SORTED" ]; then
  pass "commands_set (7)"
else
  fail "commands_set" "기대 [$EXPECTED_SORTED] 실제 [$ACTUAL_COMMANDS]"
fi

SYNC_FAIL=0
for c in $EXPECTED_COMMANDS; do
  f="commands/$c.md"
  [ -f "$f" ] || continue
  name=$(sed -n 's/^name: //p' "$f" | head -1)
  [ "$name" = "$c" ] || { SYNC_FAIL=1; fail "command_name ($c)" "frontmatter name=$name"; }
  grep -qF "docs/methodology.md" "$f" || { SYNC_FAIL=1; fail "command_methodology_link ($c)" "docs/methodology.md 링크 없음"; }
  grep -qF "\`/$c" README.md || { SYNC_FAIL=1; fail "readme_lists_command ($c)" "README에 /$c 없음"; }
  grep -qF "commands/$c.md" skills/fde-engagement/SKILL.md || { SYNC_FAIL=1; fail "skill_routes_command ($c)" "SKILL.md 단계 판정 표에 없음"; }
  grep -qF "\`/$c" docs/methodology.md || { SYNC_FAIL=1; fail "methodology_lists_command ($c)" "docs/methodology.md에 없음"; }
done
[ "$SYNC_FAIL" -eq 0 ] && pass "command_sync (name | methodology | README | SKILL)"

SKILLS=$(find skills -mindepth 2 -maxdepth 2 -name SKILL.md -type f | wc -l | tr -d ' ')
if [ "$SKILLS" -eq 1 ]; then pass "skills_count (1)"; else fail "skills_count" "기대 1, 실제 $SKILLS"; fi

for t in brief qualify pilot baseline week showcase handoff failure-modes; do
  if [ -f "templates/$t.md" ]; then pass "template_present ($t)"; else fail "template_present" "templates/$t.md 없음"; fi
done

for ref in $(grep -ohE 'templates/[a-z-]+\.md' commands/*.md | sort -u); do
  [ -f "$ref" ] || { SYNC_FAIL=1; fail "template_ref" "$ref 참조되지만 없음"; }
done
[ "$SYNC_FAIL" -eq 0 ] && pass "template_refs"

for t in qualify pilot baseline showcase handoff; do
  grep -q '^status: draft$' "templates/$t.md" || { SYNC_FAIL=1; fail "template_status ($t)" "frontmatter status: draft 없음"; }
done
[ "$SYNC_FAIL" -eq 0 ] && pass "template_status"

if grep -rniE 'sr-harness|sr-obsidian' --exclude-dir=.git --exclude=test.sh . >/dev/null; then
  fail "standalone" "다른 하네스 참조가 있습니다: $(grep -rliE 'sr-harness|sr-obsidian' --exclude-dir=.git --exclude=test.sh . | tr '\n' ' ')"
else
  pass "standalone"
fi

echo
if [ "$FAIL" -eq 0 ]; then echo "ALL PASS"; exit 0; else echo "SOME FAIL"; exit 1; fi
