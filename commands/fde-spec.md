---
name: fde-spec
description: 새 spec 파일을 생성합니다. 인자로 spec 제목을 받습니다 (예 /fde-spec 로그인 기능).
---

# 새 Spec 생성

사용자가 제공한 인자: $ARGUMENTS

다음 작업을 수행해줘:

1. `specs/` 폴더의 기존 파일을 확인하고 다음 사용 가능한 ID를 결정한다 (예: 001, 002, 003 형식 zero-padded)
2. 파일명 형식: `specs/{ID}-{kebab-case-제목}.md`
3. templates/spec-template.md 를 기반으로 새 spec 파일을 생성한다
4. 다음 필드만 자동 채운다:
   - Spec ID
   - 제목 (인자에서 추출)
5. 나머지 섹션은 빈 placeholder로 두고, 사용자에게 다음을 안내:
   - 생성된 파일 경로
   - "다음 섹션을 채워주세요: What / Why / Done means / Out of scope"
   - "작성이 끝나면 /fde-plan 으로 구현 계획을 받으세요"

ID는 절대 기존 spec과 충돌하지 않도록 한다.
