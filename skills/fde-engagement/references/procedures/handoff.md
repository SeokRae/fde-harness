# 인계

입력: 고객 slug (선택). 고객 선택 규칙은 `references/procedures/qualify.md`와 같다.

규칙은 `references/methodology.md` §3.7을 따른다.

1. 선행 조건을 둘 다 확인한다. 하나라도 아니면 이유를 알리고 멈춘다.
   - `04-showcase.md`의 `decision`이 확산이고 `status: approved`
   - `brief.md`의 챔피언 지정 칸이 채워져 있음
2. `05-handoff.md`가 없으면 `assets/templates/handoff.md`로 만들고 `{champion}`을 채운다.
3. 페이즈 일정을 사용자와 정한다.
4. `engagements/failure-modes.md`에서 이 고객의 주간 기록에 신호가 있었던 항목을 "해당 실패 유형"에 옮긴다.
5. 인계 대상 체크리스트를 항목별로 점검한다. 확인하지 못한 항목은 체크하지 않고 "미확인"으로 적는다.
6. 완료 신호 세 개를 점검한다. 모두 충족하고 사용자가 승인하면 `status: approved`로 바꾼다.
7. 끝나면 engagement 전체 산출물 목록(`brief.md`, `01`~`05`, `weeks/`)을 보여 준다.
