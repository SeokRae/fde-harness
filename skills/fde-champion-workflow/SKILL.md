---
name: fde-champion-workflow
description: FDE 챔피언 모드 (6개월~1년+ 사이클) 의 자동 트리거·의식 오케스트레이션. 사용자가 "champion 인수", "Long-term", "6개월 후", "월간 리뷰", "내가 떠난 후", "고객측 챔피언" 을 언급하거나, `graduation/` 폴더가 있는 상태에서 챔피언 의식을 시작할 때 자동으로 트리거됩니다. 스플릿·딥다이브 모드 키워드 감지 시 본 스킬 비활성 권장.
---

# FDE Champion Workflow Skill — 챔피언 모드 전용

> **모드**: 챔피언 (Champion). 헌장 [`docs/fde-criteria.md`](../../docs/fde-criteria.md) § 1.4 의 3 모드 중 *6개월~1년+ 사이클* 전용.
>
> **다른 모드는 본 스킬의 범위 밖**:
> - 스플릿 (며칠~2주) — 본 도구 미지원 (헌장 § 7.2)
> - 딥다이브 (1-3개월) — [`fde-workflow`](../fde-workflow/SKILL.md) 활성

이 스킬은 FDE *챔피언 모드* 의 의식을 AI 코딩 에이전트의 작업 루프로 구현합니다. *transfer 한 시점만* 의식인 graduation 외에 *월간 리듬* 까지 포함.

## 챔피언 모드의 3 페이즈

```
1. Long-term SME 형성       │ 6개월 단위. 도메인 SME 됨, 패턴 누적
   └─ /fde-monthly-review     매월 진척·KPI·champion 후보 점검

2. Champion 식별 + Pair      │ Champion 후보 등장 시점부터
   └─ /fde-monthly-review     매월 페어 페이즈 진척 추적
   └─ (graduation 양식 의 페어 페이즈 슬롯 활용)

3. Graduation + Departure   │ Champion 자체 유지 가능 신호 발생 시
   └─ /fde-graduate          transfer 양식 생성 + 인수 일정
   └─ (4 페이즈 진행: shadow → pair → solo → departure)
```

## 기본 원칙 (챔피언 모드 한정)

1. **시간 단위 = 월** — 딥다이브 (주) 나 스플릿 (일) 과 다름. 매월 리뷰가 핵심 의식
2. **F4·F5 가 최대 강도** — operator 언어로 KPI 측정·양방향 학습 (도메인 + 가능성) 영속화
3. **F1·F2·F3 약화 OK** — 신뢰 형성된 단계라 *주 1-2일 옆에 + 비동기* 로 충분. 우선순위는 *고객측 champion 이 운영*

## 의식 가이드라인

### 월간 리뷰 (`/fde-monthly-review`)

매월 1회. 다음 4 항목 점검:

```
1. 지난 달 머지된 spec — outcome 측정·가설 검증 (F4·⑥)
2. KPI 변화 — operator 단위로 (분 절약·오류 감소·결정 정확도 등)
3. Champion 후보 평가 — 누가 도메인 흡수 진척 중인가?
4. 차후 한 달 우선순위 — operator 가 다음에 무엇 원하나
```

자동 채움: AI 가 git log·`.harness/done.log`·`AGENTS.md` 변경 누적 → template 의 *지난 달 진척* 섹션
수동 채움: KPI 측정값·champion 후보 평가는 *사람이 직접* (헌장 § 1.2 의 "AI = Echo 의 대리" 위반 방지)

### Graduation (`/fde-graduate`)

Champion 후보가 *자체 유지 가능* 신호 보일 때:
- 페이즈 1 (shadow): champion 이 옆에서 본다
- 페이즈 2 (pair): champion 이 *함께 한다*
- 페이즈 3 (solo): champion 이 *주도, Engineer 는 본다*
- 페이즈 4 (departure): Engineer 가 *떠난다*

각 페이즈 일자·기준은 `templates/graduation-template.md` 참조.

## 모드 외 사용 안내

사용자 메시지에 *다른 모드 키워드* 가 보이면 본 스킬은 비활성 권장:

- **스플릿 키워드**: "스프린트", "데일리", "movable demo", "며칠 안에" → [`fde-sprint-workflow`](../fde-sprint-workflow/SKILL.md) 활성 (spec 013 부터).
- **딥다이브 키워드**: "spec 구현", "다음 spec", "딥다이브 사이클", "Done means" → [`fde-workflow`](../fde-workflow/SKILL.md) 활성. 본 스킬은 *모드가 챔피언 일 때* 만 작동.

## 트리거 키워드

다음 표현이 사용자 메시지에 나오면 이 스킬을 적용한다 (챔피언 모드 가정):

- "champion 인수", "Long-term", "6개월 후", "1년 후"
- "월간 리뷰", "monthly review", "/fde-monthly-review", "/fde-graduate"
- "내가 떠난 후", "고객측 챔피언", "후임자 transfer"
- "domain SME", "도메인 전문가 됨"
- 모드 명시 — "챔피언", "Champion"
- `graduation/` 폴더가 존재하는 작업 환경

**다른 모드 키워드 감지 시 본 스킬 비활성** — 위 § "모드 외 사용 안내" 참조.

## 관련 헌장 섹션

- [`docs/fde-criteria.md`](../../docs/fde-criteria.md) **§ 1.4** — 3 모드 정의 + 챔피언 모드 지원 현황
- [`docs/fde-criteria.md`](../../docs/fde-criteria.md) **§ 2.F5** — 양방향 학습 (챔피언 모드에서 최대 강도)
- [`docs/fde-criteria.md`](../../docs/fde-criteria.md) **§ 7.2** — 본 도구 챔피언 모드 부분 → 거의 완전 (spec 011)

## 관련 스킬

- [`skills/fde-workflow`](../fde-workflow/SKILL.md) — 딥다이브 모드. 챔피언 진입 *전* 의 사이클 (1-3개월). 6개월+ 누적 시 본 스킬로 전환
- [`skills/discovery-echo`](../discovery-echo/SKILL.md) — 딥다이브의 Discovery 단계 보조. 챔피언 모드에서는 *후임자 transfer* 로 의미 전환

## 관련 슬래시 커맨드

- `/fde-monthly-review` — 월간 리뷰 양식 생성 (`monthly-reviews/{YYYY-MM}.md`)
- `/fde-graduate <champion>` — Champion 인수 양식 생성 (`graduation/{날짜}-{champion}.md`)
