---
name: fde-engagement
description: 고객사에 Claude를 납품하는 30일 활성화 engagement를 단계별로 진행합니다. 과제 선별, 파일럿 설계, 기준선, 주간 기록, 쇼케이스, 챔피언 인계를 승인 게이트와 함께 다룹니다. 사용자가 고객 engagement, 과제 선별, 파일럿, 기준선, 주간 기록, ROI 스코어카드, 쇼케이스, 챔피언 인계를 말하거나, 작업 폴더에 engagements/ 폴더가 있거나, brief.md나 01-qualify.md 같은 단계 파일을 첨부했을 때 사용합니다.
---

# FDE Engagement

이 스킬은 지금 어느 단계인지 판정하고, 그 단계의 절차 파일을 따라 진행한다. 이 문서의 경로는 모두 이 스킬 폴더(SKILL.md가 있는 폴더) 기준이다.

- 단계, 게이트, 판정 규칙: `references/methodology.md`
- 단계별 절차: `references/procedures/{단계}.md`
- 단계 파일 템플릿: `assets/templates/{이름}.md`

## 1. 환경 판정

먼저 작업 방식을 정한다.

| 환경 | 판정 기준 | 작업 방식 |
|---|---|---|
| 작업 폴더 모드 | 현재 작업 디렉터리에 파일을 쓰고 다음 대화에서 다시 읽을 수 있다 (Claude Code, Codex 등) | `engagements/` 아래에 파일을 만들고 고친다 |
| 첨부 모드 | 쓴 파일이 다음 대화에 남는지 확실하지 않다 (Claude 앱 채팅 등) | 아래 §3을 따른다 |

어느 쪽인지 확실하지 않으면 사용자에게 묻는다.

## 2. 현재 단계 판정

고객 폴더(작업 폴더 모드) 또는 첨부된 파일(첨부 모드)과 각 파일 frontmatter의 `status`로 판정한다.

| 상태 | 따를 절차 | Claude Code 커맨드 |
|---|---|---|
| 고객 폴더나 brief 없음 | `references/procedures/init.md` | `/fde-init` |
| `01-qualify.md` 없음 또는 `draft` | `references/procedures/qualify.md` | `/fde-qualify` |
| `02-pilot.md` 없음 또는 `draft` | `references/procedures/pilot.md` | `/fde-pilot` |
| `03-baseline.md` 없음 또는 `draft` | `references/procedures/baseline.md` | `/fde-baseline` |
| 기준선 `approved`, Day 30 전 | `references/procedures/week.md` | `/fde-week` |
| Day 30 7일 전부터, `04-showcase.md` 없음 또는 `draft` | `references/procedures/showcase.md` | `/fde-showcase` |
| 쇼케이스 결정이 확산, `05-handoff.md` 없음 또는 `draft` | `references/procedures/handoff.md` | `/fde-handoff` |

고객이 여럿이면 어느 고객인지 먼저 묻는다. 절차 파일 안의 `/fde-{단계}` 표기는 단계 이름이다. 슬래시 커맨드가 없는 환경에서는 "다음 단계는 파일럿 설계입니다"처럼 단계 이름으로 안내한다.

## 3. 첨부 모드

1. 대화를 시작하면 이어서 할 고객의 단계 파일을 첨부해 달라고 요청한다. 필요한 파일은 `brief.md`, 지금까지의 단계 파일, `failure-modes.md`다.
2. 첨부가 없으면 단계 파일이 없는 것으로 판정하지 않는다. 처음 시작하는지, 파일을 첨부할 것인지 묻는다.
3. 절차 파일의 "파일을 만든다", "파일을 고친다"는 대화 안에서 같은 이름의 파일을 만드는 것으로 바꿔 읽는다.
4. 각 단계가 끝나면 그 단계 파일과 바뀐 `failure-modes.md`를 내려받을 수 있는 파일로 준다. 사용자가 보관해야 다음 대화에서 이어 갈 수 있다고 알린다.
5. 폴더 구조가 필요한 곳(`engagements/{고객}/weeks/`)은 파일 이름 앞에 고객 slug를 붙여 구분한다. 예: `acme-W1.md`.

## 4. 모든 단계에 공통인 규칙

1. 앞 단계가 `status: approved`가 아니면 다음 단계 파일을 만들지 않는다. 이유를 알린다.
2. `approved`는 사용자가 대화에서 명시적으로 승인했을 때만 쓴다. 스스로 승인하지 않는다.
3. 지표 값, 고객 반응, 점수 근거는 사용자가 준 것만 적는다. 추정하거나 만들지 않는다.
4. `failure-modes.md`는 추가만 한다. 기존 항목을 지우거나 고치지 않는다.
5. 기존 파일을 덮어쓰지 않는다. 있으면 이어서 채운다.
6. 고객에게 보내는 문서나 메시지를 대신 보내지 않는다.
