# Agent Instructions: fde-harness 저장소

이 파일은 이 저장소 자체를 고칠 때 AI 에이전트(Claude Code, Codex)가 따르는 지침이다.

## 프로젝트 개요

Claude Code와 Codex 듀얼 플러그인 `fde-harness`의 소스다. 고객 납품 30일 활성화 engagement를 커맨드, 스킬, 템플릿으로 패키징한다.

## 절대 하지 말 것

- 매니페스트 두 개(`.claude-plugin/plugin.json`, `.codex-plugin/plugin.json`) 중 한쪽만 고치지 않는다. `version`, `description`, `keywords`를 함께 맞춘다.
- 동작이 바뀌는 변경을 버전 갱신 없이 넣지 않는다.
- 단계, 게이트, 판정 규칙의 SSoT는 `skills/fde-engagement/references/methodology.md`다. README, SKILL.md, 절차 파일, 템플릿, 커맨드에는 내용을 복사하지 않고 링크만 한다.
- 스킬 폴더(`skills/fde-engagement/`)는 그것만으로 완결되어야 한다. Claude 앱은 이 폴더만 받는다. SKILL.md와 절차 파일에서 폴더 밖(`../`, `docs/`, `commands/`)을 가리키지 않는다.
- 커맨드(`commands/fde-*.md`)는 절차 파일을 부르는 래퍼로만 둔다. 절차 내용을 커맨드에 쓰지 않는다.
- 단계를 추가, 삭제, 이름 변경할 때는 여섯 곳을 함께 고친다: `references/procedures/{단계}.md`, `commands/fde-{단계}.md`, `assets/templates/`, SKILL.md의 단계 판정 표, `references/methodology.md` §3, README의 컴포넌트 목록. `test.sh`의 `STAGES`도 고친다.
- 다른 플러그인이나 하네스를 참조하지 않는다. 이 플러그인은 단독으로 동작해야 한다.
- 강의 자료의 문구를 옮기지 않는다. 공개 저장소다. 구조와 기준 항목 이름만 참고하고 설명은 직접 쓴다.
- 템플릿 내용을 커맨드 본문에 복사하지 않는다. 커맨드는 템플릿 경로만 참조한다.
- README의 "다음으로 추가할 만한 것" 항목을 구현하면 그 PR에서 표를 고친다.

## 개발 워크플로우

1. `SeokRae/fde-harness`에 Issue를 만든다.
2. `main`에서 `feature/{이슈번호}-{설명}` 브랜치를 만든다. 브랜치를 잇지 않는다.
3. 구현하고 `./test.sh`를 돌린다. CI(`.github/workflows/lint.yml`)도 같은 스크립트를 돌린다.
4. 커밋 메시지에 `#이슈번호`를 넣는다.
5. PR 본문에 `Closes #이슈번호`를 넣는다.

## 규칙

- Markdown과 JSON이 대부분이다. JSON은 2칸 들여쓰기.
- 커맨드 파일명은 `commands/fde-{단계}.md`, 절차 파일은 `references/procedures/{단계}.md`, 스킬은 `skills/{kebab}/SKILL.md`.
- SKILL.md는 frontmatter에 `name`, `description`만 둔다. `name`은 폴더 이름과 같고, `description`은 1,024자 이하, 본문은 500줄 미만이다.
- 사용자 대상 문구는 한국어, 키와 식별자는 영어.

## 의사결정 기록

- 2026-05-20: 외곽과 내부의 이중 디렉터리를 없애고 저장소 루트를 플러그인 루트로 통일했다.
- 2026-11-21: v0.6.0(spec 기반 코딩 루프, 3모드, F1~F5 헌장)을 전면 교체했다. 대상이 코딩 루프에서 고객 납품 engagement로 바뀌었다. 이전 버전은 `v0.6.0` 태그로 보존한다. PostToolUse 훅과 MCP 설정은 고객 납품 흐름에 필요 없어 뺐다.
- 2026-11-21: v1.1.0에서 방법론, 절차, 템플릿을 스킬 폴더 안으로 옮겼다. Claude 앱은 스킬 폴더만 업로드하므로 폴더 밖 파일을 읽을 수 없기 때문이다.
