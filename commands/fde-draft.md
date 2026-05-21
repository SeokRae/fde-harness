---
name: fde-draft
description: notes/ 의 Discovery 노트를 spec 초안(discovery-drafts/DRAFT-*.md)으로 옮깁니다. 정식 spec 폴더에는 쓰지 않습니다.
---

# Discovery 노트 → Spec 초안 (discovery-echo 스킬 호출)

인자 (선택): $ARGUMENTS — 변환할 노트의 ID 또는 파일명. 비어있으면 다음 미변환 노트를 사용.

이 커맨드는 `discovery-echo` 스킬을 호출하여 `notes/{ID}-*.md` 를 읽고 `discovery-drafts/DRAFT-{ID}-*.md` 를 생성한다. **5가지 최소 규칙**을 반드시 지킨다 (자세한 정의는 플러그인의 `skills/discovery-echo/SKILL.md`):

1. 노트에 있는 것만 사용한다
2. 모든 항목에 `(notes/{파일}:{섹션})` 출처를 표시한다
3. `Why` 슬롯은 노트의 `## Stated value` 섹션 내용만 사용한다
4. 노트에 없는 정보는 `## Open questions` 에 질문으로 남긴다
5. 산출물은 `discovery-drafts/DRAFT-*.md` 에만 쓴다 — `specs/` 폴더에 절대 쓰지 않는다

## 절차

1. **노트 선택**
   - $ARGUMENTS 가 있으면 해당 노트 (예: `001` 또는 `001-first-interview.md`)
   - 없으면 `notes/` 의 파일 중, 같은 ID의 `discovery-drafts/DRAFT-{ID}-*.md` 가 아직 없는 가장 오래된 노트
   - 후보가 없으면 사용자에게 "변환할 노트가 없다" 보고 후 종료

2. **노트 전체 읽기 + 사용자 확인**
   - 선택된 노트 경로를 사용자에게 한 줄로 보고하고 진행 의사를 확인한다 ("진행할까요?")
   - 진행 응답을 받기 전에는 draft 파일을 만들지 않는다

3. **`discovery-drafts/` 폴더 보장**
   - 사용자 프로젝트 루트에 `discovery-drafts/` 가 없으면 생성

4. **draft 작성** (`discovery-echo` 스킬의 슬롯 매핑 표 적용)
   - 파일명: `discovery-drafts/DRAFT-{노트와 같은 ID}-{kebab-제목}.md`
   - 본문 구조: `templates/spec-template.md` 와 동일 (Spec ID / What / Why / Done means / Out of scope / Context / Open questions / Risks / Rollback plan)
   - 단, 첫 줄 위에 다음 헤더 블록을 추가한다:

     ```
     <!-- DRAFT — AI-generated from notes/{원본}. 정식 spec 으로 쓰려면 사람이 검토 후 specs/ 로 수동 이동. -->
     <!-- source-note: notes/{원본 파일명} -->
     ```

   - 본문의 **모든 줄 끝에 출처 인용** 필수: `(notes/{파일}:{섹션})`
   - 매핑할 내용이 없는 슬롯은 빈 채로 두고, 그 슬롯에 대한 질문을 `## Open questions` 에 한 줄로 추가
   - `## Risks` 와 `## Rollback plan` 은 노트에 명시적 언급이 없으면 비워두고 Open questions 로 외화

5. **사용자 보고**

   ```
   📝 DRAFT 생성: discovery-drafts/DRAFT-{ID}-{kebab}.md

   - 채워진 슬롯: {N}개 (출처 표시 완료)
   - 비어있는 슬롯: {M}개 → Open questions {M}개로 외화
   - 질문 목록:
     1. ...
     2. ...

   다음 단계:
   - 사람이 draft 를 검토하세요
   - Open questions 에 답을 모으세요 (필요시 새 노트 추가 후 다시 /fde-draft)
   - 만족스러우면 draft 본문을 `specs/{ID}-{제목}.md` 로 직접 옮기세요 (AI는 specs/ 에 쓰지 않습니다)
   - 옮긴 후 `/fde-plan` 으로 구현 계획을 받으세요
   ```

## 절대 하지 말 것

- `specs/` 폴더에 파일을 쓰지 않는다 (검증 가능: write 호출 전 경로 확인).
- 노트에 없는 사실을 draft 본문에 추가하지 않는다.
- 출처를 댈 수 없는 줄은 쓰지 않는다 — 그 자리는 Open questions 로 옮긴다.
- 노트(`notes/*.md`)를 수정하지 않는다 (read-only).
- 기존 `discovery-drafts/DRAFT-{ID}-*.md` 가 있으면 덮어쓰지 말고, 사용자에게 알리고 동의를 받는다.
