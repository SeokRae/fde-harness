---
name: fde-note
description: 새 Discovery 노트 파일을 생성합니다. 인자로 노트 제목을 받습니다 (예 /fde-note 첫-인터뷰).
---

# 새 Discovery 노트 생성

사용자가 제공한 인자: $ARGUMENTS

> **경로 해결 규칙**: `<플러그인>/templates/note-template.md` 는 본 슬래시 커맨드를 제공하는 fde-harness **플러그인 설치 디렉토리** 의 templates/ 를 의미한다. 사용자 프로젝트에는 templates/ 가 없을 수 있다.

다음 작업을 수행해줘:

1. 사용자 프로젝트 루트에 `notes/` 폴더가 없으면 생성한다.
2. `notes/` 폴더의 기존 파일을 확인하고 다음 사용 가능한 ID를 결정한다 (예: 001, 002, 003 zero-padded).
3. 파일명 형식: `notes/{ID}-{kebab-case-제목}.md`
4. `<플러그인>/templates/note-template.md` 의 내용을 그대로 복사해 새 파일을 만든다.
5. 다음 필드만 자동 채운다:
   - 첫 줄의 `Note ID: {ID}` 와 `{제목}` (인자에서 추출)
6. 사용자에게 다음을 안내한다:
   - 생성된 파일의 절대 경로
   - "이 노트는 사람만 채웁니다 — AI는 읽기만 합니다. 채운 후 `/fde-draft {ID}` 를 실행하면 `discovery-drafts/DRAFT-{ID}-*.md` 초안이 만들어집니다."
   - "노트 섹션들의 의미는 templates/note-template.md 의 주석을 참고하세요."

ID는 절대 기존 노트와 충돌하지 않도록 한다. 본 커맨드는 노트 본문에 어떤 해석이나 placeholder도 추가로 채우지 않는다 (사람의 영역).
