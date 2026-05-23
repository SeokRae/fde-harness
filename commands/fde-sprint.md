---
name: fde-sprint
description: 스플릿 모드 (며칠~2주 사이클) 의 spec 을 생성합니다. deadline 강제 + throwaway 허용. 인자로 제목과 (선택) 며칠 수를 받습니다.
---

# Sprint Spec 생성 (스플릿 모드 전용)

> **모드**: 스플릿 (헌장 § 1.4). 본 커맨드는 *며칠~2주* sprint 의 *움직이는 데모* 형식 spec 을 만듭니다.

## 인자

- `$ARGUMENTS` — 제목 (필수) + 며칠 수 (선택, default 7)
  - 예: `/fde-sprint 자동알림-스크립트` → 7일 sprint
  - 예: `/fde-sprint 자동알림-스크립트 3` → 3일 sprint
  - 며칠 수는 1-14 범위 (헌장 § 1.4 의 스플릿 모드 기간 한정)

## 절차

1. **인자 검증**
   - 제목 비어있으면 사용자에게 묻기
   - 며칠 수가 범위 (1-14) 밖이면 거부, 사용자 확인 후 진행
   - 며칠 수가 14 초과면 *딥다이브 모드 의심* — 사용자에게 `/fde-spec` (딥다이브) 권장

2. **다음 사용 가능한 ID 결정**
   - 기존 `specs/` 의 ID 들 확인 (sprint 모드도 같은 ID 시퀀스 사용)
   - zero-padded (001·002·...)

3. **파일명 결정**
   - `specs/{ID}-{kebab-제목}.md` (sprint 전용 폴더 분리 ❌ — 단일 시퀀스)

4. **deadline 계산**
   - 현재 ISO 8601 날짜 + 며칠 수 (예: `2026-05-22` + 7일 → `2026-05-29`)

5. **`templates/spec-template-sprint.md` 기반 spec 생성**
   - frontmatter 자동 채움:
     ```yaml
     ---
     mode: split
     created: {현재 ISO}
     deadline: {계산된 ISO}
     throwaway: true   # default — 사용자가 false 로 변경 가능
     ---
     ```
   - 제목 자동 채움 (인자에서)
   - 나머지 슬롯은 사용자가 채울 빈 placeholder

6. **사용자 안내**:
   - 생성된 파일 경로 (절대 경로)
   - **반드시 사람이 직접 채워야 할 빈 슬롯**:
     - What (한 줄 — *움직이는 demo* 형식)
     - Why (Operator 의 며칠 안 검증할 가설)
     - Done means (demo-able 체크리스트만 — production 형식 ❌)
   - **모드 안내**: "이 spec 은 스플릿 모드 (며칠 sprint) 입니다. 매일 끝에 `/fde-daily` 로 학습 기록, 마지막 날 `/fde-demo` 로 가설 검증."
   - **스킬 활성**: `fde-sprint-workflow` 스킬이 자동 트리거됨

## 절대 하지 말 것

- AI 가 Sprint spec 의 본문을 *채워넣지 않는다* — 사용자가 직접 (헌장 § 1.2 의 "AI = Echo 의 대리" 위반 방지)
- 14일 초과 deadline 을 *조용히 허용* 하지 않는다 — 스플릿 모드 정의 위반, 사용자 확인 필요
- 이미 같은 ID 의 spec 이 있으면 *덮어쓰지 않는다* — ID 자동 증가
- `mode: split` 이외의 모드로 본 커맨드 사용 시도 시 거부 (다른 모드는 `/fde-spec` 등 사용)

## 트리거 키워드

다음 표현 시 본 커맨드 권장:
- "스프린트 시작", "며칠 안에 만들어볼게", "sprint 만들자"
- "movable demo 만들자", "throwaway prototype"
- `/fde-sprint`
