# Spec ID: 014 — F5 양방향 학습 깊은 진척 (첫 forcing function hard 강제)

> 직전 검토의 핵심 지적: *13 spec 동안 forcing function 0 깊은 진척 + 0 hard 강제 — 도구가 FDE 를 설명만 하고 강제 안 함*. 본 spec 은 **첫 깊은 진척 (F5)** + **첫 forcing function hard 강제** 를 만든다.

## What (무엇을)

F5 (Two-way Knowledge Flow) 를 *얕은 → 깊은 진척* 으로. 핵심은 마지막 항목 (test.sh hard 강제):

1. **`templates/AGENTS.md` 의 Ratchet 영역을 4 섹션으로 확장**:
   - `## 절대 하지 말 것` (음의 학습) — 이미 있음
   - `## 검증된 패턴` (양의 학습) — 신규
   - `## 운영자가 가르친 것` (Operator → Engineer 도메인 학습) — 신규
   - `## 운영자에게 보여준 가능성` (Engineer → Operator 가능성 학습) — 신규
2. **`commands/fde-done.md` 의 Ratchet 단계가 4 방향 모두 질문** — 음·양·도메인·가능성
3. **`test.sh` 에 `ratchet_sections` 검증 추가** — `templates/AGENTS.md` 가 4 섹션 헤더를 *모두* 포함하는지 hard 검증. **이게 첫 forcing function hard 강제** — 양방향 학습 구조가 *제거되면 CI 가 차단*.

## Why (왜)

직전 검토에서 식별: 도구가 *FDE 를 설명하는 어휘* 와 *자기평가 장치* 는 정교하지만, *forcing function 의 실제 강제* 가 0. 모든 게 soft instruction (AI 가 안 따라도 그만). 유일한 hard 강제 (hook + test.sh) 는 *repo 위생* 만 검증, *FDE 행동* 은 검증 안 함.

본 spec 이 두 가지 *최초* 를 만든다:

1. **첫 깊은 진척** — F5 의 § 2 의 3 bullet 을 *모두* 충족 (얕은 → 깊은)
2. **첫 forcing function hard 강제** — test.sh 가 *양방향 학습 구조의 존재* 를 강제. 구조 제거 시 CI FAIL. soft instruction 이 *처음으로* 도구 강제로 승격.

이게 *"FDE proper" 의 진짜 첫 증거* — 헌장 § 5.2 의 깊은 진척 1/3 달성.

## Expected outcome (정량)

- F5 의 § 2.F5 의 3 bullet 모두 충족 → *얕은 → 깊은 진척*. 측정: 다음 self-evaluation (spec 015) 에서 F5 깊은 진척으로 분류
- `test.sh` 의 검증 항목 16 → 17 (ratchet_sections 추가). 측정: `./test.sh` 출력 라인 수
- **양방향 학습 구조가 hard 강제됨** — 측정: `templates/AGENTS.md` 에서 4 섹션 중 1개라도 제거 시 `./test.sh` FAIL + exit 1 (음의 테스트로 검증)

## Done means (완료 정의)

- [ ] `templates/AGENTS.md` 의 Ratchet 영역에 3 신규 섹션 추가 (`## 검증된 패턴` + `## 운영자가 가르친 것` + `## 운영자에게 보여준 가능성`), 각각 작성 가이드 + 단방향 누적 원칙 명시
- [ ] `commands/fde-done.md` 의 Ratchet 단계 (현재 step 6) 가 4 방향 질문:
  - "다시는 일어나면 안 되는 실수?" → `## 절대 하지 말 것`
  - "이번에 잘 작동해 다음에도 쓸 패턴?" → `## 검증된 패턴`
  - "Operator 가 가르친 도메인 단어·규칙?" → `## 운영자가 가르친 것`
  - "Operator 가 처음 알게 된 소프트웨어 가능성?" → `## 운영자에게 보여준 가능성`
  - 4 방향 모두 "없으면 '없다' 가 정답" (거짓 반성은 노이즈)
- [ ] `test.sh` 에 `ratchet_sections` 검증 — `templates/AGENTS.md` 가 4 섹션 헤더 (`## 절대 하지 말 것`·`## 검증된 패턴`·`## 운영자가 가르친 것`·`## 운영자에게 보여준 가능성`) 를 *모두* 포함하는지. 1개라도 부재 시 FAIL
- [ ] `./test.sh` ALL PASS (17 검증)
- [ ] 음의 테스트 — `templates/AGENTS.md` 에서 한 섹션 제거 시 `ratchet_sections` FAIL + exit 1, 복구 후 PASS
- [ ] `docs/fde-criteria.md` 의 F5 평가 관련 — 변경 없음 (헌장 § 6.2 — 헌장 변경은 별도 spec). 단 self-evaluation 갱신은 별도 (spec 015)
- [ ] 두 매니페스트 version `0.5.0 → 0.6.0` (minor — forcing function 강제 추가)

## Out of scope (안 하는 것)

- **양방향 학습의 *실제 수집* hard 강제** — 헌장 § 2.F5 의 "범위 밖" 이 명시: *"진짜로 가르쳐졌는지 — 영속화 ≠ 학습"*. 도구는 *구조 존재* 만 hard 강제, *매 사이클 진짜 수집* 은 soft (prompt). 이 한계는 헌장이 이미 인정
- **F4·F3·F2·F1 강화** — 본 spec 은 F5 만. 다른 forcing function 은 별도 spec
- **PreToolUse/Stop hook 으로 done.log 차단** — 더 강한 강제 (Ratchet 없이 done 차단). 본 spec 은 *구조 강제* 까지. 더 강한 process 강제는 누적 회고 데이터 후 (헌장 § 6.3 의 hard guard 메커니즘)
- **self-evaluation 재실행** — 본 PR 머지 후 별도 (spec 015)
- **사용자 프로젝트의 AGENTS.md 4 섹션 강제** — 본 spec 은 *plugin 의 template* 만. 사용자 프로젝트 검증은 `/fde-init` 시점 또는 별도

## Context (참고 자료)

- 직전 검토 — "13 spec 동안 forcing function 0 깊은 진척 + 0 hard 강제"
- 헌장 § 2.F5 — 양방향 학습의 3 bullet + 범위 밖 (수집 강제 불가 인정)
- 헌장 § 5.2 — 깊은 진척 1개 = FDE proper 까지 2개 남음
- 직전 self-evaluation (spec 012) — 후보 B (F5 양방향) 추천 우선순위 2
- 기존 자산: `monthly-review-template.md`·`daily-ratchet-template.md`·`fde-daily.md` 가 이미 4 섹션 *참조* — 본 spec 이 그 *실체* (AGENTS.md 4 섹션) 를 만듦

## Open questions (불명확한 점)

- **4 섹션의 *내용 검증*** — test.sh 가 *헤더 존재* 만 검증. *섹션이 실제 비어있지 않은지* 는 검증 안 함 (초기엔 비어있는 게 정상). 차후 사용 데이터 누적 시 "N개월 후에도 양의 학습 0건이면 경고" 같은 검증 추가 후보
- **process 강제로의 승격 시점** — 구조 강제 (현재) → process 강제 (done.log 차단) 로의 승격은 헌장 § 6.3 의 누적 회고 임계 (2건) 메커니즘 이용 후보

## Risks (위험 요소)

- **test.sh 의 ratchet_sections 가 *헤더 문자열 매칭* 이라 fragile** — 섹션 제목이 미래에 바뀌면 검증 깨짐. 인지: 검증 실패 시 *명확한 메시지* (어느 섹션 부재) + 제목 변경 시 test.sh 동시 갱신 (AGENTS.md 의 "검증 항목 단방향 증가" 규칙)
- **4 방향 질문이 *과중* 해 /fde-done 이 번거로워짐** — 인지: "없으면 '없다'" 허용으로 마찰 최소화. 매 사이클 4 질문은 *답이 없어도 묻는 것 자체* 가 양방향 의식 환기 (헌장 § 2.F5 의 "매 사이클 묻되 답 없음 허용" — § 7.3 보수적 가이드)
- **깊은 진척 1개로 등급 변화 없음** (FDE proper 까지 3개 필요) — 인지: 본 spec 의 가치는 *등급* 이 아니라 *첫 hard 강제 증명*. 등급은 후속 2개 더 후

## Rollback plan (롤백 계획)

- `templates/AGENTS.md` 의 3 신규 섹션 제거 (단 *단방향 누적* 원칙상 권장 안 함 — 한번 추가한 Ratchet 구조는 제거 금지가 원칙)
- `commands/fde-done.md` 의 4 방향 질문을 1 방향으로 되돌림
- `test.sh` 의 ratchet_sections 검증 제거 (단 "검증 항목 단방향 증가" 규칙 위반 — 권장 안 함)
- 매니페스트 version `0.6.0 → 0.5.0`
- 사용자 영향: 기존 사용자 프로젝트의 AGENTS.md 는 영향 없음 (template 만 변경)

---

## 부록 — 본 spec 의 self-check (헌장 § 6.1 + 부록 A)

```
변경: F5 양방향 학습 깊은 진척 (첫 forcing function hard 강제)
spec: specs/014-f5-deep.md

진척 평가:
  F1 (co-location)         ⬛ 진척 없음  ☑ 의식적 보류
  F2 (속도)                 ⬛ 진척 없음  ☑ 의식적 보류
  F3 (우선순위)             ⬛ 진척 없음  ☑ 의식적 보류
  F4 (operator 언어)        ⬛ 진척 없음  ☑ 의식적 보류
  F5 (양방향 학습)          ☑ 깊은 진척 ⭐ — 3 bullet 모두 충족:
     bullet 1 (양방향 수집): /fde-done 4 방향 질문 ✅
     bullet 2 (영속화·단방향): AGENTS.md 4 섹션 + test.sh hard 강제 ✅
     bullet 3 (음+양 둘 다): 4 섹션 (음·양·도메인·가능성) ✅

3-Actor Model 영향:
  ☑ 책임 분리 위반 가능성 없음 — 4 방향 질문이 Echo(Operator)→Delta
     (도메인) 와 Delta→Echo (가능성) 의 *양방향* 을 명시. 3-Actor 강화

의식적 보류 사유:
  본 spec 은 *F5 1개* 에 집중 — 직전 검토의 "구조만 쌓지 말고 깊이
  하나" 권고 직접 적용. F1·F2·F3·F4 는 별도 사이클. 한 번에 하나씩
  깊게 가는 게 "13 spec 0 깊은 진척" 의 반복을 피하는 길.

집계: 깊은 진척 1개 (F5) + 얕은 진척 0 + 의식적 보류 4 + 우연한 미진척 0

판정:
  ☑ 머지 가능 — *깊은 진척 ≥ 1* (헌장 부록 A 의 머지 가능 기준)
  근거: 첫 깊은 진척 + 첫 forcing function hard 강제. FDE proper 까지
       깊은 진척 2개 남음. 이 spec 이 "설명하는 도구 → 강제하는 도구"
       전환의 첫 증거.
```
