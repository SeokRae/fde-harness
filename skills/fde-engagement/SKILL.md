---
name: fde-engagement
description: 고객사에 Claude를 납품하는 30일 활성화 engagement를 단계별로 진행합니다. 과제 선별, 파일럿 설계, 기준선, 주간 기록, 쇼케이스, 챔피언 인계를 다룹니다. 사용자가 고객 engagement, 파일럿, 기준선, ROI 스코어카드, 쇼케이스, 챔피언 인계를 말하거나, 프로젝트에 engagements/ 폴더가 있을 때 사용합니다.
---

# FDE Engagement

단계, 게이트, 산출물의 정의는 이 플러그인의 `docs/methodology.md`가 기준이다. 이 스킬은 지금 어느 단계인지 판정하고 해당 절차로 보낸다.

## 현재 단계 판정

`engagements/{고객}/`의 파일과 frontmatter `status`로 판정한다.

| 상태 | 다음 절차 |
|---|---|
| 고객 폴더 없음 | `commands/fde-init.md` |
| `01-qualify.md` 없음 또는 `draft` | `commands/fde-qualify.md` |
| `02-pilot.md` 없음 또는 `draft` | `commands/fde-pilot.md` |
| `03-baseline.md` 없음 또는 `draft` | `commands/fde-baseline.md` |
| 기준선 `approved`, Day 30 전 | `commands/fde-week.md` |
| Day 30 7일 전부터, `04-showcase.md` 없음 또는 `draft` | `commands/fde-showcase.md` |
| 쇼케이스 결정이 확산, `05-handoff.md` 없음 또는 `draft` | `commands/fde-handoff.md` |

고객이 여럿이면 어느 고객인지 먼저 묻는다.

## 실행 방법

- Claude Code: 해당 슬래시 커맨드(`/fde-qualify` 등)를 안내하거나, 사용자가 원하면 그 커맨드 파일의 절차를 그대로 따른다.
- Codex: 슬래시 커맨드가 없으므로 이 플러그인의 `commands/{커맨드}.md`를 읽고 절차를 그대로 따른다.

## 모든 단계에 공통인 규칙

1. 앞 단계가 `status: approved`가 아니면 다음 단계 파일을 만들지 않는다. 이유를 알린다.
2. `approved`는 사용자가 채팅에서 명시적으로 승인했을 때만 쓴다. AI가 스스로 승인하지 않는다.
3. 지표 값, 고객 반응, 점수 근거는 사용자가 준 것만 적는다. 추정하거나 만들지 않는다.
4. `engagements/failure-modes.md`는 추가만 한다. 기존 항목을 지우거나 고치지 않는다.
5. 기존 파일을 덮어쓰지 않는다. 있으면 이어서 채운다.
6. 고객에게 보내는 문서나 메시지를 대신 보내지 않는다.
