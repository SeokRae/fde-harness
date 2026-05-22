# Spec ID: 006 — 가치 사이클 닫기 (Hypothesis · Outcome · Positive Ratchet · Value-driven Discovery)

> **개념 위반 복구 사이클**: 직전 검토에서 식별된 FDE 의 4가지 개념 공백(②⑥⑦⑩) 을 한 묶음으로 메운다. 본 spec 머지 후 fde-harness 는 "FDE 라는 이름의 SDD 하네스" 가 아니라 **진짜로 SDD 와 차별화된 FDE 하네스** 가 된다.

## What (무엇을)

FDE 의 개념적 4가지 공백을 메우는 한 묶음 변경:

1. **Hypothesis (②)** — spec 마다 정량 가설 슬롯 `## Expected outcome` 추가
2. **Outcome 추적 (⑥)** — `/fde-done` Done means 통과 후 실제 결과를 사용자에게 묻고 `.harness/outcome.log` 에 영속화
3. **Positive Ratchet (⑦)** — `AGENTS.md` 에 `## 검증된 패턴` 섹션 추가, `/fde-done` Ratchet 단계에서 양의 학습도 수집
4. **Value-driven Discovery (⑩)** — `/fde-plan` 의 다음 spec 선택 기준을 FIFO(`가장 작은 ID`) → Expected outcome 큰 순(fallback 으로 FIFO)

추가로 PR #18 머지 시점에 깨진 4곳 동기 잔재(concepts.md § 4 다이어그램, fde-workflow SKILL.md 의 슬래시 커맨드 목록) 도 같이 정리한다 — 어차피 본 변경이 같은 파일을 손대므로 비용 거의 0.

## Why (왜) — 비즈니스 가치

직전 검토 결과: 현재 fde-harness 는 Spec → Plan → Implement → Verify → Ratchet 의 SDD 루프만 강제한다. SDD 와 FDE 의 차이 — *가치 가설*·*가치 실현 추적*·*가치 기반 우선순위* — 가 빠져있는 한, "FDE" 라는 이름은 약속하지 못한 것을 약속한다.

본 spec 이 완료되면:
- spec 의 Why 슬롯이 정성 수식어가 아니라 측정 가능한 가설이 된다
- done.log 통과 = 사이클 종료가 아니라, outcome.log 기록까지가 사이클 종료가 된다 (실제로 닫힘)
- AGENTS.md 가 음의 학습만이 아니라 양의 학습도 영속화한다
- `/fde-plan` 이 작성 순서가 아니라 가치 순서로 spec 을 선택한다

## Expected outcome (정량) — 이 spec 본인이 새 슬롯의 첫 사례

- 본 spec 머지 후 작성되는 다음 3개 spec(007-009) 의 **100%** 가 `## Expected outcome` 슬롯을 비어있지 않게 채운다 — 측정: 머지된 spec 파일 grep
- 본 spec 머지 후 첫 `/fde-done` 호출에서 `.harness/outcome.log` 에 **최소 1줄** 기록된다 — 측정: outcome.log 의 line count
- 본 spec 머지 후 `README.md` description 에서 "Spec-driven" 만 아닌 "Value-driven" 표현을 정직하게 쓸 수 있게 된다 (정성 측정 — 외부 사용자가 "왜 FDE 라고 이름 붙였나" 질문이 줄어드는지)

## Done means (완료 정의)

### 핵심 변경 (4가지)

- [ ] `templates/spec-template.md` 에 `## Expected outcome (정량)` 슬롯이 `## Why` 직후 · `## Done means` 직전 위치에 추가됨 (기존 슬롯 순서 보존)
- [ ] `commands/fde-init.md` 에 `./.harness/outcome.log` 빈 파일 생성 단계 추가 (기존 done.log·failure-log 생성 옆)
- [ ] `commands/fde-done.md` 의 "완료 처리 (모두 통과한 경우에만)" 단계에 outcome 측정 서브스텝 추가 — 사용자에게 "이 spec 의 Expected outcome 측정 결과는?" 질문, `.harness/outcome.log` 에 한 줄 기록 (포맷: `{ISO 8601 날짜} {Spec ID} {결과 요약}`)
- [ ] `templates/AGENTS.md` 에 `## 검증된 패턴` 섹션이 `## 절대 하지 말 것` 직후 위치에 추가됨 — "✅ 잘 작동한 한 줄 규칙" 형식 안내 포함
- [ ] `commands/fde-done.md` 의 Ratchet 단계에 양의 학습 질문 추가 — "이번에 잘 작동해서 다음에도 쓰고 싶은 패턴이 있나요?" 답이 있으면 `## 검증된 패턴` 에 한 줄 영속화
- [ ] `commands/fde-plan.md` Discovery (1단계) 가 Expected outcome 정량값 큰 순으로 spec 선택, 슬롯이 없는 spec 은 FIFO fallback. 사용자에게 선택 근거를 한 줄로 보고

### 동기화 (4곳 규칙 — PR #18 잔재 + 본 변경 모두 포함)

- [ ] `skills/fde-workflow/SKILL.md` 동기 — (a) Verification 단계 본문에 outcome 기록 서브스텝 (b) Ratchet 단계 본문에 양의 학습 (c) 슬래시 커맨드 목록에 `/fde-note`·`/fde-draft` 추가 (PR #18 잔재)
- [ ] `docs/concepts.md` 동기 — (a) § 2 stateDiagram 의 `Done` 노드 다음에 outcome 측정 노드 추가 (b) § 3 Ratchet 다이어그램에 양방향 학습 표시 (c) § 4 컴포넌트 매핑에 notes/·discovery-drafts/·fde-note·fde-draft·discovery-echo 추가 (PR #18 잔재)
- [ ] `docs/cycle-guide.md` (SSoT) 동기 — (a) Stage 5 (Verification) 에 outcome 기록 서브스텝 (b) Stage 6 (Ratchet) 에 positive pattern 서브스텝 (c) § 5 로그 포맷에 outcome.log 신규 항목 (d) 워크스루 표·결정 트리에 outcome 흐름 반영
- [ ] `README.md` 의 사용 흐름 갱신 — outcome 측정 1 줄 추가, `/fde-plan` 의 우선순위 변경 안내 1 줄

### 메타 (매니페스트·검증)

- [ ] 두 매니페스트 (`.claude-plugin/plugin.json`, `.codex-plugin/plugin.json`) version `0.2.0 → 0.3.0` 동기 갱신 (동작 변경 — 버전 bump 규칙 적용)
- [ ] `./test.sh` 의 `version_sync` 가 `0.3.0` 으로 통과
- [ ] `./test.sh` 의 모든 검증 PASS, GitHub Actions check success

## Out of scope (안 하는 것)

- ⑧ Cross-project knowledge — AGENTS.md 의 cross-project export 메커니즘은 별도 spec (검증된 패턴이 충분히 쌓인 후)
- ⑨ Customer Relationship — 도구 범위 밖
- ① Discovery 의 도메인 ontology builder — `discovery-echo` 로 첫 단계는 시작됨, 추가 확장은 별도
- Hook matcher 대소문자 검증 (직전 검토 P0) — spec 007 후보 (별도 진단 + 수정)
- Outcome 의 정량 표준화 (OKR/KPI 형식 강제) — 첫 사이클은 자유 텍스트, 패턴 보고 결정
- `./test.sh` 에 outcome.log·검증된 패턴 회귀 가드 — 충분한 데이터 누적 후 별도 사이클
- 기존 specs/001-005 에 Expected outcome 슬롯 retroactive 추가 — 새 spec 부터만 강제
- spec-template 의 Risks/Rollback plan 슬롯 변경 — 그대로 보존

## Context (참고 자료)

- 직전 검토 결과: 사용자가 "구현이 FDE 개념에서 벗어난 게 의도가 아니라 실수일 수 있다" 지적 → ②⑥⑦⑩ 4건이 실수로 판정
- 직전 사이클 spec 005 (PR #20) 가 spec 선행 패턴을 commit graph 로 처음 검증 — 본 spec 도 같은 패턴 (spec 단독 commit → impl commit)
- PR #18 잔재: concepts.md § 4, SKILL.md 슬래시 커맨드 목록 — 본 spec 동기화 항목에 합쳐서 처리
- 영향받는 파일 ~11 개

## Open questions (불명확한 점)

- **Outcome 측정 시점이 spec 완료 직후가 아닐 가능성** (예: A/B test 결과 1주 뒤). `/fde-done` 에서 "측정 완료" vs "측정 예정" 둘 다 지원할지 → **첫 사이클은 자유 텍스트로 두고** 패턴 보고 결정.
- **검증된 패턴 항목 누적 한계**: AGENTS.md 가 비대해지면 압축 메커니즘 필요. 6개월·100건 등 임계치 — 별도 spec.
- **Expected outcome 없는 기존 spec 처리**: `/fde-plan` Discovery 가 outcome 큰 순 정렬할 때 슬롯 없는 specs/001-005 를 어떻게 다룰지 → **fallback 으로 FIFO 사용**. 명시.

## Risks (위험 요소)

- **PR 규모가 큼 (~11 파일)** — 4곳 동기 규칙 + concepts/cycle-guide SSoT 까지 동시 갱신 필요. 검토 부담 ↑. 인지: PR review 에서 reviewer 가 "한 PR 에 너무 많다" 라고 하면 `split-spec` (예: 핵심 4 변경 + 동기화 분리). 본 spec 의 가치는 **4가지가 한꺼번에 가야 의미가 있음** (Hypothesis 없이 Outcome 없고, Outcome 없이 Value-driven Discovery 없음) 이므로 분리 손익 신중히 평가.
- **outcome.log 가 처음엔 placeholder 만** — Expected outcome 슬롯 없는 specs/001-005 의 `/fde-done` 호출 시 outcome.log 에 `(Expected outcome 미정의)` placeholder 기록. 신규 spec 부터 의미 있는 데이터 누적. 인지: 첫 의미 있는 outcome.log 라인이 spec 007 머지 시점에 나오는지 추적.
- **`/fde-plan` 우선순위 변경으로 기존 사용자 워크플로 혼란** — 어제까지 FIFO 였는데 갑자기 outcome 기준 선택. README 안내 1줄 + 변경 직후 첫 호출에서 "기준이 바뀌었습니다" 알림으로 완화.
- **양의 학습 노이즈 위험** — "잘 작동했다" 라고 모두 영속화하면 신호 약화. AGENTS.md 의 양의 학습도 음의 학습과 같은 규칙 — "구체적이어야 한다" 명시.

## Rollback plan (롤백 계획)

4가지 변경은 서로 독립이므로 부분 롤백 가능 (의도된 분리):

- **Hypothesis 롤백** — `templates/spec-template.md` 의 슬롯 제거. 이미 작성된 Expected outcome 본문은 그대로 보존 (해 없음).
- **Outcome 롤백** — `commands/fde-done.md` 본문에서 outcome 서브스텝 제거. `.harness/outcome.log` 파일은 그대로 둠 (사용자 자산).
- **Positive Ratchet 롤백** — `templates/AGENTS.md` 의 섹션 + `commands/fde-done.md` 의 양의 학습 질문 제거. 이미 영속화된 패턴 본문은 그대로 (해 없음).
- **Value-driven Discovery 롤백** — `commands/fde-plan.md` 의 1단계를 FIFO 로 되돌림.

기타:
- `skills/fde-workflow/SKILL.md`·`docs/concepts.md`·`docs/cycle-guide.md`·`README.md` 변경은 `git revert`
- 매니페스트 `0.3.0 → 0.2.0` 되돌림
- 사용자 영향: outcome.log 파일이 추가됐던 사용자 프로젝트는 그대로 둠 (무해), 새 spec 의 Expected outcome 슬롯은 placeholder 로만 남음

호환성: v0.2.x 에서 v0.3.0 로 업그레이드하는 사용자는 `/fde-init` 재실행 시 outcome.log 만 추가됨. 기존 spec 들도 그대로 동작 (Expected outcome 슬롯이 없으면 FIFO fallback).
