#!/usr/bin/env bash
# fde-harness 자기 검증 스크립트.
# spec: specs/005-self-validation-ci-and-test-sh.md
# fast-fail. 각 항목 PASS/FAIL 출력. 한 항목이라도 실패하면 non-zero exit.

set -euo pipefail

FAIL=0
pass() { printf "PASS  %s\n" "$1"; }
fail() { printf "FAIL  %s — %s\n" "$1" "$2"; FAIL=1; }

# 0. jq 의존성
if ! command -v jq >/dev/null 2>&1; then
  echo "FAIL  jq_available — jq 가 PATH 에 없음. 설치 후 다시 실행하세요 (예: apt install jq / brew install jq)."
  exit 2
fi
pass "jq_available"

# 1. version_sync — 두 매니페스트의 version 필드 일치
V_CLAUDE=$(jq -r '.version' .claude-plugin/plugin.json)
V_CODEX=$(jq -r '.version' .codex-plugin/plugin.json)
if [ "$V_CLAUDE" = "$V_CODEX" ] && [ -n "$V_CLAUDE" ] && [ "$V_CLAUDE" != "null" ]; then
  pass "version_sync ($V_CLAUDE)"
else
  fail "version_sync" "claude=$V_CLAUDE codex=$V_CODEX"
fi

# 2. json_valid — 핵심 JSON 파일들 파싱
for f in .claude-plugin/plugin.json .codex-plugin/plugin.json .mcp.json hooks/post-tool-use.json marketplace.json; do
  if jq empty "$f" >/dev/null 2>&1; then
    pass "json_valid ($f)"
  else
    fail "json_valid" "$f 파싱 실패"
  fi
done

# 3. commands_count — README 와 동기 (현재 6 개)
EXPECTED_COMMANDS=7
ACTUAL_COMMANDS=$(find commands -maxdepth 1 -name '*.md' -type f | wc -l | tr -d ' ')
if [ "$ACTUAL_COMMANDS" -eq "$EXPECTED_COMMANDS" ]; then
  pass "commands_count ($ACTUAL_COMMANDS)"
else
  fail "commands_count" "기대 $EXPECTED_COMMANDS, 실제 $ACTUAL_COMMANDS — README 의 'Slash Commands' 개수와 test.sh 의 EXPECTED_COMMANDS 를 동시에 갱신했는가?"
fi

# 4. skills_count — README 와 동기 (현재 2 개)
EXPECTED_SKILLS=2
ACTUAL_SKILLS=$(find skills -mindepth 2 -maxdepth 2 -name SKILL.md -type f | wc -l | tr -d ' ')
if [ "$ACTUAL_SKILLS" -eq "$EXPECTED_SKILLS" ]; then
  pass "skills_count ($ACTUAL_SKILLS)"
else
  fail "skills_count" "기대 $EXPECTED_SKILLS, 실제 $ACTUAL_SKILLS — README 의 'Skills' 개수와 test.sh 의 EXPECTED_SKILLS 를 동시에 갱신했는가?"
fi

# 5. templates_present — 필수 템플릿 4종
for t in templates/spec-template.md templates/note-template.md templates/AGENTS.md templates/graduation-template.md; do
  if [ -f "$t" ]; then
    pass "templates_present ($t)"
  else
    fail "templates_present" "$t 부재"
  fi
done

echo
if [ "$FAIL" -eq 0 ]; then
  echo "ALL PASS"
  exit 0
else
  echo "SOME FAIL — 위 FAIL 라인을 보고 수정 후 재실행."
  exit 1
fi
