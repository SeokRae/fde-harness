# Agent Instructions — fde-harness 레포 자체

> 이 파일은 **이 레포 자체를 개발할 때** AI 에이전트(Claude Code/Codex)가 따라야 하는 컨텍스트다.
> 플러그인 사용자에게 배포되는 템플릿은 `templates/AGENTS.md` 이며, 두 파일은 목적이 다르다.

## 프로젝트 개요

이 레포는 **Claude Code + Codex 듀얼 플러그인 `fde-harness`** 자체의 소스다. Forward Deployed Engineer 방법론(Spec → Plan → Implement → Verify → Ratchet)을 슬래시 커맨드·스킬·템플릿으로 패키징한다.

## 너의 역할

- 이 레포의 변경은 **플러그인 자체의 동작**에 영향을 미친다 (사용자가 설치 후 쓸 커맨드/스킬/템플릿).
- 변경 전 README의 "포함된 컴포넌트" 표와 `.claude-plugin/plugin.json` / `.codex-plugin/plugin.json` 의 정합성을 확인한다.
- 슬래시 커맨드 본문(`commands/*.md`)을 수정하면 사용자 경험이 즉시 바뀐다 — 신중하게.

## 절대 하지 말 것

- 플러그인 매니페스트 두 개(`.claude-plugin/`, `.codex-plugin/`) 중 한쪽만 갱신하지 않는다 — 양쪽을 동기화한다.
- `skills/fde-workflow/SKILL.md` 와 README의 "포함된 컴포넌트" 설명이 어긋나게 두지 않는다.
- `templates/` 내용을 `commands/` 본문에 인라인 복사하지 않는다 — 슬래시 커맨드는 템플릿 경로를 참조만 한다.
- 버전 변경 없이 동작이 바뀌는 변경은 하지 않는다 (`plugin.json` 의 `version` 동기 갱신).
- macOS `.DS_Store` 또는 `.harness/` 결과물을 커밋하지 않는다 (`.gitignore` 참조).
- 워크플로우 동사(슬래시 커맨드·작업 순서·SKILL.md 단계)를 변경할 때 **4곳을 모두 동기화** — `commands/{verb}.md`, `templates/AGENTS.md` 의 Delta 작업 순서, `skills/fde-workflow/SKILL.md` 의 대응 단계, README의 사용 흐름. 한쪽만 갱신하면 사용자가 보는 곳마다 다른 흐름을 본다.
- spec 작성 시 Done means 의 "현재 ~를 ~로 갱신" 류 항목 전, `ls`/`grep` 로 **실제 파일 상태를 먼저 확인**한다. 가정 기반 spec 은 Implementation에서 갈리고 검증을 통과해도 산출물이 사용자 기대와 어긋난다 (예: "이미 있는 파일 수정" 인데 파일이 없는 경우).
- README의 *"다음으로 추가할 만한 것"* 표 항목이 **이번 PR에서 구현되면 즉시 다른 후보로 교체** — 표가 stale 하면 사용자가 "왜 추가 안 됐지" 라고 묻게 된다.
- 사이클 흐름(단계 정의·결정 트리·로그 포맷)의 **SSoT 는 `docs/cycle-guide.md`** — 다른 문서(README, `docs/concepts.md`, `commands/`, `templates/`, `skills/`)는 cycle-guide 로 **링크만 한다**. 내용을 복사하면 사이클이 진화할 때 한쪽이 stale 해진다.

## 개발 워크플로우

1. **Issue 생성** (`SeokRae/fde-harness`) — 변경 의도를 한 줄로
2. **`main`에서 feature 브랜치 분기** — 체인 브랜치 금지
   ```bash
   git checkout main && git pull origin main
   git checkout -b feature/{이슈번호}-{설명}
   ```
3. **구현 + 매니페스트 동기 갱신**
4. **`commands/*.md` 또는 `skills/*/SKILL.md` 변경 시 README 영향 확인**
5. **커밋 메시지에 `#이슈번호` 포함**
   ```bash
   git commit -m "feat: ... (#N)"
   ```
6. **PR 생성** — body에 `Closes #N` 필수

## 코딩 규칙 (이 레포 한정)

- **언어**: Markdown + JSON (실행 코드 거의 없음)
- **들여쓰기**: JSON 2 spaces, Markdown은 GFM 규약
- **파일명**: 슬래시 커맨드는 `commands/fde-{verb}.md`, 스킬은 `skills/{kebab}/SKILL.md`
- **한국어 본문 + 영어 식별자**: 사용자 대상 문구는 한국어, 키/네임스페이스는 영어

## 외부 시스템

- **GitHub** `SeokRae/fde-harness` — 이슈/브랜치/PR
- **Claude Code 플러그인 시스템** — `.claude-plugin/plugin.json` 매니페스트 스펙
- **Codex 플러그인 시스템** — `.codex-plugin/plugin.json` 매니페스트 스펙
- **MCP 서버** — `filesystem`, `git` (사용자 환경에 의존, 이 레포는 설정만 제공)

## 의사결정 기록

- **2026-05-20**: 외곽/내부 이중 디렉토리 구조를 flatten. 레포 루트 = 플러그인 루트 1단 구조로 통일. 외곽 `plugin.json`/`SKILL.md`/`AGENTS.md` 는 dead reference여서 제거.
