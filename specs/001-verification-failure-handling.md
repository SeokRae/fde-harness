# Spec ID: 001 — Verification 실패 처리 (분기 + failure-log)

## What (무엇을)
사용자가 `/fde-done` 실행 후 Done means 일부가 실패했을 때 다음으로 어디로 가야 할지 명시되고, 실패 결정이 `.harness/failure-log` 에 영속화된다.

## Why (왜) — 비즈니스 가치
현재 FDE 사이클이 한 곳에서 비공식적으로 열려있다:
- `/fde-done` 본문은 *"체크리스트 중 하나라도 실패하면 done 처리하지 않고 어떤 추가 작업이 필요한지 보고한다"* 만 명시 — 그 다음 단계가 없음
- 실패 흔적이 어디에도 안 남음 → Ratchet의 입력이 사람 기억에만 의존

결과: 한 spec이 "implementing" 상태로 영원히 갇힐 수 있고, Ratchet이 빈약해진다.

이 spec이 완료되면 사이클이 닫히고, Ratchet 입력 신뢰성이 올라간다.

## Done means (완료 정의)

- [ ] `commands/fde-done.md` 에 "실패 처리" 신규 섹션 추가 — 4가지 분기 옵션 (`implementation-retry` / `spec-revise` / `split-spec` / `reject`) 의 정의·트리거·다음 단계가 표로 명시되어 있음
- [ ] `commands/fde-done.md` 에 failure-log 기록 단계 추가 — 포맷 `{ISO 8601 UTC} {Spec ID} {decision}: {요약}` 가 본문에 예시와 함께 명시
- [ ] `commands/fde-init.md` 에 `.harness/failure-log` 빈 파일 생성 단계 추가 (기존 `done.log` 생성 단계 옆)
- [ ] `templates/AGENTS.md` 의 Delta 작업 순서 4번 항목에 통과/실패 두 경로가 모두 명시됨
- [ ] `templates/AGENTS.md` 의 "절대 하지 말 것" 에 `.harness/failure-log` 수동 편집 금지 추가
- [ ] `skills/fde-workflow/SKILL.md` 의 Verification 단계에 4가지 분기 흐름이 본문에 포함됨
- [ ] 이 spec 파일(`specs/001-...md`) 자체가 레포에 커밋됨 — 메타-FDE 증거

## Out of scope (안 하는 것)

- Hard enforcement (PreToolUse hook으로 plan 페이즈 Edit/Write 차단) — P1로 분리
- 자동 테스트 hook (PostToolUse) — P1
- 사이클 메타데이터 통계 (시도 횟수·소요 시간) — P2
- 규칙 진화 메커니즘 (line rule → hook 승격) — P2
- README "4가지 최소 개념" 의 Ratchet 표현 갱신 — 현재 표현이 정확하므로 보류

## Context (참고 자료)

- 직전 audit 결과: "FDE 사이클 부족분 — 1순위 검증 실패 분기, 2순위 실패 기록"
- 영향받는 파일 4개: `commands/fde-done.md` · `commands/fde-init.md` · `templates/AGENTS.md` · `skills/fde-workflow/SKILL.md`
- 신규 파일: 이 spec + `specs/` 폴더 자체

## Open questions (불명확한 점)

- failure-log 포맷이 향후 도구 통합(대시보드·통계) 필요 시 충분히 파싱 가능한가? → 단순 한 줄로 시작, 확장 필요 시 JSON Lines 검토 (P2 범위)

## Risks (위험 요소)

- `/fde-done` 본문이 길어져 AI가 일관되게 따르기 어려움 — 분기 가이드를 별도 서브섹션 + 표로 정리하여 가독성 유지
- failure-log 포맷이 후속 마이그레이션 어려움 — 단순 한 줄 형식부터, 변경 가능성 인지하고 시작
- `specs/` 폴더 추가 후 기존 `.gitignore` 의 `.harness/` 규칙이 specs와 충돌 없는지 확인 필요

## Rollback plan (롤백 계획)

- failure-log는 신규 artifact — 기능 비활성화 시 `commands/fde-done.md` 본문에서 기록 단계만 제거하면 됨 (호환성 깨짐 없음)
- 본문 변경은 git revert
- 사용자 프로젝트에 `failure-log` 가 없어도 `/fde-done` 이 동작해야 함 — 안전 가드("없으면 만들고 진행") 포함
