---
name: discovery-echo
description: FDE 딥다이브 모드의 *Discovery 단계* 보조 — 인터뷰·관찰 노트(notes/*.md)를 spec 초안(discovery-drafts/DRAFT-*.md)으로 옮기는 스킬. 사용자가 "노트로 draft 만들어줘", "discovery-drafts", "DRAFT-", "/fde-draft", "인터뷰 노트", "딥다이브 Discovery"를 언급하거나, 프로젝트 루트에 notes/ 폴더가 있는 상태에서 spec 초안화를 시작할 때 자동으로 트리거됩니다.
---

# Discovery Echo Skill — 딥다이브 모드의 Discovery 단계 보조

> **모드**: 딥다이브 (Deep dive). 헌장 [`docs/fde-criteria.md`](../../docs/fde-criteria.md) § 1.4 의 1-3개월 사이클 전용 보조.
>
> **"Discovery" 단어의 두 의미 — 본 스킬은 (b) 만**:
> - **(a) 작업 모드** (헌장 § 1.4 의 잠재 후보 — 현재 부재) — 며칠~2주의 *발견* 위주 모드. *본 스킬과 무관*.
> - **(b) `fde-workflow` 의 1단계** — 딥다이브 사이클 안의 *Discovery 단계* (Operator → 노트 → spec). **본 스킬은 (b) 의 보조**.
>
> 이 모호함은 헌장 § 7.3 의 미해결 항목. 향후 명명 정리 가능 (스킬 이름 변경 후보).

이 스킬은 **Spec이 작성되기 *전*** 단계, 즉 사람의 인터뷰·관찰·자료 수집(=딥다이브 사이클의 Discovery 단계) 에서 나온 노트를 spec 초안으로 옮기는 보조 스킬입니다. Spec 본문의 단일 진실 공급원은 여전히 사람(Echo)이지만, 노트가 흩어져 있을 때 초안 생성의 마찰을 줄여줍니다.

> **위치**: 딥다이브 모드의 `/fde-plan` 이전 단계입니다 (cycle-guide의 Stage 0 에 해당).
>
> ```
> 인터뷰/관찰 → notes/*.md  ──[discovery-echo]──▶  discovery-drafts/DRAFT-*.md  ──[Echo 검토·이동]──▶  specs/*.md  ──▶  /fde-plan
> ```

## 5가지 최소 규칙 (강제)

이 스킬의 모든 동작은 다음 5가지 규칙으로만 움직입니다. 규칙 외의 추론을 추가하지 않습니다.

1. **노트에 있는 것만 사용** — `notes/*.md` 의 실제 문장만 draft에 옮긴다. 외삽·추측·"일반적으로 이럴 것이다" 금지.
2. **모든 항목에 출처 표시** — draft의 모든 줄에 `(notes/{파일명}:{섹션})` 형식의 인용을 붙인다. 출처를 댈 수 없는 줄은 쓰지 않는다.
3. **비즈니스 가치는 사람의 말만 옮긴다** — `Why` 슬롯은 노트의 `## Stated value` 섹션 내용만 사용. AI가 가치 추론을 만들어 채우지 않는다.
4. **불명확한 것은 명시적으로 남긴다** — 노트에 없는 정보는 `## Open questions` 섹션에 "사람에게 물어볼 질문" 형태로 남긴다. 빈 슬롯을 임의로 채우지 않는다.
5. **별도 폴더, 별도 명명** — 산출물은 항상 `discovery-drafts/DRAFT-{ID}-{kebab}.md` 로 저장. `specs/` 폴더에는 절대 쓰지 않는다. 정식 spec으로의 승격은 Echo의 수동 작업이다.

## 입력 / 출력

| 항목 | 위치 | 작성자 |
|------|------|--------|
| **입력**: 인터뷰·관찰 노트 | `notes/*.md` | 사람(Echo) |
| **산출물**: spec 초안 | `discovery-drafts/DRAFT-*.md` | AI(Delta) — 이 스킬 |
| **승격**: 정식 spec | `specs/*.md` | 사람(Echo) — 수동 이동 |

폴더가 물리적으로 분리되어 있어, 검토 단계에서 AI 산출물과 사람의 산출물을 한눈에 구분할 수 있습니다.

## 작업 절차

`/fde-draft` 가 호출되면 다음을 수행합니다:

1. **노트 선택**
   - 인자에 노트 ID나 파일명이 있으면 그것을 사용
   - 없으면 `notes/` 폴더에서 같은 ID 의 DRAFT가 아직 없는 가장 오래된 노트를 선택
   - 사용자에게 선택된 노트를 한 줄로 알리고 진행 의사 확인

2. **노트 읽기 + 슬롯 매핑**
   - 노트의 섹션을 spec 슬롯에 1:1 로 매핑한다 (다음 표 참조)
   - 매핑할 내용이 없는 슬롯은 빈 placeholder + `Open questions` 에 질문 추가

   | 노트 섹션 | spec 슬롯 |
   |-----------|----------|
   | `## What user said` | `## What (무엇을)` |
   | `## Stated value` | `## Why (왜)` |
   | `## Observed behavior` | `## Context (참고 자료)` |
   | `## Concrete examples` | `## Done means (완료 정의)` 후보 |
   | `## Mentioned constraints` | `## Out of scope` 또는 `## Risks` 후보 |
   | `## Unanswered` | `## Open questions` (병합) |

3. **draft 생성**
   - `templates/spec-template.md` 와 동일 구조 사용
   - 단, **모든 줄 끝에 출처 인용** 필수: `(notes/001-foo-interview.md:Stated value)`
   - 파일명: `discovery-drafts/DRAFT-{노트와 같은 ID}-{kebab-제목}.md`
   - `discovery-drafts/` 폴더가 없으면 생성

4. **사용자 보고**
   - 생성된 draft 경로
   - 채워진 슬롯과 비어있는 슬롯 개수
   - `Open questions` 의 질문 목록 (사람에게 답을 받기 위해)
   - 안내: "draft 검토 후 정식 spec으로 쓰려면 `discovery-drafts/DRAFT-{ID}.md` 의 내용을 `specs/{ID}-{제목}.md` 로 사람이 직접 옮기세요. AI는 `specs/` 폴더에 쓰지 않습니다."

## 절대 하지 말 것 (이 스킬 한정)

- `specs/` 폴더에 파일을 쓰지 않는다 (산출물은 항상 `discovery-drafts/` 로).
- 노트에 없는 사실을 draft 본문에 추가하지 않는다. 추론은 항상 `Open questions` 로 외화한다.
- "이 인터뷰는 X 라고 말한 것 같다" 같은 의역을 슬롯 본문에 쓰지 않는다 — 원문 인용 + 출처 표시.
- 출처를 댈 수 없는 줄은 쓰지 않는다. 출처가 없으면 그 줄을 빼고 `Open questions` 에 질문으로 옮긴다.
- 노트를 수정하지 않는다 (`notes/*.md` 는 raw data — read-only).

## 트리거 키워드

다음 표현이 사용자 메시지에 나오면 이 스킬을 적용합니다 (딥다이브 모드 가정):
- "딥다이브 Discovery", "discovery-drafts", "DRAFT-"
- "노트로 draft", "노트에서 spec", "인터뷰 노트"
- "/fde-note", "/fde-draft"
- "notes/ 폴더"

**모드 한정**: 스플릿 모드 (며칠~2주) 에서는 *옆에서 매일 관찰* 이 노트 작성보다 우선 → 본 스킬 보조 역할 약화, [`fde-sprint-workflow`](../fde-sprint-workflow/SKILL.md) 활성. 챔피언 모드 (6개월+) 에서는 *후임자 transfer* 로 Discovery 의 의미 전환 → [`fde-champion-workflow`](../fde-champion-workflow/SKILL.md) 활성.

## 관련 헌장 섹션

- [`docs/fde-criteria.md`](../../docs/fde-criteria.md) **§ 1.4** — 3 모드 정의 (본 스킬은 딥다이브 전용)
- [`docs/fde-criteria.md`](../../docs/fde-criteria.md) **§ 2.F1** — Co-location 의 강제 항목 (관찰 증거)
- [`docs/fde-criteria.md`](../../docs/fde-criteria.md) **§ 7.3** — "Discovery" 용어 충돌의 미해결 큐

## 관련 스킬

- [`skills/fde-workflow`](../fde-workflow/SKILL.md) — 본 스킬을 *호출* 하는 부모. 딥다이브 사이클의 1단계 에서 본 스킬 활성화.
