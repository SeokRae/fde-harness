---
name: fde-init
description: 현재 프로젝트에 FDE 하네스 폴더 구조를 초기화합니다.
---

# FDE 하네스 초기화

다음 작업을 순서대로 수행해줘:

1. 다음 폴더가 없으면 생성: `specs/`, `.harness/`
2. `specs/_template.md` 파일을 templates/spec-template.md 내용으로 생성 (이미 있으면 덮어쓰지 말 것)
3. 프로젝트 루트에 `AGENTS.md` 가 없으면 templates/AGENTS.md 내용으로 생성
4. `.harness/done.log` 파일을 빈 파일로 생성 (이미 있으면 건드리지 말 것)
5. 완료 후 사용자에게 다음을 안내:
   - 생성된 파일 목록
   - 다음 단계: "specs/001-XXX.md 파일을 작성하시고 /fde-plan 을 실행하세요"
   - AGENTS.md를 프로젝트 도메인에 맞게 수정하라는 권고

기존 파일은 절대 덮어쓰지 말고, 이미 존재하는 경우 사용자에게 알려줘.
