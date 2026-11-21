# 주간 기록

입력: 주차 번호와 고객 slug (둘 다 선택). 주차가 없으면 `weeks/`의 마지막 번호 + 1을 쓴다. 고객 선택 규칙은 `references/procedures/qualify.md`와 같다.

규칙은 `references/methodology.md` §3.5와 §4를 따른다.

1. 선행 조건: `03-baseline.md`의 frontmatter가 `status: approved`여야 한다. 아니면 이유를 알리고 멈춘다.
2. `weeks/W{n}.md`가 이미 있으면 이어서 채운다. 없으면 `assets/templates/week.md`로 만든다.
3. 사용 현황, 위임 수준, 지표 중간값, 고객 접점, 막힌 것을 사용자에게 받는다. 지표 값은 사용자가 준 값만 적는다.
4. `engagements/failure-modes.md`의 `상태: 유효` 항목을 모두 실패 유형 점검 표에 옮기고, 항목마다 이번 주 신호를 묻는다.
5. 생산성 하락은 그 자체로 실패로 적지 않는다. 직전 주 기록에서도 하락이 있었으면 실패 유형 후보로 올린다.
6. 새 실패 유형 후보가 있으면 §4 형식의 문구를 사용자에게 보여 준다. 승인받은 항목만 `failure-modes.md` 끝에 추가한다. 기존 항목은 지우거나 고치지 않는다.
7. Day 30이 가까우면(`brief.md`의 `day30`까지 7일 이하) `/fde-showcase`를 안내한다.
