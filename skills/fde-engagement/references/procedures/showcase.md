# 쇼케이스

입력: 고객 slug (선택). 고객 선택 규칙은 `references/procedures/qualify.md`와 같다.

규칙은 `references/methodology.md` §3.6을 따른다.

1. 선행 조건: `weeks/`에 주간 기록이 1개 이상 있어야 한다. 없으면 멈춘다.
2. `04-showcase.md`가 없으면 `assets/templates/showcase.md`로 만든다.
3. `03-baseline.md`와 가장 최근 주간 기록에서 지표를 모아 스코어카드를 채운다. 현재 값이 주간 기록에 없으면 사용자에게 받는다.
4. 기준선이 없거나 "사후 추정"인 지표는 `ROI 포함: 아니오`로 적고 사유를 남긴다.
5. 바뀐 일의 단위 전후를 적는다. 고객 반응은 사용자가 준 직접 인용만 적는다.
6. 가설 판정 근거를 보여 주고, 판정과 다음 결정을 사용자에게 받는다. AI는 결정을 대신 내리지 않는다.
7. 사용자가 결정하면 frontmatter의 `decision`을 채우고 `status: approved`로 바꾼다.
8. 결정에 따라 안내한다.
   - 확산: `/fde-handoff`
   - 연장: 새 성공 기준을 `02-pilot.md`에 추가하고 `/fde-week` 계속
   - 중단: 남길 교훈을 적고, 실패 유형 후보가 있으면 §4 절차로 추가
