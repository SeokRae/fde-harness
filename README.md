# FDE Harness — Claude Code & Codex Dual Plugin

Forward Deployed Engineer 실천 일부를 차용한 AI 코딩 에이전트 하네스 플러그인입니다. **Claude Code와 OpenAI Codex 양쪽에서 동일하게 작동**합니다.

> **현재 등급: FDE-inspired** (2-차원 평가) — 헌장 [`docs/fde-criteria.md`](docs/fde-criteria.md) § 5.2 기준.
>
> **지원 모드** (헌장 § 1.4 의 3 모드 모두):
> - 스플릿 (며칠~2주 사이클) 🟢 거의 완전 (sprint·daily·demo — `/fde-sprint` + `/fde-daily` + `/fde-demo`)
> - 딥다이브 (1~3개월 사이클) ✅ 기본
> - 챔피언 (6개월+ 사이클) 🟢 거의 완전 (graduation + 월간 리뷰 — `/fde-graduate` + `/fde-monthly-review`)
>
> 자기평가 결과·등급 결정 근거·강화 후보는 [`docs/fde-self-evaluation.md`](docs/fde-self-evaluation.md) 참조.

## 무엇을 하는가

- `specs/` 폴더에 사람이 작성한 명세를 AI 에이전트가 읽고 코드로 변환합니다
- 구현 전 계획 보고와 인간 승인 게이트를 강제합니다
- 실패 패턴을 `AGENTS.md`의 "절대 하지 말 것" 섹션에 누적시켜 같은 실수를 반복하지 않게 합니다 (Ratchet 원리)

## 개념 한 장 요약

```mermaid
flowchart TB
  subgraph Cycle["🔄 5단계 사이클"]
    Plan["/fde-plan<br/>① Discovery + ② Planning"]
    Imp[③ Implementation]
    Done["/fde-done<br/>④ Verification + ⑤ Ratchet"]
    Plan --> Imp --> Done --> Plan
  end

  Spec[📄 specs/*.md<br/>Echo가 쓰는 계약]
  Rules[📜 AGENTS.md<br/>Ratchet으로 자라는 규칙]

  Spec --> Plan
  Done -. "실패 경험" .-> Rules
  Rules -. "다음 세션부터 적용" .-> Plan

  style Spec fill:#fef3c7,stroke:#f59e0b,stroke-width:2px
  style Rules fill:#dbeafe,stroke:#3b82f6,stroke-width:2px
```

### 이 다이어그램을 구성하는 4가지 최소 개념

1. **Echo / Delta 분리** — 사용자가 Echo(도메인 전문가), AI가 Delta(구현자). 누가 무엇을 아는지를 분리한다.
2. **Spec = 계약** — Echo가 쓰는 `specs/*.md`. Why · What · Done means · Out of scope 4슬롯.
3. **승인 게이트** — `/fde-plan` 이 **코드 작성 전 Echo의 명시적 합의** 를 강제한다.
4. **Ratchet** — 실패 → 한 줄 규칙 → `AGENTS.md`. **한 방향으로만 자란다** (제거 금지).

> 4가지 중 하나라도 빠지면 방법론이 작동하지 않습니다.
> - 두 역할의 책임 상세 → `/fde-init` 후 생성되는 `AGENTS.md` 의 `## 두 역할` 섹션
> - 개념도 전체 (5단계 사이클·Ratchet·컴포넌트 매핑·설계 근거) → **[docs/concepts.md](docs/concepts.md)**

## 포함된 컴포넌트

- **4 Skills**:
  - `skills/fde-workflow/` — 딥다이브 모드 5단계 워크플로우 (Discovery → Plan → Implement → Verify → Ratchet)
  - `skills/discovery-echo/` — 딥다이브 모드의 Discovery 단계 보조 (노트→draft, 5가지 최소 규칙)
  - `skills/fde-champion-workflow/` — 챔피언 모드 오케스트레이션 (graduation + 월간 리뷰 + champion 식별)
  - `skills/fde-sprint-workflow/` — 스플릿 모드 오케스트레이션 (며칠 sprint + daily + demo)
- **11 Slash Commands**:
  - `/fde-init` — 새 프로젝트에 FDE 폴더 구조 초기화
  - `/fde-note <제목>` — 새 Discovery 노트를 템플릿으로 생성 (딥다이브 모드)
  - `/fde-draft [노트ID]` — 노트를 spec 초안으로 옮김 (딥다이브)
  - `/fde-spec <제목>` — 정식 spec 파일을 템플릿으로 생성 (딥다이브)
  - `/fde-plan` — 다음 spec의 구현 계획 보고 (코드 작성 없음)
  - `/fde-done` — 검증 후 완료 처리 및 Ratchet 학습
  - `/fde-graduate <champion>` — 챔피언 모드 transfer (Long-term 사용 후 고객측 champion 인수)
  - `/fde-monthly-review [YYYY-MM]` — 챔피언 모드 월간 리듬 의식
  - `/fde-sprint <제목> [며칠]` — 스플릿 모드 sprint spec 생성 (deadline 강제)
  - `/fde-daily [학습]` — 스플릿 모드 매일 끝 한 줄 학습 기록
  - `/fde-demo` — 스플릿 모드 sprint 종료 demo + 가설 검증
- **7 Templates** (`templates/`): spec·note·AGENTS·graduation·monthly-review·spec-sprint·daily-ratchet
- **1 Hook** (`hooks/post-tool-use.json`): `Edit`/`Write` 직후 사용자 프로젝트의 `./test.sh` 자동 실행 (없으면 no-op). **이 레포 자체도 `./test.sh` 를 갖고 있어 fde-harness 의 PostToolUse hook 을 dogfood 한다** (검증 항목은 `test.sh` 참조).
- **MCP Servers** (`.mcp.json`): filesystem, git (최소 구성)

## 설치 방법

### Claude Code

```bash
# 방법 1: 마켓플레이스를 통한 설치 (이 리포지토리가 GitHub에 있을 경우)
/plugin marketplace add SeokRae/fde-harness
/plugin install fde-harness

# 방법 2: 로컬 설치
git clone https://github.com/SeokRae/fde-harness ~/.claude/plugins/fde-harness
# Claude Code 재시작
```

### Codex

```bash
# 로컬 마켓플레이스에 등록
mkdir -p ~/.agents/plugins
cp -r ./fde-harness ~/.agents/plugins/
# ~/.agents/plugins/marketplace.json 에 항목 추가
codex plugin marketplace add ~/.agents/plugins
```

또는 `~/.codex/config.toml` 에 직접 추가:

```toml
[[plugins]]
name = "fde-harness"
path = "/path/to/fde-harness"
enabled = true
```

## 사용 흐름 (양쪽 동일)

### Track A — Spec이 이미 머릿속에 있는 경우

```
1. 프로젝트 루트에서 /fde-init 실행
   → specs/, notes/, discovery-drafts/, .harness/, AGENTS.md 생성

2. AGENTS.md를 프로젝트 도메인에 맞게 수정 (도메인 용어, 코딩 규칙 등)

3. /fde-spec 로그인 기능 실행
   → specs/001-로그인-기능.md 생성

4. spec 파일의 What/Why/Done means 채우기

5. /fde-plan 실행
   → AI가 구현 계획 보고, 사용자 승인 대기

6. "진행해" 응답
   → AI가 계획대로만 구현

7. /fde-done 실행
   → Done means 체크리스트 검증, 통과 시 done.log 기록
   → 일부 실패 시 4가지 분기(implementation-retry/spec-revise/split-spec/reject) 중 결정 → failure-log 기록
   → 실패 경험이 있었다면 AGENTS.md에 Ratchet 규칙 추가
```

### Track B — Discovery부터 시작 (인터뷰·관찰 노트 기반)

```
1. /fde-init  (Track A 와 동일)

2. /fde-note 첫-고객-인터뷰
   → notes/001-첫-고객-인터뷰.md 빈 양식 생성

3. 인터뷰 진행 → 사람이 직접 노트 작성 (AI는 읽기만)

4. /fde-draft
   → discovery-echo 스킬이 notes/001 → discovery-drafts/DRAFT-001-*.md 초안 생성
   → 모든 줄에 (notes/...) 출처 인용, 빈 슬롯은 Open questions 로 외화

5. 사람이 DRAFT 검토 → 만족스러우면 본문을 specs/001-*.md 로 직접 이동
   (AI는 specs/ 폴더에 쓰지 않음 — 사람의 승인 경계)

6. 이후 Track A 의 5~7 단계와 동일 (/fde-plan → 구현 → /fde-done)
```

> Discovery 트랙은 **5가지 최소 규칙**으로 AI 추론을 강하게 제약합니다 (노트에 있는 것만 사용 / 모든 줄에 출처 / Why 는 명시된 가치만 / 빈 자리는 Open questions / 정식 spec 폴더와 물리적 분리). 상세는 `skills/discovery-echo/SKILL.md` 참조.

> 한 사이클 전체 walkthrough, 결정 트리, 로그 포맷 등 상세는 **[docs/cycle-guide.md](docs/cycle-guide.md)** 참조.

## 폴더 구조

```
fde-harness/
├── .claude-plugin/plugin.json    # Claude Code manifest
├── .codex-plugin/plugin.json     # Codex manifest
├── .mcp.json                     # MCP 서버 설정
├── marketplace.json              # 로컬 마켓플레이스 정의
├── skills/
│   ├── fde-workflow/SKILL.md     # 공유 Agent Skill (양쪽 표준)
│   └── discovery-echo/SKILL.md   # Discovery 보조 — 노트 → spec 초안 (5가지 최소 규칙)
├── commands/                     # Claude Code 슬래시 커맨드
│   ├── fde-init.md
│   ├── fde-note.md
│   ├── fde-draft.md
│   ├── fde-spec.md
│   ├── fde-plan.md
│   └── fde-done.md
├── templates/
│   ├── spec-template.md          # 사용자 프로젝트로 복사할 spec 템플릿
│   ├── note-template.md          # Discovery 노트 템플릿 (사람만 채움)
│   └── AGENTS.md                 # 사용자 프로젝트로 복사할 AGENTS 템플릿
├── hooks/
│   ├── post-tool-use.json        # PostToolUse hook (./test.sh 자동 실행)
│   └── README.md                 # hook 형식·비활성화·추가 후보
├── specs/
│   └── 001..003-...md            # 이 레포가 자기 자신에게 적용한 spec 들
├── docs/
│   ├── concepts.md               # FDE 방법론 개념도 (Mermaid)
│   └── cycle-guide.md            # 한 사이클 walkthrough + 결정 트리 + 로그 포맷
├── AGENTS.md                     # 이 레포 자체의 기여자용 지침
├── LICENSE
└── README.md
```

## 다음으로 추가할 만한 것 (트리거 기준)

이 MVP는 의도적으로 최소화되어 있습니다. 다음 증상이 보일 때 해당 컴포넌트를 추가하세요.

| 증상 | 추가할 것 |
|------|----------|
| AI가 도메인 지식을 잘못 추측 | Ontology 모듈 (skills/ontology-builder/) |
| 같은 실수를 다른 형태로 반복 | 장기 메모리 시스템 |
| Plan 페이즈에서 AI가 코드를 만지려 함 | PreToolUse hook (hooks/pre-tool-use.json) — 가드 파일 기반 잠금 |
| 위험한 명령 시도 | Guardrail hooks (hooks/permission-request.json) |
| 한 spec이 너무 큰 작업 | Planner/Coder 서브에이전트 분리 (agents/) |

## 라이선스

MIT — 자유롭게 fork해서 본인 팀 도메인에 맞게 수정하세요.
