# Spec ID: 013 — 스플릿 모드 스킬 + 데일리·demo 의식

> 모드 폭 완성 — 3-모드 중 마지막 *스플릿* 모드의 자산을 추가. 모드 커버리지 1.85 → 2.85 로 *3/3 거의 완성*.

## What (무엇을)

스플릿 모드 (며칠~2주 사이클) 의 *오케스트레이션 스킬* + *spec template* + *데일리·demo 의식* 한 묶음:

1. **`skills/fde-sprint-workflow/SKILL.md` 신규** — 스플릿 모드 트리거·의식 오케스트레이션
2. **`commands/fde-sprint.md` 신규** — `/fde-sprint <제목> [며칠]` 며칠 단위 spec 생성 (deadline 강제)
3. **`commands/fde-daily.md` 신규** — `/fde-daily` 데일리 한 줄 학습 기록
4. **`commands/fde-demo.md` 신규** — `/fde-demo` movable demo 결과 + 가설 검증 기록
5. **`templates/spec-template-sprint.md` 신규** — *deadline 슬롯 필수* + throwaway 허용 표시 + demo 일자
6. **`templates/daily-ratchet-template.md` 신규** — 데일리 한 줄 양식

동기 갱신:
- `skills/fde-workflow/SKILL.md` — 스플릿 키워드 안내가 `fde-sprint-workflow` link 포함
- `skills/discovery-echo/SKILL.md` — 스플릿 모드 약화 안내가 link 포함
- `skills/fde-champion-workflow/SKILL.md` — 스플릿 키워드 안내가 link 포함
- `docs/fde-criteria.md § 1.4` — 스플릿 ❌ → ✅ (자산 6개 추가)
- `docs/fde-criteria.md § 7.2` — 스플릿 *미지원* 결정 무효화 (자산 완성)
- `templates/AGENTS.md` 모드 표 — 스플릿 행 갱신
- `README.md` — 4 skills · 11 commands · 7 templates

매니페스트:
- 두 plugin.json `version 0.4.0 → 0.5.0` (minor — 새 모드 자산)
- description + interface 갱신
- marketplace.json shortDescription

검증:
- `test.sh` — `skills_count` 3 → 4, `EXPECTED_COMMANDS` 8 → 11, `templates_present` 5 → 7

## Why (왜)

PR #24 가 스플릿 모드를 *명시적으로 미지원* 으로 결정. 그러나 헌장 § 5.2 의 *FDE complete* 등급은 모드 *3/3 완전 지원* 필요. 스플릿 모드 자산 추가로 모드 *폭* 완성.

또한 스플릿 모드는 FDE 의 *원형* 가까운 패턴 — Palantir 의 초기 hit team 활동이 며칠 단위였음. 모드 *완전성* 회복.

세 가지 가치:

1. **모드 매트릭스 세로축 완성** — 1.85 → 2.85. 헌장 § 5.2 표의 *모드 3/3* 행 진입.
2. **속도 강제 시작** — 스플릿 모드 spec 은 *deadline 필수* — F2 의 첫 번째 bullet 부분 충족 (모드 한정).
3. **외부 사용자 진입 장벽 낮춤** — *며칠 sprint* 사용자가 도구를 *맞춤 모드* 로 사용 가능. 1인 메이커·실험 프로젝트에서 채택률 ↑.

## Expected outcome (정량)

- 모드 커버리지 1.85 → **2.85** (스플릿 자산 6개 추가). 측정: `find skills commands templates | grep -c -E "sprint|daily|demo"` 이전 0 → 이후 6
- 스플릿 키워드 ("스프린트·며칠·movable demo·throwaway") 시 *자동 스킬 활성*. 측정: 트리거 키워드 → fde-sprint-workflow 활성
- 헌장 § 1.4 의 스플릿 행 *❌ → ✅*. 측정: 헌장 grep
- F2 (속도) 의 모드 한정 진척 — *스플릿 spec 은 deadline 필수* 충족. 헌장 평가의 모드별 정밀화 트리거.

## Done means (완료 정의)

### 신규 자산 (6)

- [ ] `skills/fde-sprint-workflow/SKILL.md` 존재:
  - 모드 명시 헤더 (헌장 § 1.4 link)
  - 스플릿 모드의 *3 페이즈* (Observe → Sketch → Build → Daily → Demo)
  - 각 페이즈의 의식 (매일 끝의 daily ratchet, sprint 종료의 demo)
  - 트리거 키워드 (스프린트·며칠 안에·movable demo·throwaway·매일 끝)
  - 모드 외 사용 안내 (딥다이브/챔피언 키워드 감지 시 본 스킬 비활성)
  - 관련 헌장 섹션 + 관련 스킬 cross-link
- [ ] `commands/fde-sprint.md` 신규 — `/fde-sprint <제목> [며칠]`
  - 인자: 제목 (필수) + 며칠 (선택, default 7)
  - 출력: `specs/sprint/{ID}-{kebab}.md` (sprint 전용 폴더) 또는 일반 `specs/{ID}-{kebab}.md` 에 `mode: split` frontmatter
  - `templates/spec-template-sprint.md` 기반 + deadline 자동 계산
- [ ] `commands/fde-daily.md` 신규 — `/fde-daily [학습]`
  - 매일 끝의 한 줄 학습 기록 (예: "오늘 X 를 시도했는데 Y 가 작동 안 함")
  - 출력: `.harness/daily-ratchet.log` 에 추가
  - 학습이 *AGENTS.md 양의 학습 후보* 면 사용자에게 promote 안내
- [ ] `commands/fde-demo.md` 신규 — `/fde-demo`
  - sprint 종료 시점의 *움직이는 데모* 실행 결과 + Operator 반응 기록
  - 출력: `.harness/demo-log.md` (sprint ID 별 entry)
  - Spec 의 Expected outcome 가설과 *실제 demo 결과* 비교
- [ ] `templates/spec-template-sprint.md` 신규:
  - frontmatter: `mode: split`, `created: {ISO}`, `deadline: {ISO+며칠}`, `throwaway: true|false`
  - What (한 줄 — *움직이는 demo* 형식, 예: "X 를 매일 8시 자동 실행하는 스크립트")
  - Why (Operator 의 며칠 안 검증할 가설)
  - Done means (demo-able 체크리스트 — *진짜로 보여줄 수 있는* 항목만)
  - Out of scope (스프린트의 *나머지* — 다른 sprint 후보)
  - Daily ratchet 슬롯 (매일 한 줄 학습 누적)
  - Demo 일자
- [ ] `templates/daily-ratchet-template.md` 신규:
  - 매우 짧은 양식 (10 줄 이하)
  - 항목: 일자·spec ID·오늘 학습 한 줄·내일 의도 한 줄·정체된 부분 (있으면)

### 동기 갱신 (4 곳 규칙)

- [ ] `skills/fde-workflow/SKILL.md` — 스플릿 키워드 안내가 `fde-sprint-workflow` link 포함
- [ ] `skills/discovery-echo/SKILL.md` — 스플릿 모드 약화 안내가 sprint-workflow link 포함
- [ ] `skills/fde-champion-workflow/SKILL.md` — 스플릿 키워드 안내가 sprint-workflow link 포함
- [ ] `docs/fde-criteria.md § 1.4` — 본 도구 스플릿 행 *❌ → ✅*, 모드 커버리지 1.85 → 2.85 갱신
- [ ] `docs/fde-criteria.md § 7.2` — *스플릿 모드 미지원* 결정 *무효화* 명시 (spec 013 으로 완성)
- [ ] `templates/AGENTS.md` 모드 표 — 스플릿 행 갱신 (자산 명시)
- [ ] `README.md` — 컴포넌트 표 (4 skills · 11 commands · 7 templates) + 스플릿 ✅ 표기

### 매니페스트 + 검증

- [ ] `.claude-plugin/plugin.json` version `0.4.0 → 0.5.0` + description (스플릿 ❌ → ✅)
- [ ] `.codex-plugin/plugin.json` 동기 + interface 갱신
- [ ] `marketplace.json` shortDescription 갱신 — "3-모드 (스플릿·딥다이브·챔피언)"
- [ ] `test.sh` — `skills_count` 3 → 4, `EXPECTED_COMMANDS` 8 → 11, `templates_present` 5 → 7 (sprint + daily 추가)
- [ ] `./test.sh` ALL PASS (16/16)
- [ ] GitHub Actions check success

## Out of scope (안 하는 것)

- **스플릿 모드 *완전* (1.0)** — 본 spec 은 0.85 까지. KPI 자동 추적·sprint retrospective 자동화 등은 별도 spec
- **스플릿 → 딥다이브 전환 자동 감지** — 사이클 누적 시 자동 모드 전환 — 별도 spec
- **F# 깊은 진척** — F2 의 스플릿 모드 한정 부분 진척만, *전체 모드* 강도 강화는 별도 spec
- **`/fde-sprint` 의 git branch 자동 생성** — `feature/sprint-{ID}` 같은 branch 자동화 — 별도 spec
- **demo 결과의 외부 stakeholder 공유 자동화** (slack·email 등) — 본 spec 은 *로컬 기록만*
- **self-evaluation 재실행** — 본 PR 머지 후 별도 (spec 014 후보)

## Context (참고 자료)

- 직전 사이클 spec 011 — 챔피언 모드 자산 완성
- 헌장 § 1.4 — 3 모드 정의 + 본 도구 스플릿 미지원 (지금까지)
- 헌장 § 7.2 — 스플릿 모드 미지원 결정 (spec 009)
- 직전 self-evaluation (spec 012) — *Y 스플릿 모드 스킬* 을 추천 우선순위 1순위로 명시

## Open questions (불명확한 점)

- **sprint spec 의 *별도 폴더* (`specs/sprint/`) vs *frontmatter mode*** — 본 spec 은 *frontmatter mode* 로 결정. 폴더 분리는 차후 데이터 누적 후
- **데일리 한 줄의 *영속화 위치*** — `.harness/daily-ratchet.log` (간단) vs `daily-ratchet/{YYYY-MM-DD}.md` (구조화). 본 spec 은 *log 형식* (간단). 차후 구조화 가능
- **F2 의 모드 한정 진척 인정** — 헌장 § 5.2 표의 모드별 정밀화 미해결. 본 spec 은 *진척 신호만* 추가, 헌장 평가 룰 변경은 별도

## Risks (위험 요소)

- **PR 규모 큼 (~14 파일)** — 6 신규 + 7 동기 + 1 매니페스트. 분리 시 6 신규 자산이 *부분만* 있으면 의미 약함 (skill 만 있고 command 없으면 무용지물 등). 단일 PR 유지
- **트리거 키워드 3 스킬 충돌** — 3 스킬이 *서로의 모드 키워드* 를 안내해야 함 (cross-link). 실수로 누락 시 사용자 혼란. 인지: 모든 스킬 본문의 "모드 외 사용 안내" 섹션 *2 모드 모두 link* 확인
- **`mode: split` frontmatter 가 `/fde-plan` 등 기존 커맨드와 충돌** — 기존 `/fde-plan` 은 frontmatter 무시. 충돌 없음. 다만 향후 frontmatter 처리 시 *모드별 분기* 필요
- **데일리 의식이 *과중* 해 사용 안 함** — 매일 한 줄도 부담. 인지: 본 spec 의 daily 양식은 *최소화* (3-4 줄), 점진 정제

## Rollback plan (롤백 계획)

- 신규 6 자산 삭제 (skill · 3 commands · 2 templates)
- 동기 갱신 git revert
- 매니페스트 version `0.5.0 → 0.4.0`
- `test.sh` 의 카운트 되돌림
- 사용자 영향: 스플릿 모드 사용자는 *적응 사용* 만 가능 (v0.4.0 상태로 복원)

---

## 부록 — 본 spec 의 self-check (헌장 § 6.1 + 부록 A)

```
변경: 스플릿 모드 스킬 + 데일리·demo 의식
spec: specs/013-sprint-mode-skill.md

진척 평가:
  F1 (co-location)         ⬛ 진척 없음  ☑ 의식적 보류
  F2 (속도)                 🟡 모드 한정 진척  ⬜ — 스플릿 mode 의 spec
                            은 deadline 필수. § 5.2 모드별 정밀화 미해결.
                            보수적으로 진척 없음 + 모드 한정 신호 명시.
  F3 (우선순위)             ⬛ 진척 없음  ☑ 의식적 보류
  F4 (operator 언어)        ⬛ 진척 없음  ☑ 의식적 보류
  F5 (양방향 학습)          ⬛ 진척 없음  ☑ 의식적 보류 — daily-ratchet 가
                            *읽기* 만, 양방향 영속화 메커니즘은 미구현

3-Actor Model 영향:
  ☑ 책임 분리 위반 가능성 없음 — sprint mode 의 모든 의식은 Engineer
     가 *Operator 와 매일 옆에서* 진행. F1 의 강화 방향

의식적 보류 사유:
  본 spec 은 *F# 진척* 이 아니라 *모드 커버리지 폭 완성* 사이클.
  헌장 § 5.2 2-차원 표의 *세로 한 칸 (모드 1.85 → 2.85)* 이동.
  F2 의 모드 한정 부분 진척은 헌장 평가 룰의 *모드별 정밀화* 미해결
  큐 후보. 보수적으로 등급 변화 없음으로 평가.

집계: 깊은 진척 0 + 얕은 진척 0 + 의식적 보류 5 + 우연한 미진척 0

판정:
  ☑ 머지 가능
  근거: 모드 폭 완성 — 스플릿 ❌ → ✅. 헌장 § 5.2 표의 *세로* 진척.
       FDE complete 등급으로의 마지막 세로 단계.
```
