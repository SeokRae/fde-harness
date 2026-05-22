# fde-harness 자기평가 — v0.4.0

> **평가 시점**: main HEAD `6c049f1` (PR #26 머지 직후)
> **헌장 버전**: PR #22 + #24 적용 (2-차원 등급 + 3 모드 정의)
> **평가 양식**: [`docs/fde-criteria.md`](fde-criteria.md) § 6.1 + 부록 A
> **이 문서의 역할**: 헌장 § 5.4 의 "평가 결과 공개" 의무 — 외부 사용자가 "왜 이 등급인지" 확인하는 단일 진실 공급원

## § 1. 평가 시점

| 항목 | 값 |
|------|---|
| commit SHA | `6c049f15a98a9c9b606f73793cdb7fc15b4289c1` (PR #26 머지 직후) |
| 머지된 spec | 001·002·003·004·005·007·008·009·010·011 (006 은 미머지 — 별도 결정 예정) |
| 머지된 PR (이번 갱신 사이클) | #21·#22·#23·#24·#25·#26 (헌장 등록부터 챔피언 스킬까지) |
| 헌장 적용 버전 | PR #22 (2-차원 등급) + PR #24 (3 모드 정의) |

## § 2. F1-F5 진척 평가

### F1 Co-location with Operator — 🟡 얕은 진척

| § 2.F1 의 본 도구가 강제해야 하는 것 (3 bullet) | 충족 | 근거 |
|---|---|---|
| spec 의 본문은 직접 관찰된 증거에 닻을 내려야 — 기억·전언·추정만으로 작성된 spec 은 FDE 아님 | ❌ | `discovery-echo` 가 노트→draft 흐름 제공하지만 `/fde-spec` 으로 노트 없이 spec 직접 생성 가능 — *강제 아님* |
| *말* 과 *행동* 이 spec 안에서 구분되어야 | ✅ | `templates/note-template.md` 의 `## What user said` (말) + `## Observed behavior` (행동) 분리 |
| 증거 없는 가정은 명시적으로 *가정* 으로 표시 | ✅ | `discovery-echo` 5가지 규칙 #4 + `spec-template.md` 의 `## Open questions` 슬롯 |

→ 2/3 → **얕은 진척** (변화 없음).

### F2 Days-not-months Cycle — ⬛ 진척 없음 (모드 한정 진척 가능성 — § 7 미해결 후보)

| § 2.F2 의 본 도구가 강제해야 하는 것 (3 bullet) | 충족 | 근거 |
|---|---|---|
| spec 에 시간 한계 — 무기한 spec 은 FDE 아님 | ❌ | `spec-template.md` 에 deadline 슬롯 없음 |
| 시간 한계 초과 시 가설 재확인 의식 강제 | ❌ | 메커니즘 없음 |
| 사이클 진척이 시간 단위로 가시화 | 🟡 챔피언 모드만 | `/fde-monthly-review` 가 *챔피언 모드의 월 단위 가시화* 제공 (spec 011). 그러나 *딥다이브 모드* 에서는 여전히 부재 |

→ 모드 무관 평가는 0/3 → **진척 없음** (보수적). 챔피언 모드 한정으로 *부분* 진척 — 헌장 § 5.2 표가 모드별 평가를 *별도 정밀화* 할지는 미해결 큐 후보.

### F3 Operator Ownership of Priority — ⬛ 진척 없음 (변화 없음)

| § 2.F3 의 본 도구가 강제해야 하는 것 (3 bullet) | 충족 | 근거 |
|---|---|---|
| 다음 작업 선택의 판단 근거가 가치 + 시간 | ❌ | `commands/fde-plan.md` line 11: "가장 작은 번호" — FIFO |
| 선택 메커니즘이 추적 가능 | ❌ | done.log 가 *순서* 만 추적, *왜 그 spec* 인지 근거 없음 |
| 우선순위 변경은 Operator 발화에 근거 | ❌ | 우선순위 변경 메커니즘 자체 없음 |

→ 0/3 → **진척 없음**.

### F4 Operator's Language for Value — ⬛ 진척 없음 (월간 리뷰 KPI 슬롯은 부분 신호)

| § 2.F4 의 본 도구가 강제해야 하는 것 (3 bullet) | 충족 | 근거 |
|---|---|---|
| 가치 진술이 Operator 의 정량 단위 사용 | ❌ | `spec-template.md` 의 `## Why` 가 자유 텍스트 — 단위 강제 없음 |
| Engineer 단위는 가치로 인정되지 않음 | ❌ | 거부 메커니즘 없음 |
| 도구의 모든 예시·placeholder 가 Operator 언어 | 🟡 부분 | `note-template.md` Stated value 예시 + `monthly-review-template.md` KPI 표 예시 ("분석가 보고서 작성 2.5h → 1.8h") 는 Operator 언어 ✓. 그러나 `spec-template.md` 의 Why 가이드는 일반 ("ROI 또는 페인포인트") |

→ 일관된 강제 메커니즘 부재 → **진척 없음**.

### F5 Two-way Knowledge Flow — 🟡 얕은 진척 (변화 없음, 표면 강화)

| § 2.F5 의 본 도구가 강제해야 하는 것 (3 bullet) | 충족 | 근거 |
|---|---|---|
| 사이클마다 양방향 학습 수집 | ❌ | `commands/fde-done.md` Ratchet 단계가 "다시는 일어나면 안 되는 실수" 만 묻고 *양의 학습* 안 묻음 — 비대칭 |
| 학습은 영속화·단방향 누적 | ✅ | `templates/AGENTS.md` 의 `## 절대 하지 말 것` — 영속화 ✓·단방향 ✓ |
| 음의 학습과 양의 학습이 둘 다 수집 | ❌ | 양의 학습 영속화처(`## 검증된 패턴` 등) 자체 없음. *monthly-review-template* 이 *읽기만* 표시 (placeholder), 실제 수집 메커니즘은 부재 |

→ 1/3 bullet 충족 → **얕은 진척**.

## § 3. 공통 조건 (§ 5.3) 평가

| 조건 | 충족 | 근거 |
|---|---|---|
| 3-Actor Model 책임 분리가 도구 안에서 명시됨 | ✅ | `templates/AGENTS.md` 의 "세 역할 (Echo · Delta · AI)" 섹션 (spec 008 부터) |
| 가치 사이클 § 3 의 측정 단계가 추적 가능 (Done means ≠ 가치 검증 명시) | ✅ | 헌장 § 3 자체가 명시 |
| 본 문서가 README 에서 명시적으로 링크됨 | ✅ | README 의 등급 배지에 `docs/fde-self-evaluation.md` link |
| **도구가 지원하는 모드 (§ 1.4) 가 README 와 매니페스트에서 명시** | ✅ | **5 위치 강화** (spec 009·010·011): (a) README 모드 지원 표 (b) 두 plugin.json description (c) marketplace.json shortDescription (d) `templates/AGENTS.md` 모드 표 (e) 3 스킬 본문의 모드 banner |

→ **4/4 충족**.

## § 4. 자동 등급 결정

```
강제 (얕은+깊은 합산):     2개 (F1·F5)
깊은 진척:                 0개
공통 조건 (§ 5.3):        4/4 충족
모드 커버리지:             1.85/3
  ├─ 스플릿:    ❌ (자산 없음)
  ├─ 딥다이브:  ✅ (모든 사이클 자산)
  └─ 챔피언:    🟢 거의 완전 (skill + graduation + monthly-review)

§ 5.2 2-차원 표 적용:
                  F# 강제 0~1    F# 강제 2+     깊은 진척 3+
  모드 < 1.0      이름 제외      FDE-inspired   FDE proper (single)
  모드 1.5~2.5    이름 제외      **FDE-inspired (multi-mode) ← 현재 위치**
  모드 3/3        이름 제외      FDE proper     FDE complete
```

→ **자동 결정 등급: FDE-inspired (multi-mode)** — 모드 커버리지 *증가* 했지만 같은 행 안에 있어 *명명 등급 변화 없음*. 단 description 의 *모드 표기* 가 더 정확해짐 ("딥다이브 + 챔피언 부분" → "딥다이브 + 챔피언 거의 완전").

## § 5. 다음 사이클의 강화 후보 — FDE proper 승격 경로

이번 사이클 갱신 — X (챔피언 스킬) **완료** → 제거. 새 우선순위:

### 후보 Y — 스플릿 모드 스킬 신규 ⭐ 추천 우선순위 1

- `skills/fde-sprint-workflow/SKILL.md` + `/fde-sprint` + `/fde-daily` + 2 templates
- 효과: 모드 커버리지 1.85 → 2.85 (모드 3/3 거의 완성)
- 비용: ~250 줄, 6 신규 자산

→ 본 후보 후 *모드 3/3* 거의 도달 → 헌장 § 5.2 표의 *세로 한 칸 더* 위로.

### 후보 B — F5 깊은 진척 (양방향 학습) ⭐ 추천 우선순위 2

- `templates/AGENTS.md` 4-섹션 (절대 하지 말 것·검증된 패턴·운영자 가르친 것·운영자 가능성)
- `commands/fde-done.md` Ratchet 단계 양방향 4 질문
- 효과: F# 깊은 진척 0 → 1 → FDE proper 까지 2개 남음

→ 비용 작음 (~30 줄). monthly-review-template 이 이미 *읽기* 만 표시하므로 *수집 메커니즘* 만 추가하면 됨.

### 후보 A — F4 깊은 진척 (Operator 언어)

- `spec-template.md` 에 `## Expected outcome` 슬롯 + 단위 강제
- 예시·placeholder 정리
- 비용: ~40 줄

### 후보 C — F3 깊은 진척 (Operator 우선순위)

- A + (E) 의존 — A 먼저 진행 권장

### 후보 D — F1 깊은 진척 (Co-location 증거 강제)

- 모든 새 *기능 spec* 의 *필수 선행* 으로 observation evidence 강제
- 비용 크고 흐름 변경 큼

### 후보 E — F2 깊은 진척 (속도) — 챔피언 모드는 부분 진척 시작

- spec deadline + `/fde-status` + 데일리 또는 주간 의식
- 챔피언 모드 월간 의식 ✅ (spec 011 부터). 딥다이브·스플릿은 미진척

### 추천 순서 갱신

```
Y (스플릿 모드 스킬)   ⭐ 1순위 — 모드 폭 완성, 등급 매트릭스의 세로 진척
B (F5 깊음)            ⭐ 2순위 — 비용 작음 + monthly-review 의 *읽기→쓰기* 자연 연장
A (F4 깊음)            3순위 — Operator 언어 정책
C (F3 깊음)            4순위 — A·E 의존
E (F2 깊음)            5순위 — 모드별 정밀화 필요
D (F1 깊음)            6순위 — 흐름 변경 큼
```

본 PR 머지 후 Y (스플릿) 또는 B (F5 양방향) 어느 쪽도 의미 있는 진척. *모드 폭* vs *F# 강도* 의 선택.

## § 6. 갱신 규칙

본 문서는 헌장 § 5.4 의 "평가 결과 공개" 의무에 따라 공개된다.

**다음 평가 시점**: 다음 사이클의 시작 시 (예: spec 013 머지 직후). § 5.4 의 "다음 사이클 시작 시 재평가" 룰 따름.

**평가 이력**:
- v0.2.0 (`9625b69`) → 처음 평가 — spec 008 (PR #23)
- **v0.4.0 (`6c049f1`) → 본 갱신** — spec 012 (PR #27 예상)
- 다음: spec 013 머지 직후

---

## 참고

- 본 평가의 spec: [`../specs/012-self-evaluation-rerun.md`](../specs/012-self-evaluation-rerun.md)
- 직전 평가 spec: [`../specs/008-self-evaluation.md`](../specs/008-self-evaluation.md)
- 헌장 (SSoT): [`docs/fde-criteria.md`](fde-criteria.md)
- 사이클 흐름 (SSoT): [`docs/cycle-guide.md`](cycle-guide.md)
- 다음 강화 후보 spec (추천 Y): `specs/013-sprint-mode-skill.md` (예정)
