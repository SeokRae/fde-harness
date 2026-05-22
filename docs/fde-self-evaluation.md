# fde-harness 자기평가 — v0.2.0

> **평가 시점**: main HEAD `9625b69` (PR #22 머지 직후)
> **헌장 버전**: PR #22 적용 (3-Tier 등급 + 강제 정의 명시)
> **평가 양식**: [`docs/fde-criteria.md`](fde-criteria.md) § 6.1 + 부록 A
> **이 문서의 역할**: 헌장 § 5.4 의 "평가 결과 공개" 의무 — 외부 사용자가 "왜 이 등급인지" 확인하는 단일 진실 공급원

## § 1. 평가 시점

| 항목 | 값 |
|------|---|
| commit SHA | `9625b69ce2ed3f16097ef1d787d67779bebea79d` (PR #22 머지 직후) |
| 머지된 spec | 001, 002, 003, 005, 007 (006 은 미머지 — 별도 결정 예정) |
| 머지된 PR | #11, #13, #15, #18, #19, #20, #21, #22 |
| 헌장 적용 버전 | PR #22 — 3-Tier 등급 + § 5.1 강제 정의 + § 7 미해결 보수적 가이드 |

## § 2. F1-F5 진척 평가

### F1 Co-location with Operator — 🟡 얕은 진척

| § 2.F1 의 본 도구가 강제해야 하는 것 (3 bullet) | 충족 | 근거 |
|---|---|---|
| spec 의 본문은 직접 관찰된 증거에 닻을 내려야 — 기억·전언·추정만으로 작성된 spec 은 FDE 아님 | ❌ | `discovery-echo` 가 노트→draft 흐름 제공하지만 `/fde-spec` 으로 노트 없이 spec 직접 생성 가능 — *강제 아님* |
| *말* 과 *행동* 이 spec 안에서 구분되어야 | ✅ | `templates/note-template.md` 의 `## What user said` (말) + `## Observed behavior` (행동) 분리 |
| 증거 없는 가정은 명시적으로 *가정* 으로 표시 | ✅ | `discovery-echo` 5가지 규칙 #4 + `spec-template.md` 의 `## Open questions` 슬롯 |

→ 2/3 bullet 충족, 1/3 미충족 → **얕은 진척**.

### F2 Days-not-months Cycle — ⬛ 진척 없음

| § 2.F2 의 본 도구가 강제해야 하는 것 (3 bullet) | 충족 | 근거 |
|---|---|---|
| spec 에 시간 한계 — 무기한 spec 은 FDE 아님 | ❌ | `spec-template.md` 에 deadline 슬롯 없음 |
| 시간 한계 초과 시 가설 재확인 의식 강제 | ❌ | 메커니즘 없음 |
| 사이클 진척이 시간 단위로 가시화 | ❌ | open spec 의 나이 추적·표시 도구 없음 |

→ 0/3 → **진척 없음** (우연한 미진척 — 이전 spec 에 의식적 보류 명시 없음).

### F3 Operator Ownership of Priority — ⬛ 진척 없음

| § 2.F3 의 본 도구가 강제해야 하는 것 (3 bullet) | 충족 | 근거 |
|---|---|---|
| 다음 작업 선택의 판단 근거가 가치 + 시간 | ❌ | `commands/fde-plan.md` line 11: "가장 작은 번호" — FIFO |
| 선택 메커니즘이 추적 가능 | ❌ | done.log 는 *순서* 만 추적, *왜 그 spec* 인지 근거 없음 |
| 우선순위 변경은 Operator 발화에 근거 | ❌ | 우선순위 변경 메커니즘 자체 없음 |

→ 0/3 → **진척 없음**.

### F4 Operator's Language for Value — ⬛ 진척 없음

| § 2.F4 의 본 도구가 강제해야 하는 것 (3 bullet) | 충족 | 근거 |
|---|---|---|
| 가치 진술이 Operator 의 정량 단위 사용 | ❌ | `spec-template.md` 의 `## Why` 가 자유 텍스트 — 단위 강제 없음 |
| Engineer 단위는 가치로 인정되지 않음 | ❌ | 거부 메커니즘 없음 — LOC·테스트커버리지 등 입력 가능 |
| 도구의 모든 예시·placeholder 가 Operator 언어 | ❌ | `note-template.md` Stated value 예시는 Operator 언어 ✓, 그러나 `spec-template.md` 의 Why 가이드는 일반 ("ROI 또는 페인포인트") — 불완전 |

→ 일관된 강제 메커니즘 부재 → **진척 없음**.

### F5 Two-way Knowledge Flow — 🟡 얕은 진척

| § 2.F5 의 본 도구가 강제해야 하는 것 (3 bullet) | 충족 | 근거 |
|---|---|---|
| 사이클마다 양방향 학습 수집 | ❌ | `commands/fde-done.md` Ratchet 단계가 "다시는 일어나면 안 되는 실수" 만 묻고 *양의 학습* 안 묻음 — 비대칭 |
| 학습은 영속화·단방향 누적 | ✅ | `templates/AGENTS.md` 의 `## 절대 하지 말 것` — 영속화 ✓·단방향 ✓ (제거 금지 명시) |
| 음의 학습과 양의 학습이 둘 다 수집 | ❌ | 양의 학습 영속화처(`## 검증된 패턴` 등) 자체 없음 |

→ 1/3 bullet 충족 → **얕은 진척**.

## § 3. 공통 조건 (§ 5.3) 평가

| 조건 | 충족 | 근거 |
|---|---|---|
| 3-Actor Model 책임 분리가 도구 안에서 명시됨 | ✅ (본 PR 후) | `templates/AGENTS.md` 의 "두 역할" 을 "세 역할 (Echo · Delta · AI)" 로 갱신 — 본 spec 008 의 변경 포함 |
| 가치 사이클 § 3 의 측정 단계가 추적 가능 (Done means ≠ 가치 검증 명시) | ✅ | 헌장 § 3 자체가 명시 — *Done means 통과는 구현의 검증이지 가치의 검증이 아니다* |
| 본 문서가 README 에서 명시적으로 링크됨 | ✅ (본 PR 후) | 본 spec 008 이 README 에 `docs/fde-criteria.md` + `docs/fde-self-evaluation.md` 링크 추가 |

→ 본 PR 머지 후 **3/3 충족**.

## § 4. 자동 등급 결정

```
강제 (얕은+깊은 합산):     2개 (F1·F5)
깊은 진척:                 0개
공통 조건 (§ 5.3):        3/3 충족 (본 PR 머지 후)

§ 5.2 표 적용:
  FDE proper        깊은 진척 ≥ 3       → ❌
  FDE-inspired      강제 ≥ 2 + 공통 조건 → ✅
  이름에서 FDE 제외   강제 ≤ 1            → 해당 없음
```

→ **자동 결정 등급: FDE-inspired**

## § 5. 다음 사이클의 강화 후보 — FDE proper 승격 경로

현재 → FDE proper 까지 필요: *깊은 진척 3개*. 다음 사이클부터 한 묶음씩 강화하는 후보:

### 후보 B — F5 깊은 진척 (양방향 학습) ⭐ 추천 우선순위 1

- `templates/AGENTS.md` 의 4-섹션 구조: `## 절대 하지 말 것` + `## 검증된 패턴` + `## 운영자가 가르친 것` + `## 운영자에게 보여준 가능성`
- `commands/fde-done.md` Ratchet 단계의 양방향 4 질문 (음·양·도메인·가능성)

→ 비용: ~30 줄. 가장 작음.
→ 3 bullet 모두 충족 → **깊은 진척 1개**.

### 후보 A — F4 깊은 진척 (Operator 언어)

- `spec-template.md` 에 `## Expected outcome` 슬롯 + Operator 정량 단위 백색 목록 (분·오류·결정·환자·고객 이탈률 등)
- Engineer 단위 (LOC·story point·테스트커버리지) 명시적 거부
- 모든 예시·placeholder 를 Operator 언어로 통일

→ 비용: ~40 줄. spec 구조 변경.
→ 3 bullet 모두 충족 → **깊은 진척 1개**.

### 후보 C — F3 깊은 진척 (Operator 우선순위)

- `/fde-plan` 의 다음 spec 선택 기준을 Expected outcome (F4 의존) × deadline (F2 의존) 으로 변경
- 선택 시 *근거 보고* — "이 spec 을 고른 이유"
- 우선순위 변경 시 Operator 인용 슬롯 강제

→ 비용: F4 + F2 선결. 의존 chain 큼.
→ 3 bullet 모두 충족 → **깊은 진척 1개**.

### 후보 D — F1 깊은 진척 (Co-location)

- `discovery-echo` 노트 흐름을 *기능 spec* 의 *필수 선행* 으로 강제
- spec template 에 observation evidence 링크 슬롯 필수
- "기억 으로 spec 작성" 거부 메커니즘

→ 비용: 모든 새 spec 의 작성 시점 강제. 큰 흐름 변경.
→ 3 bullet 모두 충족 → **깊은 진척 1개**.

### 후보 E — F2 깊은 진척 (속도)

- spec frontmatter 에 deadline 필수
- `/fde-status` 신규 — open spec 들의 나이·deadline 표시
- 주간 의식 (헌장 § 7.3 의 보수적 가이드 — 14일 임시 한계)

→ 비용: 메이커 사용 패턴 분석 필요. 가장 깊은 변경.
→ 3 bullet 모두 충족 → **깊은 진척 1개**.

### 추천 순서

```
B (F5 양방향)  →  A (F4 단위)  →  C (F3 우선순위)  →  D (F1 증거)  →  E (F2 속도)

  ↑ 비용 작음                                     비용 큼 ↑
  ↑ 의존 없음                                     의존 많음 ↑
```

3개 깊은 진척 달성 = FDE proper. 추천 경로(B+A+C) 는 3-4 사이클 분량.

## § 6. 갱신 규칙

본 문서는 헌장 § 5.4 의 "평가 결과 공개" 의무에 따라 공개된다.

**다음 평가 시점**: 다음 사이클의 시작 시 (예: spec 009 머지 직후). § 5.4 의 "다음 사이클 시작 시 재평가" 룰 따름.

**갱신 정책**:
- 평가 결과 변경 시 본 문서 갱신 + git history 보존
- 등급 *상승* (FDE-inspired → FDE proper) 시 즉시 매니페스트 description 동기 (§ 5.2 + § 5.4)
- 등급 *하강* 시 (사용 패턴 약화·F# 후퇴) — 즉시 description 내리지 않으나 다음 사이클 시작 시 재평가 후 결정

---

## 참고

- 본 평가의 spec: [`../specs/008-self-evaluation.md`](../specs/008-self-evaluation.md)
- 헌장 (SSoT): [`docs/fde-criteria.md`](fde-criteria.md)
- 사이클 흐름 (SSoT): [`docs/cycle-guide.md`](cycle-guide.md)
- 다음 강화 후보 spec (추천 B): `specs/009-...` (예정)
