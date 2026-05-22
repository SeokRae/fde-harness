---
name: fde-monthly-review
description: 챔피언 모드의 월간 리듬 의식. 한 달 단위 진척·KPI·champion 후보 평가·차후 우선순위 점검 양식을 생성합니다.
---

# Champion Monthly Review (월간 리뷰 의식)

> **모드**: 챔피언 (헌장 § 1.4). 본 커맨드는 *Long-term 모드 (6개월~1년+)* 의 *지속* 의식.
>
> **언제 사용**: 챔피언 모드 사용 중 매월 1회. 보통 월말 또는 월초 정해진 일자.

## 인자

- `$ARGUMENTS` — 리뷰 대상 월 (선택). 비어있으면 직전 완료 월 사용 (예: 오늘이 2026-06-15 면 `2026-05`)

## 절차

1. **사용자 프로젝트 루트의 `monthly-reviews/` 폴더 보장**
   - 없으면 생성

2. **대상 월 결정**
   - $ARGUMENTS 가 있으면 그것 사용 (`YYYY-MM` 형식)
   - 비어있으면 *직전 완료 월* — 현재 일자 기준 1개월 전 (예: 2026-06-15 → `2026-05`)
   - 동일 월의 리뷰가 이미 있으면 사용자에게 알리고 *덮어쓰기 vs 신규 생성 (suffix)* 선택

3. **자동 채움 데이터 수집**
   - `git log --since="{대상월-01}" --until="{대상월-말일}" --oneline` — 머지된 commit 목록
   - `.harness/done.log` 의 해당 월 entries — 완료 spec 목록
   - `.harness/failure-log` 의 해당 월 entries — 실패 결정 목록
   - `AGENTS.md` 의 해당 월 동안 git diff — Ratchet 누적 변경

4. **`monthly-reviews/{YYYY-MM}.md` 생성**
   - 플러그인의 `templates/monthly-review-template.md` 를 base 로 복사
   - 자동 채움 (위 3 의 데이터): 헤더 (대상 월·작성 일자·Engineer) + § "지난 달 진척 요약" + § "AGENTS.md 누적 학습"
   - 사람이 채울 부분 (placeholder + 안내):
     - § "KPI 측정" (operator 단위 — 분·오류·결정 등)
     - § "Champion 후보 평가"
     - § "차후 한 달 우선순위"

5. **사용자에게 다음을 안내**:
   - 생성된 파일 경로 (절대 경로)
   - **반드시 사람이 직접 채워야 할 빈 슬롯 목록**:
     - KPI 측정값 (자동 채움 ❌ — Operator 의 도메인 단위로 *사람만* 측정)
     - Champion 후보 평가 (사람의 정성 판단)
     - 차후 우선순위 (Operator 발화에 근거)
   - **champion 후보가 식별되면 graduation 의 *페이즈 시작* 검토** — 자동 안내
   - **이 문서가 *6개월간 누적* 되면 그 자체가 champion 의 *학습 자료*** — graduation 시 함께 인수

## 자동 채움의 한계

다음은 *자동 채움 안 함* (헌장 § 1.2 의 "AI = Echo 의 대리" 위반 방지):

- KPI 측정값 — Operator 의 도메인 이해 필요
- Champion 후보의 *준비도* 평가 — 사람의 정성 판단
- 다음 달 우선순위 — Operator 의 *최신 발화* 에 근거. AI 가 이전 데이터로 추정 ❌

## 절대 하지 말 것

- AI 가 KPI 값을 *추정* 하지 않는다 — 빈 placeholder 유지
- AI 가 champion 후보를 *선정* 하지 않는다 — 사람의 정성 판단 영역
- AI 가 다음 달 우선순위를 *역사 데이터로 추정* 하지 않는다 — Operator 의 *최신* 발화 필요
- 이미 존재하는 동일 월 리뷰가 있으면 *덮어쓰지 않는다* — 사용자 확인

## 트리거 키워드

다음 표현 시 본 커맨드 권장:
- "월간 리뷰", "monthly review", "이번 달 정리"
- "지난 달 진척", "한 달 점검", "champion 후보 평가"
- `/fde-monthly-review`
