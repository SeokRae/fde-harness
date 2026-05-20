---
name: fde-init
description: 현재 프로젝트에 FDE 하네스 폴더 구조를 초기화합니다.
---

# FDE 하네스 초기화

> **경로 해결 규칙**: 본 커맨드에서 `<플러그인>/templates/...` 로 표기되는 경로는
> 본 슬래시 커맨드를 제공하는 fde-harness **플러그인 설치 디렉토리** 안의 `templates/` 를 의미한다.
> 사용자 프로젝트(현재 작업 디렉토리)에는 templates/ 폴더가 없을 수도 있다 — 그 경우에도 플러그인 쪽에서 읽어와야 한다.
>
> - Claude Code: `~/.claude/plugins/fde-harness/templates/` (또는 마켓플레이스 설치 경로)
> - Codex: `~/.agents/plugins/fde-harness/templates/` (또는 `~/.codex/config.toml` 에 등록된 경로)
> - 로컬 개발 중인 경우: 이 레포의 `templates/` 폴더

다음 작업을 **사용자 프로젝트 루트(현재 작업 디렉토리)** 에서 순서대로 수행해줘:

1. 다음 폴더가 없으면 생성: `specs/`, `.harness/`
2. `<플러그인>/templates/spec-template.md` 의 내용을 읽어 `./specs/_template.md` 로 복사 (이미 있으면 덮어쓰지 말 것)
3. `./AGENTS.md` 가 없으면 `<플러그인>/templates/AGENTS.md` 의 내용으로 생성 (있으면 건드리지 말 것)
4. `./.harness/done.log` 파일을 빈 파일로 생성 (이미 있으면 건드리지 말 것)
5. 완료 후 사용자에게 다음을 **순서대로** 안내:
   - 생성된 파일 목록 (절대 경로)
   - **⚠️ 가장 먼저**: AGENTS.md의 `## 두 역할 — Echo와 Delta` 섹션을 읽어달라는 안내
     - "당신은 Echo(도메인 전문가) 역할입니다. Spec 작성·Plan 평가·수동 검증·Ratchet 반성 4가지를 직접 책임집니다."
     - "이걸 모르고 진행하면 FDE 방법론이 작동하지 않습니다."
   - AGENTS.md의 "코딩 규칙"·"도메인 용어"·"외부 시스템" 섹션을 프로젝트 스택에 맞게 채워달라는 권고
   - 다음 단계: "`/fde-spec <기능명>` 으로 첫 spec을 만들고, 작성 후 `/fde-plan` 을 실행하세요"

기존 파일은 절대 덮어쓰지 말고, 이미 존재하는 경우 사용자에게 알려줘.
