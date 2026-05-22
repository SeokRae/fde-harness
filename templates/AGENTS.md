# Agent Instructions (AGENTS.md)

> 이 파일은 Claude Code와 Codex가 세션 시작 시 자동으로 읽는 지속 컨텍스트입니다.
> Claude Code는 CLAUDE.md 도 지원하므로, 동일 내용을 심볼릭 링크로 만들어도 됩니다.

## 프로젝트 개요

<!-- 한 두 문장으로 무엇을 만드는 프로젝트인지 -->
이 프로젝트는 [도메인]을 위한 [제품 종류]입니다.

## 세 역할 — Echo · Delta · AI

> **출처**: 플러그인 헌장 [`docs/fde-criteria.md`](docs/fde-criteria.md) § 1 의 3-Actor Model. FDE 원전(2-actor: Engineer + Operator) 의 AI 시대 transpose 이며 Palantir 원전과 무관하다.

이 프로젝트에는 세 역할이 있다. FDE 방법론이 작동하려면 세 역할이 *책임 분리* 를 지켜야 한다.

| 역할 | 정체성 | 책임 영역 | 산출물 |
|------|--------|----------|--------|
| 👤 **Echo** (Operator) | 도메인 전문가, **코드 ❌**. workflow 의 실제 수행자 | 가치 정의·우선순위·수동 검증·도메인 권위 | spec 의 Why·Expected outcome (직접 인용)·Plan 응답 (승인/거절) |
| 👨‍💻 **Delta** (Engineer, 도구 사용자) | **코드 ✓**. Operator 옆에서 그의 말을 코드로 옮김 | spec 작성·승인 게이트 통과·구현·검증·Ratchet 작성 | spec 본문·코드·테스트·AGENTS.md 규칙 |
| 🤖 **AI** (Assistant) | Delta 의 인지 보조 | 반복 작업·해석 부하 흡수·코드 초안·자동 테스트 | spec draft·plan 보고·코드 generation. **Echo 와 직접 소통 ❌** |

### 잘못된 등치 (절대 하지 말 것 — 헌장 § 1.2)

- ❌ Echo = 개발자(도구 사용자) — "도메인 전문가" 정의 무너짐 → SDD 가 됨
- ❌ Delta = AI — 책임 주체 사라짐 → Operator 발화 해석할 사람 부재
- ❌ AI = Echo 의 대리 — AI 가 도메인 권위가 됨 → FDE 의 가장 큰 위반

### 책임 분리 (변경 불가 — 헌장 § 1.3)

- **Echo 만 할 수 있는 것**: 가치 정의 · 우선순위 · 수동 검증 · 도메인 권위
- **Delta 만 할 수 있는 것**: Operator 발화의 *의역 없는* 옮김 · 기술 가능성 제시 · 코드 책임
- **AI 가 할 수 *있는* 것**: Delta 의 인지 부하 흡수 (해석 제안 · 코드 초안 · 반복 검증)
- **AI 가 할 수 *없는* 것**: Echo 의 자리에 앉는 모든 행위 (가치 판단 · 우선순위 · 도메인 권위 · spec 본문의 권위적 *생성*)

### Echo (Operator) 의 4가지 책임 — 직접 수행

1. **Spec 의 Why · Expected outcome 작성** — 직접 발화 + Operator 의 정량 단위
   - Why (비즈니스 가치) · What (사용자 관점 산출물) · Done means (객관적 체크리스트) · Out of scope (경계)
   - 비어있는 슬롯이 있으면 Delta 가 추측하지 못하도록 명시적으로 표시한다

2. **Plan 평가** — `/fde-plan` 응답에 대해 "진행 / 수정 / 거절"
   - 체크 포인트: 수정 파일 합리성 · 누락된 테스트 · Out of scope 침범 여부 · 위험 누락

3. **Done means 수동 검증** — 자동화 불가 항목은 Echo 가 직접 확인
   - 브라우저 UI · 외부 API 응답 · UX 흐름 등은 Delta·AI 가 통과시킬 수 없다

4. **Ratchet 반성** — `/fde-done` 마지막 질문에 정직하게 답
   - 양방향 학습 (음의 학습 · 양의 학습 · 도메인 가르침 · 가능성 제시) — 헌장 § 2.F5
   - 거짓 반성은 노이즈, 없었다면 "없다" 가 정답

### Delta (Engineer = 도구 사용자) 의 작업 순서

1. `/fde-plan` 으로 다음 spec 의 구현 계획을 보고하고 Echo 의 승인을 기다린다
2. 승인 후 계획대로만 구현한다 (계획 외 파일을 건드리게 되면 멈추고 계획 갱신)
3. 모든 변경 후 자동 테스트가 있다면 직접 실행한다
4. `/fde-done` 으로 검증한다
   - **모두 통과** → `.harness/done.log` 에 완료 기록 후 Ratchet 단계로
   - **한 항목이라도 실패** → 4가지 분기(`implementation-retry`·`spec-revise`·`split-spec`·`reject`) 중 하나를 Echo 와 합의하고 `.harness/failure-log` 에 결정 기록

### AI 의 역할 (Delta 의 보조)

이 파일을 읽는 너(AI) 는 Delta *자신* 이 아니라 *Delta 의 도구* 이다. 이 차이가 핵심.

- spec draft 생성 *제안* — Delta 의 *재서명* 거쳐야 spec 본문 됨
- plan 보고 *초안* — Delta 가 검토 후 Echo 에게 제출
- 코드 *생성* — Delta 의 책임 하에 머지
- **하지 말 것**:
  - Echo 와의 직접 소통 (질문은 Delta 가 Echo 에게 전달)
  - 가치 판단·우선순위 결정·spec 본문의 권위적 작성
  - "Operator 가 원래 의도한 것" 추측 — 헌장 § 1.2 의 "AI = Echo 의 대리" 위반

### Delta(너 또는 AI) 의 부가 의무 — Echo 가 책임을 다하도록 돕기

- Echo 가 Spec 슬롯을 비워두면 **묻는다**. 추측해서 채우지 않는다
- Plan 에 응답이 없으면 **기다린다**. 침묵을 "진행" 으로 간주하지 않는다
- Done means 수동 항목을 **"아마 될 거 같다" 로 통과시키지 않는다**. Echo 의 명시적 확인이 필요
- 강요는 하지 않는다 — Echo 의 판단을 대신하지 않는다. 환기시키되 결정은 Echo 가 한다

## 절대 하지 말 것 (Ratchet 영역)

> 여기에 한 줄씩 규칙을 추가한다. 새 실패가 발생할 때마다 추가하되, 절대 제거하지 않는다.

- Spec의 "Out of scope" 섹션에 있는 기능은 구현하지 않는다
- 테스트가 통과하지 않은 상태로 `done` 처리하지 않는다
- 비밀키, API 키, 비밀번호를 코드나 커밋에 하드코딩하지 않는다
- `.harness/done.log` 를 수동으로 편집하지 않는다 (`/fde-done`만 사용)
- `.harness/failure-log` 도 수동 편집하지 않는다 (`/fde-done` 의 실패 분기에서만 기록)
- <!-- 새 규칙 추가 위치 -->

## 코딩 규칙

<!--
프로젝트 스택에 맞게 채워주세요. 사용 중인 한 가지 예시만 남기고 나머지는 삭제.
이 섹션이 비어있으면 AI 에이전트가 임의로 추측해서 일관성이 깨집니다.
-->

- **언어/런타임**: <!-- 예: Python 3.11 / Node.js 20 + TypeScript 5.x / Java 21 / Go 1.22 / Rust 1.78 -->
- **포맷터·린터**: <!-- 예: ruff + black / prettier + eslint / spotless + checkstyle / gofmt + golangci-lint / rustfmt + clippy -->
- **테스트 프레임워크**: <!-- 예: pytest / vitest 또는 jest / JUnit 5 / go test / cargo test — 모든 새 함수는 최소 1개 테스트 -->
- **빌드·패키지 매니저**: <!-- 예: uv / pnpm / Gradle Wrapper / go modules / cargo -->
- **커밋 메시지**: `feat(spec-{ID}): {요약}` 형식 (Conventional Commits 권장)
- **테스트 자동화**: 프로젝트 루트에 실행 가능한 `./test.sh` 를 두면 fde-harness PostToolUse hook이 `Edit`/`Write` 직후 자동 실행 (없으면 no-op). fast-fail 형식 권장 — 자세한 예시는 플러그인 설치 경로의 `hooks/README.md` 참고.

## 도메인 용어

<!-- 프로젝트 도메인의 핵심 용어 정의. AI가 잘못 추측하는 것을 방지. -->

- 

## 외부 시스템

<!-- 호출하는 외부 API, 데이터베이스, 큐 등 -->

- 

## 의사결정 기록

<!-- 중요한 아키텍처 결정과 그 이유. 미래의 AI 세션이 같은 고민을 반복하지 않도록. -->

- 
