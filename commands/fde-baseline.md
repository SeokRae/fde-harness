---
name: fde-baseline
description: Day 1 전에 성공 기준 지표의 기준선 값, 측정일, 출처를 기록합니다. 기준선이 없으면 주간 기록을 시작하지 않습니다.
---

# 기준선 기록

인자: `$ARGUMENTS`, 고객 slug (선택). 고객 선택 규칙은 `/fde-qualify`와 같다.

게이트 규칙은 플러그인의 `docs/methodology.md` §3.4를 따른다.

1. 선행 조건: `02-pilot.md`의 frontmatter가 `status: approved`여야 한다. 아니면 이유를 알리고 멈춘다.
2. `03-baseline.md`가 없으면 `templates/baseline.md`로 만든다.
3. `02-pilot.md`의 성공 기준 지표를 표의 행으로 옮긴다.
4. 지표마다 값, 단위, 측정일, 출처를 사용자에게 받는다. AI가 값을 추정하거나 만들지 않는다.
5. 측정일을 `brief.md`의 `day1`과 비교한다. Day 1 이후면 구분을 "사후 추정"으로 적는다.
6. 값이 빈 지표와 "사후 추정" 지표를 목록으로 보여 준다.
7. 모든 성공 기준 지표에 "기준선" 값이 있고 사용자가 명시적으로 승인하면 `status: approved`로 바꾼다.
8. 다음 단계 `/fde-week 1`을 안내한다.
