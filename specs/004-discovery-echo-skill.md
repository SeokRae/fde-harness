# Spec ID: 004 — Discovery Echo 스킬 및 노트→draft 트랙 (사후 회고)

> **회고 spec**: 본 spec 은 PR #18 머지 *이후* 작성된 사후 문서다. 이 레포는 자기 자신에게 FDE 를 적용한다는 메타 원칙(specs/001-003 이 그 증거)을 유지해야 하므로, spec 선행 없이 머지된 PR #18 을 회고로 보강한다. 동시에 AGENTS.md `## 절대 하지 말 것` 에 "새 컴포넌트 추가는 spec 선행" 규칙을 Ratchet 한다.

## What (무엇을)

인터뷰·관찰 노트(`notes/*.md`)를 spec 초안(`discovery-drafts/DRAFT-*.md`)으로 옮기는 Discovery 보조 스킬(`discovery-echo`)과 두 개의 슬래시 커맨드(`/fde-note`, `/fde-draft`), 노트 템플릿 1종을 추가한다. AI 의 추론 범위는 5가지 최소 규칙으로 강하게 제약한다.

## Why (왜) — 비즈니스 가치

기존 하네스는 "사용자가 이미 spec 을 머릿속에 갖고 있는 경우" 만 다뤘다. 실제 현장에서는 인터뷰·관찰 노트가 먼저 쌓이고 그것을 spec 으로 옮기는 단계의 마찰이 가장 크다. 두 가지 문제가 동시에 발생한다:

1. **사용자 측**: 흩어진 노트를 spec 슬롯(What/Why/Done means/Out of scope)에 매핑하는 기계적 작업이 번거롭다 — 결과적으로 spec 작성을 미루거나 머릿속에 둔 채 `/fde-plan` 으로 직행한다.
2. **AI 측**: spec 없이 작업이 시작되면 AI 가 "Why" 를 추측하기 시작한다 — 곧 잘못된 가치 가정 위에서 구현된다.

`discovery-echo` 는 이 마찰을 줄이되, AI 추론을 5가지 규칙으로 제약해 "AI 가 spec 을 쓰는 것" 으로 흐르지 않도록 막는다. 정식 spec 으로의 승격은 사람의 수동 작업으로 유지된다 (`discovery-drafts/` 와 `specs/` 의 물리 분리).

## Done means (완료 정의)

PR #18 머지 시점 기준으로 다음 항목이 모두 충족됨을 사후 확인한다:

- [x] `skills/discovery-echo/SKILL.md` 존재 — 5가지 최소 규칙(노트만 사용 / 출처 표시 / Why 는 Stated value 만 / 빈 자리는 Open questions / discovery-drafts/ 전용) 명시
- [x] `commands/fde-note.md` — `notes/{ID}-*.md` 에 빈 양식 생성, AI 가 본문을 추가로 채우지 않음
- [x] `commands/fde-draft.md` — discovery-echo 스킬 호출, 모든 줄에 `(notes/{파일}:{섹션})` 출처 강제, `specs/` 폴더에 쓰지 않음
- [x] `templates/note-template.md` — 7 슬롯(Source / What user said / Stated value / Observed behavior / Concrete examples / Mentioned constraints / Unanswered) + Optional `Our interpretation`
- [x] `commands/fde-init.md` — `notes/`, `discovery-drafts/`, `notes/_template.md` 생성 단계 추가, 다음 단계 안내에 Track A / Track B 분리
- [x] `README.md` "포함된 컴포넌트" 표 갱신 (2 Skills / 6 Commands / 3 Templates) + 사용 흐름에 Track A / Track B 분리 + 폴더 구조 갱신
- [x] 두 매니페스트(`.claude-plugin/plugin.json`, `.codex-plugin/plugin.json`) version `0.1.0 → 0.2.0` 동기
- [x] **본 회고 spec 작성** + AGENTS.md Ratchet 규칙 1줄 추가 ← 이 PR 의 직접 산출물

## Out of scope (안 하는 것)

- AI 가 `specs/` 폴더에 직접 쓰기 — 정식 spec 으로의 승격은 사람의 수동 작업으로 유지 (이 규칙이 무너지면 5가지 최소 규칙의 5번이 무력화됨)
- 노트 자동 분류·태깅
- 여러 노트를 하나의 draft 로 합치는 기능
- Stated value 의 정량화 (ROI 추정 등)
- `discovery-drafts/DRAFT-*.md` 에서 `specs/*.md` 로의 승격 자동화
- "Discovery" 용어 충돌 정리 — 별도 spec(005 후보)으로 분리

## Context (참고 자료)

- PR #18: `feat: Discovery Echo 스킬 + /fde-note·/fde-draft 추가` (https://github.com/SeokRae/fde-harness/pull/18)
- 머지 커밋: `2069ed7`
- 기존 메타-FDE 사이클: specs/001 (PR #11), specs/002 (PR #13), specs/003 (PR #15)
- 관련 SSoT: `docs/cycle-guide.md`

## Open questions (불명확한 점)

- **"Discovery" 용어 충돌**: `fde-workflow` SKILL.md 의 1단계 "Discovery" 는 "다음 작업할 spec 찾기" 인데, `discovery-echo` 의 "Discovery" 는 "고객 노트 → draft" 다. 두 의미가 한 레포에 공존. 사용자 혼동 시그널이 들어오면 별도 spec 으로 정리 (예: 전자를 `Selection` 으로 개명).
- **5가지 규칙의 엄격함**: 첫 5건의 draft 가 50% 이상 사람 손에 수정되면 규칙이 너무 엄격하다는 신호. 그 경우 규칙 4(Open questions 외화) 의 임계치를 완화할지 검토.

## Risks (위험 요소)

- **`DRAFT-` 접두사 컨벤션 충돌** — 사용자가 GitHub PR draft 와 혼동할 수 있음. 인지 방법: 첫 외부 사용자 피드백에서 "draft 가 뭐냐" 질문이 나오면 명명 변경 검토.
- **5가지 규칙이 너무 엄격해 draft 가치가 낮을 가능성** — 인지 방법: 첫 5건의 draft 가 사람 손에 50% 이상 재작성되는지 추적. 회수율이 낮으면 규칙 완화.
- **메타-FDE 위반 재발 위험** — 회고로 spec 을 보강하는 패턴이 굳어지면 "어차피 사후에 쓰면 됨" 으로 흐를 수 있음. 인지 방법: 회고 spec 이 2건 이상 누적되면 PreToolUse hook 으로 spec 선행을 hard guard 화 검토.

## Rollback plan (롤백 계획)

기능 자체 롤백 시:

- `skills/discovery-echo/` 폴더 삭제
- `commands/fde-note.md`, `commands/fde-draft.md` 삭제
- `templates/note-template.md` 삭제
- `commands/fde-init.md` 의 `notes/` · `discovery-drafts/` 생성 단계 되돌림 (Track A 만 유지)
- `README.md` 사용 흐름·컴포넌트 표·폴더 구조 0.1.0 형태로 되돌림
- 두 매니페스트 version `0.2.0 → 0.1.0`
- 사용자 프로젝트의 `notes/`, `discovery-drafts/` 폴더는 손대지 않음 (이미 만든 노트는 사용자 자산)

호환성 영향: 이미 v0.2.0 을 설치한 사용자는 새 슬래시 커맨드 2개만 사라짐 — 기존 `/fde-spec`·`/fde-plan`·`/fde-done` 흐름은 그대로 동작.
