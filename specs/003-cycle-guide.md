# Spec ID: 003 — FDE 사이클 가이드 문서화

## What (무엇을)
한 사이클을 처음부터 끝까지 따라갈 수 있는 단일 walkthrough 문서가 생기고, 실패 분기 결정 기준·로그 포맷이 한 곳에 모인다. README와 docs/concepts.md 에 흩어져 있던 stale 내용도 동기화된다.

## Why (왜) — 비즈니스 가치

직전 audit에서 식별된 6개 문서화 갭 중 5개는 다음을 보장하지 못함:
- 처음 사용자가 "이게 실제로 어떻게 돌아가지" 답을 한 곳에서 찾을 수 없음
- 4가지 실패 분기(`implementation-retry` / `spec-revise` / `split-spec` / `reject`) 중 **무엇을 언제** 선택해야 하는지 가이드 없음
- 로그 포맷(`done.log` · `failure-log`)이 `commands/fde-done.md` 본문에만 흩어져 있음
- `docs/concepts.md` stateDiagram이 4가지 분기를 반영 안 함 (PR #12 이후 stale)
- `README.md` "사용 흐름 7단계" 가 실패 경로 없이 happy-path만 표시 (stale)

이 spec 완료 후: 사용자가 `docs/cycle-guide.md` 한 곳에서 모든 단계·결정·산출물·포맷을 확인할 수 있고, 다른 문서들은 거기로 링크.

## Done means (완료 정의)

- [ ] `docs/cycle-guide.md` 신규 파일이 존재하며 6개 섹션 포함:
  - § 1. 사이클 한눈에 (다이어그램)
  - § 2. 워크스루 — specs/001 실제 사례로 5단계 추적
  - § 3. 단계별 산출물 매트릭스
  - § 4. 결정 트리 (Echo Plan 평가 + Verification 4가지 분기)
  - § 5. 로그 포맷 레퍼런스 (done.log + failure-log)
  - § 6. Spec 라이프사이클 현재 상태 + specs/004 후보 메모
- [ ] `docs/concepts.md` § 2 stateDiagram 갱신 — `Verification` 노드에서 4가지 분기(implementation-retry · spec-revise · split-spec · reject) 명시
- [ ] `README.md` "사용 흐름" 섹션에 실패 분기 1줄 추가 + `docs/cycle-guide.md` 링크
- [ ] 4곳 동기화 자체 체크 (직전 Ratchet) — `commands/`, `templates/`, `skills/`, README 영향 검토
- [ ] 모든 내부 링크(`../README.md`, `../specs/001-...`) 경로 정확
- [ ] specs/004 후보 (Spec 라이프사이클 frontmatter) 가 § 6 에 명시되어 추적 가능

## Out of scope (안 하는 것)

- Spec 라이프사이클 frontmatter `status:` 도입 — `templates/spec-template.md` + `/fde-plan` Discovery 로직 변경 필요, **specs/004 별도 사이클로 분리**
- `/fde-rules-review` 커맨드 (Ratchet 정리) — specs/005 후보
- 사이클 메타데이터 통계 (시도 횟수·소요 시간) — specs/006 후보
- 외부 dogfooding (다른 프로젝트에 install 후 1 사이클) — 사용 검증, 문서화와 분리

## Context (참고 자료)

- 직전 audit 결과 (이 세션 직전 대화): "사이클 문서화 현황 — 6개 갭"
- walkthrough 소재: `specs/001-verification-failure-handling.md` (이 레포의 첫 FDE 사이클, 7항목 Done means 7/7 통과, PR #12)
- 직전 사이클 Ratchet 규칙 4개(루트 AGENTS.md) — 이번 작업의 자체 체크 항목

## Open questions (불명확한 점)

- 워크스루를 specs/001 실제 사례로 할지, 가상 예시(login feature)로 할지? → **specs/001 실제 사례** 권장 (이미 검증된 데이터, dogfooding 강화)
- README 사용 흐름을 7단계로 유지할지, 더 줄일지? → **유지하고 1줄만 추가** (간결성)

## Risks (위험 요소)

- `docs/cycle-guide.md` 가 길어져 다른 문서와 중복 위험 → 다른 문서는 **링크만**, 내용 복사 금지 (Single Source 원칙)
- stateDiagram에 4가지 분기 추가 시 시각적 복잡도 ↑ → 가독성 우선, 분기 라벨은 짧게 (`spec-revise` 정도)
- Cycle-guide의 워크스루 본문에 specs/001 내용을 복사하면 specs/001 변경 시 sync 문제 → 본문에는 요약만, 상세는 specs/001 링크

## Rollback plan (롤백 계획)

- `docs/cycle-guide.md` 신규 — 제거만 하면 됨
- `docs/concepts.md` 변경 — git revert (PR #4 시점 다이어그램으로 복원)
- `README.md` 변경 — git revert
- 모두 문서 변경이라 사용자 코드 영향 없음
