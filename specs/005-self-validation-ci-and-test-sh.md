# Spec ID: 005 — 자기 검증 인프라 (Lint CI + ./test.sh)

## What (무엇을)

이 레포 자신에게 두 가지 자동 검증 장치를 추가한다:

1. `.github/workflows/lint.yml` — push·PR 이벤트에서 `./test.sh` 를 실행하는 최소 GitHub Actions workflow
2. `./test.sh` — 매니페스트 정합성·핵심 파일 존재·문서 링크 깨짐을 검증하는 단일 bash 스크립트 (fast-fail)

`./test.sh` 와 CI workflow 는 같은 스크립트를 공유한다 — 로컬 PostToolUse hook 발동 시점과 원격 CI 시점이 같은 결과를 낸다.

## Why (왜) — 비즈니스 가치

세 가지 문제를 동시에 해결한다:

1. **회귀 위험** — 현재 CI 가 없어 PR pending status 가 의미 없는 상태다 (PR #18 도 `total_count: 0` 인 상태에서 머지됨). 매니페스트 JSON 깨짐·버전 불동기·SKILL.md 누락이 사람 눈에만 의존한다.
2. **메타 불일치** — 이 레포는 사용자에게 PostToolUse hook (`hooks/post-tool-use.json`) 으로 `./test.sh` 사용을 권하면서 자기 자신은 `./test.sh` 가 없다. PR #14 가 도입한 hook 이 자기 자신에게는 no-op 상태로 1년 방치될 위험.
3. **외부 사용자 진입 신뢰도** — issue #17 같은 외부 관심자가 늘 때, "본인도 안 쓰는 hook" 이 보이면 신뢰가 깎인다.

가치 측정: 다음 PR 부터 자동으로 매니페스트 동기·핵심 컴포넌트 수가 검증된다. 회귀 1건이라도 잡으면 본 spec 의 비용을 회수.

## Done means (완료 정의)

- [ ] `.github/workflows/lint.yml` 존재 — `on: [push, pull_request]` 에 트리거, `ubuntu-latest` 에서 `./test.sh` 실행
- [ ] `./test.sh` 실행 권한(`chmod +x`) 보유, shebang `#!/usr/bin/env bash`
- [ ] `./test.sh` 가 다음을 검증한다 (한 항목이라도 실패 시 non-zero exit):
  - [ ] `.claude-plugin/plugin.json` 과 `.codex-plugin/plugin.json` 의 `version` 필드가 같다
  - [ ] 위 두 파일 모두 `jq` 로 파싱 가능 (JSON 유효)
  - [ ] `commands/*.md` 파일 개수가 README의 "포함된 컴포넌트" 표에 명시된 Slash Commands 개수와 일치
  - [ ] `skills/*/SKILL.md` 파일 개수가 README의 Skills 개수와 일치
  - [ ] `templates/` 에 `spec-template.md`, `note-template.md`, `AGENTS.md` 모두 존재
  - [ ] `hooks/post-tool-use.json` 이 JSON 유효
- [ ] `./test.sh` 출력에 명확한 `PASS` / `FAIL` 라벨, 실패 시 어느 항목인지 표시
- [ ] 본 PR 의 workflow check 가 success 로 통과 (자기 검증 — 도입 자체가 첫 검증 사례)
- [ ] `README.md` 의 hook 섹션에 한 줄 추가: "이 레포 자신도 `./test.sh` 를 갖고 있어 fde-harness 의 PostToolUse hook 을 dogfood 한다"
- [ ] `AGENTS.md` `## 절대 하지 말 것` 에 한 줄 추가: "`./test.sh` 의 검증 항목을 줄이지 않는다 — Done means 의 검증 횟수는 단방향으로만 증가한다"

## Out of scope (안 하는 것)

- 통합 테스트, e2e 시나리오 (실제 슬래시 커맨드 실행 검증) — 별도 사이클
- 보안 스캔 (secret scanning, dependabot 등)
- 릴리스 자동화 (semantic-release, tag 푸시 자동화 등)
- 외부 사용자 프로젝트의 `./test.sh` 자동 생성 — 사용자 영역
- 다른 lint 도구 (yamllint, shellcheck, markdownlint 등) — 첫 사이클은 최소
- macOS 호환성 — 처음엔 `ubuntu-latest` 만, 마찰이 보일 때 확장
- 이전 PR 들의 retroactive CI 검증 — 머지된 것은 그대로 둠

## Context (참고 자료)

- 트리거 audit: 사용자가 v0.2.0 머지 후 단계 진단 요청 시 식별된 "단기" 항목 2개
- 관련 PR: #14 (PostToolUse hook 도입 — 이 레포 자신에게는 no-op 상태였음), #18 (CI 없는 상태에서 머지된 8 file PR)
- 이 spec 은 **PR #19 에서 Ratchet 한 "spec 선행" 규칙을 처음으로 지키는 사이클**. 즉 이 spec 의 의의는 인프라뿐 아니라 메타-FDE 자기일관성 회복.

## Open questions (불명확한 점)

- **`jq` 의존성 결정**: 검증 스크립트에 `jq` 를 쓸지, Python `json.tool` 을 쓸지, 아니면 셸 내장으로 처리할지. `jq` 가 가장 단순하고 ubuntu-latest 에 사전 설치되어 있어 1순위.
- **README 컴포넌트 개수 동기화 방식**: README 표를 기계가 파싱하기 어렵다. 두 가지 선택:
  - (a) `./test.sh` 가 README 의 표를 정규식으로 파싱 — fragile
  - (b) 기대값을 `./test.sh` 의 상수로 박음 — README 와 어긋날 위험
  - 첫 사이클은 (b) 로 시작. README·`./test.sh` 양쪽 갱신을 강제하는 AGENTS.md 규칙으로 보완.

## Risks (위험 요소)

- **workflow 자체에 버그가 있으면 모든 PR 이 막힘** — 인지 방법: 본 PR 머지 시점에 workflow 결과 확인. fail 이면 `implementation-retry` 또는 `spec-revise`.
- **`jq` 미설치 환경에서 작동 안 함** — 인지 방법: `./test.sh` 첫 줄에 `command -v jq` 체크 + 명확한 에러 메시지. 사용자 로컬에서 hook 발동 시 친절한 안내.
- **컴포넌트 개수 상수 박기로 인한 false fail** — 인지 방법: 새 커맨드 추가 시 두 곳을 동시에 갱신해야 한다는 사실이 처음 1-2회 PR 에서 마찰로 드러남. 그 마찰이 견디기 어려우면 spec-revise 로 (a) 방식 검토.

## Rollback plan (롤백 계획)

- `.github/workflows/lint.yml` 삭제
- `./test.sh` 삭제 (또는 실행 권한 제거)
- `README.md` 의 hook 섹션 한 줄 되돌림
- `AGENTS.md` `## 절대 하지 말 것` 의 새 한 줄 되돌림
- 사용자 영향 없음 (이 레포 자체 인프라에만 한정, 플러그인 매니페스트 변경 없음 → 버전 bump 불필요)
