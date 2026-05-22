# Spec ID: 009 — FDE 3-모드 명시 + 챔피언 graduation 시작

> 헌장의 평가 차원을 *1차원* (F# 강도) 에서 *2차원* (F# 강도 × 모드 커버리지) 로 확장. 챔피언 모드의 *첫 자산* (graduation 메커니즘) 을 시작 자산으로 추가.

## What (무엇을)

세 가지를 한 묶음:

1. **헌장 갱신 — 3 모드 정의 + § 5 2차원 등급화**
   - `docs/fde-criteria.md` § 1 에 신규 절 `## 1.X 도구의 작동 모드` — 스플릿·딥다이브·챔피언 정의 + 강도 매트릭스
   - `docs/fde-criteria.md` § 5 갱신 — *F# 강도 × 모드 커버리지* 2 차원 등급
   - `docs/fde-criteria.md` § 7.2 에 결정 추가 — 본 도구 기본 모드 = 딥다이브, 스플릿·챔피언 미지원이 *의식적 결정*

2. **챔피언 graduation 첫 자산**
   - `commands/fde-graduate.md` 신규 — Engineer → 고객측 챔피언 transfer 메커니즘 첫 자산
   - `templates/graduation-template.md` 신규 — 멘토 transfer 양식 (도메인 지식 압축·검증된 패턴·오픈 큐·차후 contact)

3. **사용자 인터페이스 갱신**
   - `templates/AGENTS.md` 에 "이 프로젝트의 모드" 슬롯 추가 (필수)
   - `README.md` 의 모드 표기 + 새 등급 체계 + 신규 커맨드 표기
   - 두 매니페스트 version `0.2.1 → 0.3.0` (minor — 새 capability 추가)

## Why (왜)

직전 사이클 검토에서 식별:

1. **헌장의 1차원 평가** — spec 008 의 self-evaluation 이 "딥다이브 가정" 으로 한정됐는데 그 가정이 헌장에 명시 안 됨. F# 강제 카운트가 *어느 모드의* 강제인지 모호.
2. **챔피언 모드 자산 0** — 6개월+ Long-term 사용 시나리오의 자산이 *전무*. graduation·platform transfer·멘토 전수 메커니즘 부재. *부재가 의식적 결정* 인지 *우연한 미진척* 인지 헌장에 미정의.
3. **이름 정직성의 한 축 미고려** — 현재 "FDE-inspired" 등급이 *모드 커버리지 1/3* 를 반영 안 함. 진짜 정직한 평가는 *2 차원* 이어야 함.

본 spec 머지 후 fde-harness 의 self-evaluation 이 *2차원 좌표* 로 표현 가능 → 다음 사이클의 우선순위 결정 정밀화.

## Expected outcome (정량)

- 본 PR 후 헌장 § 5 가 *2차원 등급* 으로 평가 가능 — 측정: 다음 self-evaluation (재실행) 이 "딥다이브 모드 내 F# 강도 + 모드 커버리지 1/3" 형식으로 보고
- 본 PR 후 사용자가 *모드 의식적으로 선택* 가능 — 측정: `templates/AGENTS.md` 의 mode 슬롯이 사용자 프로젝트 의 첫 응답에서 채워짐
- `/fde-graduate` 의 첫 사용 사례 — 측정: 본 PR 머지 후 *다음 사이클 중 1회 이상* graduation template 으로 transfer note 생성됨 (자기 적용 가능)

## Done means (완료 정의)

### 헌장 (2차원화)

- [ ] `docs/fde-criteria.md` § 1 직후에 새 절 `## 1.X 도구의 작동 모드` 추가:
  - 3 모드 정의 (스플릿·딥다이브·챔피언) — 기간·핵심 성격·강도 매트릭스
  - 모드별 F1-F5 강도 차이 (스플릿 = F1·F2·F3 최대 / 챔피언 = F4·F5 최대)
  - 모드 전환 트리거 (스플릿 → 딥다이브 → 챔피언)
- [ ] `docs/fde-criteria.md` § 5 (3-Tier 등급) 을 *2차원* 으로 갱신:
  - 가로축: F# 강제 강도 (얕은 / 깊은)
  - 세로축: 모드 커버리지 (1/3 / 2/3 / 3/3)
  - 새 등급명: *FDE complete*, *FDE proper*, *FDE-inspired*, *이름에서 FDE 제외*
- [ ] `docs/fde-criteria.md` § 7.2 (결정 항목) 에 추가 — 본 도구 기본 모드 = 딥다이브, 스플릿·챔피언은 *부분 지원* 또는 *미지원* 이 의식적 결정

### 챔피언 graduation 자산

- [ ] `commands/fde-graduate.md` 신규:
  - 입력: 차기 챔피언 (고객측 인재) 식별 + 기간
  - 출력: `graduation/YYYY-MM-DD-{champion}.md` 파일 — 도메인 지식·검증된 패턴·미해결 큐·차후 contact·인수 일정
  - `templates/graduation-template.md` 를 base 로 사용자 입력 받아 채움
- [ ] `templates/graduation-template.md` 신규:
  - 도메인 용어 (AGENTS.md 의 `## 운영자가 가르친 것` 의 압축)
  - 검증된 패턴 (`## 검증된 패턴` 의 압축 — 본 PR 의 spec 009 시점에는 빈 섹션, 미래 양의 학습 자산이 들어올 자리)
  - 오픈 spec 큐 (specs/ 의 미완료 spec ID + 한 줄 요약)
  - 차후 contact (Engineer 의 비동기 channel 후보)
  - 인수 일정 (인수 3 페이즈: shadow → pair → solo)

### 사용자 인터페이스 갱신

- [ ] `templates/AGENTS.md` 에 `## 이 프로젝트의 모드` 섹션 신규 (3-Actor 직후):
  - 사용자가 직접 선택 — 스플릿 / 딥다이브 (default) / 챔피언
  - 모드별 의무 행위 안내
- [ ] `README.md` 갱신:
  - 모드 표기 추가 ("현재 도구가 지원: 딥다이브 모드 ✓, 챔피언 일부 ✓, 스플릿 ❌")
  - 새 등급 체계 한 줄 (2차원)
  - 신규 커맨드 표기 (`/fde-graduate`)
  - 포함된 컴포넌트 표 갱신 (commands 7개)

### 매니페스트 + 검증

- [ ] `.claude-plugin/plugin.json` version `0.2.1 → 0.3.0` + description 의 모드 정보 한 줄 추가
- [ ] `.codex-plugin/plugin.json` 동기
- [ ] `marketplace.json` shortDescription 의 모드 정보 한 줄
- [ ] `./test.sh` 의 `EXPECTED_COMMANDS=6` → `EXPECTED_COMMANDS=7` 갱신
- [ ] `./test.sh` ALL PASS
- [ ] GitHub Actions check success

## Out of scope (안 하는 것)

- **스플릿 모드 자산** — `/fde-sprint` · `spec-template-split.md` · daily ratchet 의식 등. 본 PR 의 챔피언 첫 자산 후 별도 spec
- **챔피언 모드의 추가 자산** — 월간 리뷰 (`/fde-monthly-review`) · KPI 통합 · 도메인 SME 인증 등. 본 PR 은 graduation 만, 나머지 별도
- **F# 강화 (spec 006R / 양방향 학습 등)** — 모드 명시 후 다음 사이클로
- **self-evaluation 재실행** — 새 헌장으로 재평가는 별도 PR (다음 사이클의 첫 의식)
- **graduation 의 자동화** — Engineer 입력 *없이* AI 가 transfer note 생성하는 건 § 1.2 의 "AI = Echo 의 대리" 위반 — 본 PR 은 *입력 받아 채우는* 양식만 지원

## Context (참고 자료)

- 직전 검토: 사용자가 "FDE 는 기간 기준 모드 분류 + 3 사이클 패턴 제공 필요" 지적 → 본 spec 의 트리거
- 영향받는 파일: ~9-10 개
- 본 spec 은 헌장 갱신 (`docs/fde-criteria.md`) 포함 → 헌장 § 6.2 의 갱신 룰 적용

## Open questions (불명확한 점)

- **`/fde-graduate` 의 정확한 출력 형식** — graduation note 만 만들지, AGENTS.md 의 일부 섹션을 export 할지. **첫 사이클은 단순 양식** 으로, 사용 데이터 보고 정제
- **모드 슬롯의 *변경 가능성*** — 한 프로젝트의 모드가 *전환* 될 때 (스플릿 → 딥다이브) 어떤 의식? **본 PR 은 *전환 미정의*, 모드 변경 시 새 spec 으로 트리거** 권장 (Open question 으로 § 7.3 에 등록 후보)
- **2차원 등급 체계의 *세 번째 축* (시간 누적) 가능성** — 모드 외에 *얼마나 오래 사용했나* 가 등급에 영향? 본 PR 은 *2차원만* — 시간 축은 후일

## Risks (위험 요소)

- **PR 규모가 큼 (~9 파일)** — 헌장 + 새 커맨드 + 새 template + 매니페스트 동시 갱신. 리뷰 부담 ↑. 분리 시 4가지 모드 정의·graduation·AGENTS·매니페스트 가 개별 의미 약함 (한 묶음으로 가야 *2차원* 의 효과). 단일 PR 유지
- **2차원 등급이 헌장 § 5 를 *50줄 이상* 으로 비대화** — 인지: 갱신 후 § 5 길이 측정, 임계 초과 시 split-spec
- **`/fde-graduate` 의 첫 사용이 *어색* 할 수 있음** — Engineer 가 graduation 결정 시점·대상을 모를 가능성. 인지: 본 spec 의 챔피언 모드 첫 자산 = "단순 양식만". 사용 데이터 누적 후 정제
- **AGENTS.md 의 mode 슬롯이 기존 사용자에게 *추가 부담*** — 기존 v0.2.x 사용자가 v0.3.0 으로 갱신 시 새 슬롯 채워야 함. 인지: mode 슬롯에 default 값 (`딥다이브`) 명시 — 안 채워도 동작
- **챔피언 모드 첫 자산이 *모드 자체* 를 의미 있게 만들지 못함** — graduation 하나만으론 챔피언 모드 미완성. 인지: README 에 "챔피언 모드 부분 지원 — 본 v0.3.0 은 graduation 만, 월간 리뷰·KPI 통합은 미정" 명시

## Rollback plan (롤백 계획)

- 헌장 § 1.X·§ 5 2차원화·§ 7.2 모드 결정 git revert
- `commands/fde-graduate.md` + `templates/graduation-template.md` 삭제
- `templates/AGENTS.md` 의 mode 섹션 제거
- `README.md` 모드 표기·신규 커맨드 표기 되돌림
- 매니페스트 version `0.3.0 → 0.2.1` + description 되돌림
- `./test.sh` 의 EXPECTED_COMMANDS 7 → 6
- 사용자 영향: 매니페스트 + 커맨드 1개 사라짐. 이미 graduation note 만든 사용자는 파일 보존 (사용자 자산)

---

## 부록 — 본 spec 의 self-check (헌장 § 6.1 + 부록 A 양식)

```
변경: 헌장 3-모드 명시 + 챔피언 graduation 시작
spec: specs/009-modes-and-champion.md

진척 평가:
  F1 (co-location)         ⬛ 진척 없음  ☑ 의식적 보류 (도구 변경, F# 자체 강화 ❌)
  F2 (속도)                 ⬛ 진척 없음  ☑ 의식적 보류 (동일)
  F3 (우선순위)             ⬛ 진척 없음  ☑ 의식적 보류 (동일)
  F4 (operator 언어)        ⬛ 진척 없음  ☑ 의식적 보류 (동일)
  F5 (양방향 학습)          ⬛ 진척 없음  ☑ 의식적 보류 (동일)

3-Actor Model 영향:
  ☑ 책임 분리 위반 가능성 없음 — 오히려 강화 (graduation 이 Engineer → 고객측 champion 의 명시적 transfer)

의식적 보류 사유:
  본 spec 은 *F# 자체* 가 아니라 *헌장의 평가 차원 확장* 의 메타-진척.
  spec 007 이 헌장의 binding 력을 1차원에서 회복시켰다면, spec 009 는
  *모드 차원* 을 추가해 2차원 평가 가능하게 함. F# 강화는 *어느 모드의*
  F# 인지 명확해진 후 진행이 정합 — spec 010+ 의 대상.

집계: 깊은 진척 0개 + 얕은 진척 0개 + 의식적 보류 5개 + 우연한 미진척 0개

판정:
  ☑ 머지 가능 (3-Actor 위반 없음 + 모든 F# 의식적 보류 = 정직)
  근거: 모드 차원 명시화는 *모든 F# 강화의 전제 조건*. 이 도입 없이
  F# 강화하면 *어느 모드의 F#* 인지 영원히 모호. 본 spec 의 가치는
  헌장 자체의 표현력 확장.
```
