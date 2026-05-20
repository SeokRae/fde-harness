# Hooks

이 폴더의 hook 설정들이 플러그인 활성화 시 자동으로 적용됩니다.

## 활성 hooks

### post-tool-use.json — 자동 테스트 실행

코드 변경(`Edit` · `Write` · `MultiEdit`) 직후 사용자 프로젝트의 `./test.sh` 를 실행합니다.

**동작**:

- `./test.sh` 가 **executable** 이면 실행
- 없거나 실행 권한 없으면 **no-op** (안전 가드 — 모든 프로젝트에서 무해)
- 종료 코드 0이 아니어도 후속 차단하지 않음 (`|| true`) — 결과는 stdout으로만 노출

**`./test.sh` 예시 (fast-fail 형식 권장)**:

```bash
#!/usr/bin/env bash
# 매 Edit마다 실행되므로 fast-fail로 작성한다

# 변경 파일이 코드가 아니면 skip
git diff --name-only HEAD | grep -qE '\.(py|js|ts|tsx|java|go|rs)$' || exit 0

# 프로젝트별 테스트 명령 (한 줄)
pytest -x --quiet           # Python
# npm test -- --bail        # Node
# go test ./...             # Go
# cargo test --quiet        # Rust
```

`chmod +x test.sh` 잊지 말 것.

**비활성화 방법**:

| 범위 | 방법 |
|------|------|
| 한 프로젝트만 | `./test.sh` 삭제 또는 `chmod -x test.sh` |
| 플러그인 전체 | `.claude-plugin/plugin.json` · `.codex-plugin/plugin.json` 의 `"hooks"` 필드 제거 |

## 추가 hook 후보 (specs/003+)

| 시나리오 | 후보 hook |
|---------|---------|
| Plan 페이즈 중 코드 작성 차단 | PreToolUse + matcher: tool=`edit`·`write`·`multiedit` + 가드 파일 |
| 위험한 명령 차단 | PreToolUse + matcher: commandPattern: `rm -rf` · `chmod 777` |
| 세션 시작 시 다음 spec 안내 | SessionStart |
| 커밋 메시지 자동 prefix | PreToolUse + matcher: tool=`bash` + commandPattern: `git commit` |
