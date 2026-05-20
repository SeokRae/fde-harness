# Spec ID: 002 — PostToolUse 자동 테스트 hook

## What (무엇을)
사용자 프로젝트에서 코드 변경(Edit · Write · MultiEdit) 직후 `./test.sh` 가 자동으로 실행되어, 텍스트 지시였던 *"변경 후 자동 테스트"* 가 hook으로 강제된다.

## Why (왜) — 비즈니스 가치

현재 `templates/AGENTS.md` 의 *"모든 변경 후 자동 테스트가 있다면 직접 실행한다"* 는 **soft instruction**:
- AI가 무시하면 통과 안 한 코드가 다음 단계로 넘어갈 수 있음
- "지시를 따랐는지" 사용자가 매번 확인해야 함

PostToolUse hook으로 옮기면:
- 코드 변경마다 자동 실행 (AI 의지 무관)
- 테스트 실패 시 hook이 stdout/stderr로 명시
- 사용자 프로젝트의 `./test.sh` 가 **단일 진입점** — 어떤 스택이든 동일 인터페이스 (Python/Node/Go/Rust 무관)

## Done means (완료 정의)

- [ ] `hooks/post-tool-use.json` 신규 — PostToolUse hook 정의, matcher: tool=Edit · Write · MultiEdit
- [ ] hook 본문이 `./test.sh` 없을 때 **no-op** 으로 안전 처리 (`[ -x ./test.sh ] && ./test.sh || true`)
- [ ] `.claude-plugin/plugin.json` 에 `"hooks": "./hooks/"` 필드 추가
- [ ] `.codex-plugin/plugin.json` 에도 동일 `"hooks"` 필드 추가
- [ ] `templates/AGENTS.md` 의 "코딩 규칙" 섹션에 "**테스트 자동화**" 항목 추가 — `./test.sh` 작성 권고 + 한 줄 bash 예시
- [ ] `hooks/README.md` 의 "이 폴더는 현재 비어있습니다" 표현 제거하고 **활성 hook 문서** 로 갱신 (`post-tool-use.json` 설명 + 비활성화 방법)
- [ ] `commands/fde-init.md` 안내 메시지에 "테스트 자동화는 `./test.sh` 작성 후 동작" 한 줄 추가
- [ ] **워크플로우 동기화 4곳 확인** (직전 사이클 Ratchet 규칙 적용) — `commands/`, `templates/AGENTS.md`, `skills/`, `README.md` 중 영향받는 곳 빠짐 없음

## Out of scope (안 하는 것)

- PreToolUse Plan phase guard (specs/003 후보)
- 변경 파일 자동 감지 (git status 기반) — 별도 spec
- 테스트 결과 `.harness/test-log` 영속화 — 별도 spec
- 스택별 `./test.sh` 템플릿 (Python/Node/Java/Go/Rust)
- 테스트 실패 시 `/fde-done` 자동 차단 (hook stdout이 사용자에게 표시되는 것까지로 충분)

## Context (참고 자료)

- `hooks/README.md` 의 기존 PostToolUse 예시 (line 41-57) — 이 예시를 실제 활성 hook으로 승격
- 직전 사이클(#12) Ratchet: *"워크플로우 동사 변경 시 4곳 동기화"* — 이번 작업의 자체 체크 항목 (Done means 마지막)
- Claude Code hook spec — 정확한 matcher key 표기 (tool name 대소문자, filePattern 형식) 확인 필요

## Open questions (불명확한 점)

- Codex hook spec과 Claude Code hook spec이 동일한가? 다르면 별도 파일 필요할 수 있음 → 현재로는 동일하다고 가정, 사용 단계에서 검증
- matcher 가 너무 광범위하면 docs(.md) 수정에도 테스트 실행됨 → matcher 본문에 file path 패턴 추가할지 / 사용자가 `./test.sh` 안에서 빠른 short-circuit 할지 선택 → 후자 권장 (스크립트 권한이 더 유연)

## Risks (위험 요소)

- `./test.sh` 가 느린 경우 매 Edit 마다 대기 → 사용자가 `./test.sh` 안에서 fast-fail 짧게 설계해야 함, README에 권고 명시
- Hook 매니페스트 표기 (Claude vs Codex)가 실제로 다를 위험 → 신뢰성 ↓ 시 별도 hooks 파일로 분기
- 일반 `Edit/Write` 호출(docs 수정 포함)에 테스트가 돌아 노이즈 → 사용자가 path-aware `./test.sh` 작성하도록 안내

## Rollback plan (롤백 계획)

- `hooks/post-tool-use.json` 삭제 + 매니페스트 `"hooks"` 필드 제거 → hook 즉시 비활성화
- 텍스트 지시(`templates/AGENTS.md` 의 자동 테스트 권고)는 그대로 두므로 **soft fallback** 유지 → 기능 완전 미동작 상황 없음
- 사용자 프로젝트의 `./test.sh` 는 그대로 두어도 무해 (hook 없으면 호출 안 됨)
