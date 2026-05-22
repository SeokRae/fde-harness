# Spec ID: 011 — 챔피언 모드 스킬 신규 + 월간 리뷰 의식

> spec 009 가 챔피언 모드의 *transfer 자산 1개* (`/fde-graduate`) 만 추가한 상태. 본 spec 은 챔피언 모드의 *오케스트레이션 스킬* 과 *월간 리듬 의식* 을 추가해 챔피언 모드 커버리지를 *부분 (0.5)* → *거의 완전 (0.85)* 으로 끌어올린다.

## What (무엇을)

세 가지 신규 자산 한 묶음:

1. **`skills/fde-champion-workflow/SKILL.md` 신규** — 챔피언 모드의 자동 트리거·의식 오케스트레이션 스킬. 트리거 키워드: "Long-term", "champion", "6개월 후", "월간 리뷰" 등.
2. **`commands/fde-monthly-review.md` 신규** — 월간 리듬 의식. 한 달 단위 진척·KPI·champion 후보 점검.
3. **`templates/monthly-review-template.md` 신규** — 월간 리뷰 결과 양식 (지난 달 진척·열린 도메인 질문·champion 후보 평가·차후 한 달 우선순위).

추가 동기 갱신:
- `skills/fde-workflow/SKILL.md` — 챔피언 모드 키워드 감지 시 *fde-champion-workflow 활성* 안내 추가
- `skills/discovery-echo/SKILL.md` — 챔피언 모드에서 본 스킬 약화 안내 (이미 spec 010 에 있음, 보강만)
- `README.md` — 8 commands, 5 templates, 3 skills 갱신 + 챔피언 부분 → 거의 완전 표기
- `docs/fde-criteria.md` § 1.4 — 챔피언 행 *부분 0.5* → *거의 완전 0.85* 갱신
- `templates/AGENTS.md` — 모드 표의 챔피언 행 갱신 (monthly-review 추가)
- 두 매니페스트 — `version 0.3.0 → 0.4.0` (minor — 새 스킬 capability)
- `test.sh` — `skills_count` 2 → 3, `EXPECTED_COMMANDS` 7 → 8, `templates_present` 4 → 5

## Why (왜) — 비즈니스 가치

PR #24 가 챔피언 모드의 *진입* (graduation transfer) 만 자산화. 그러나 챔피언 모드는 *6개월~1년+* 의 *지속* 모드 — *월간 리듬* 이 핵심. 현재 도구는 *transfer 한 시점* 만 지원하고 *그 사이 6개월* 의 의식이 없음.

세 가지 문제 해결:

1. **챔피언 모드 *지속 의식* 부재** — 월간 리뷰 없이 6개월이 *블랙박스* 됨. KPI 변화·도메인 학습·champion 후보 식별이 *우연* 에 맡겨짐
2. **자동 트리거 부재** — 사용자가 "champion 평가해줘" 라고 해도 어느 스킬·커맨드도 활성화 안 됨 (graduation 만 직접 호출). 모드 인식의 *자동 환기* 부재
3. **헌장 § 5.3 공통 조건 약화** — 현재 도구가 *모드 명시* 만 하고 *모드 의식* 은 부족. 본 spec 으로 의식 자산 추가 → § 5.3 의 의도 더 정확히 충족

## Expected outcome (정량)

- 본 PR 후 챔피언 모드 자산 *1 → 4* — graduate + monthly-review + skill + template. 측정: `find commands skills templates | grep -c -E "champion|graduate|monthly-review"` 이전 2 → 이후 5
- 본 PR 후 챔피언 모드 키워드 ("champion 인수·6개월·월간 리뷰") 시 *자동 스킬 활성* — 측정: 트리거 키워드 한 번에 본 신규 스킬 활성
- 본 PR 후 헌장 § 1.4 의 챔피언 행 *부분 (graduation 만) → 거의 완전 (graduation + monthly review)* — 측정: 헌장 표 grep

## Done means (완료 정의)

### 신규 자산 (3)

- [ ] `skills/fde-champion-workflow/SKILL.md` 존재 — 챔피언 모드 트리거·의식 오케스트레이션. 본문 구조:
  - 모드 명시 헤더 (헌장 § 1.4 link)
  - 챔피언 모드의 *3 페이즈* (Long-term SME → Champion 식별·Pair → Graduation·Departure)
  - 각 페이즈의 주된 의식 (월간 리뷰 → 페어 페이즈 → graduation note)
  - 트리거 키워드 (champion·Long-term·6개월·월간 리뷰·SME)
  - 모드 외 사용 안내 (스플릿/딥다이브 키워드 감지 시 본 스킬 비활성)
  - 관련 헌장 섹션 + 관련 스킬 cross-link
- [ ] `commands/fde-monthly-review.md` 신규 — `/fde-monthly-review` 호출 시 `templates/monthly-review-template.md` 기반 `monthly-reviews/{YYYY-MM}.md` 생성. AI 가 자동 채울 부분 (지난 달 머지된 spec·outcome·AGENTS.md 누적 학습) + 사람이 채울 부분 (KPI 측정·champion 후보 평가·차후 우선순위) 분리
- [ ] `templates/monthly-review-template.md` 신규 — 6 섹션 (메타·진척 요약·KPI·도메인 학습·champion 후보·차후 우선순위)

### 동기 갱신 (3 모드 동기 + 컴포넌트 카운트)

- [ ] `skills/fde-workflow/SKILL.md` — *모드 외 사용 안내* 의 챔피언 키워드 행에 *fde-champion-workflow 활성* 안내 추가
- [ ] `skills/discovery-echo/SKILL.md` — 챔피언 모드 약화 안내가 *fde-champion-workflow* link 포함
- [ ] `README.md` — 컴포넌트 표 (3 skills · 8 commands · 5 templates) + 모드 지원 표 (챔피언 행: 부분 → 거의 완전)
- [ ] `templates/AGENTS.md` 의 모드 표 — 챔피언 행에 monthly-review 추가
- [ ] `docs/fde-criteria.md` § 1.4 — 본 도구 현재 모드 지원의 챔피언 행 *부분 0.5 → 거의 완전 0.85*

### 매니페스트 + 검증

- [ ] `.claude-plugin/plugin.json` — version `0.3.0 → 0.4.0` + description 갱신 (챔피언 모드 *부분 → 거의 완전*)
- [ ] `.codex-plugin/plugin.json` — 동기 + interface 갱신
- [ ] `marketplace.json` — shortDescription 갱신
- [ ] `test.sh` — `skills_count` 2 → 3 / `EXPECTED_COMMANDS` 7 → 8 / `templates_present` 4 → 5 (monthly-review-template 추가)
- [ ] `./test.sh` ALL PASS (14/14)
- [ ] GitHub Actions check success

## Out of scope (안 하는 것)

- **KPI 통합 추적** — `/fde-kpi-link` 같은 자동 KPI 연결 자산. 본 PR 은 *수동 측정 양식만*, 자동 통합은 별도 spec
- **Mentor pair 페이즈 별도 의식** — graduation 양식의 *페어 페이즈 슬롯* 으로 충분, 별도 커맨드 ❌
- **챔피언 모드 *완전* 지원** — 0.85 → 1.0 까지의 잔여 0.15 (예: champion 인증·SME 평가) 는 별도 spec
- **스플릿 모드 스킬 신규** — 별도 spec (후보 Y)
- **F# 깊은 진척** — 본 spec 은 *모드 커버리지* 만 강화, F# 강도 강화는 별도 (후보 Z)
- **self-evaluation 재실행** — 본 PR 머지 후 별도 spec

## Context (참고 자료)

- 직전 사이클 spec 009 — 챔피언 모드 *시작 자산* (graduation) 만 추가
- 헌장 § 1.4 — 챔피언 모드 정의 + 현재 부분 지원 명시
- 헌장 § 5.3 — 모드 명시 + 모드 의식 의무
- 영향 파일: ~10개 (신규 3 + 동기 7)

## Open questions (불명확한 점)

- **월간 리뷰의 *자동 채움 범위*** — AI 가 지난 달 outcome.log 까지 자동 요약? 본 spec 은 *spec 머지 목록·AGENTS.md 변경* 까지만 자동. outcome.log 는 미구현 (다음 사이클)
- **챔피언 모드 *시작 시점* 의 신호** — 본 도구는 *명시적 모드 전환* 만 지원 (`AGENTS.md` 의 mode 슬롯 변경). 자동 감지 미지원 (예: 사이클 6개월 누적 시)

## Risks (위험 요소)

- **새 스킬의 트리거 키워드가 기존 두 스킬과 겹침** — "discovery"·"workflow" 같은 일반 키워드는 *fde-workflow* 가 흡수. 본 신규 스킬은 *champion·Long-term·monthly 등 모드 한정 키워드* 만 트리거. 인지: 머지 후 실제 사용에서 트리거 충돌 모니터링
- **월간 리뷰 양식이 *너무 과중* 해 사용 안 함** — 6개월 = 6 회 양식 채우기. 인지: 본 spec 의 monthly-review 는 *필수 슬롯 최소화* (자동 채움 우선), 점진 정제
- **챔피언 모드가 *현실에서 적용* 안 됨** — 1인 메이커는 *고객측 champion* 자체가 없음. 인지: 본 도구의 챔피언 모드는 *team-level usage* 가정 — README 에 명시

## Rollback plan (롤백 계획)

- 신규 3 자산 (skill + command + template) 삭제
- 동기 갱신 git revert
- 매니페스트 version `0.4.0 → 0.3.0`
- `test.sh` 의 카운트 되돌림
- 사용자 영향: 챔피언 모드 사용자는 `/fde-graduate` 만 남음 (v0.3.0 상태로 복원)

---

## 부록 — 본 spec 의 self-check (헌장 § 6.1 + 부록 A)

```
변경: 챔피언 모드 스킬 신규 + 월간 리뷰 의식
spec: specs/011-champion-skill.md

진척 평가:
  F1 (co-location)         ⬛ 진척 없음  ☑ 의식적 보류
  F2 (속도)                 ⬛ 진척 없음  ☑ 의식적 보류 (월간 리듬은 챔피언 모드 한정)
  F3 (우선순위)             ⬛ 진척 없음  ☑ 의식적 보류 (별도 spec)
  F4 (operator 언어)        ⬛ 진척 없음  ☑ 의식적 보류 (별도 spec)
  F5 (양방향 학습)          ⬛ 진척 없음  ☑ 의식적 보류 (별도 spec)

3-Actor Model 영향:
  ☑ 책임 분리 위반 가능성 없음 — graduation·monthly review 모두 Engineer
     가 champion 에게 transfer 하는 의식 (Echo ≠ AI 분리 강화)

의식적 보류 사유:
  본 spec 은 *F# 진척* 이 아니라 *모드 커버리지 세로축* 강화. 헌장 § 5.2
  2차원 표의 세로 한 칸 (모드 1.5 → 2.0+) 이동. F# 강화는 별도 사이클.

집계: 깊은 진척 0 + 얕은 진척 0 + 의식적 보류 5 + 우연한 미진척 0

판정:
  ☑ 머지 가능
  근거: 모드 커버리지 진척 — 챔피언 0.5 → 0.85. 헌장 § 1.4 의 약속을
       *실제 도구 자산* 으로 메움.
```
