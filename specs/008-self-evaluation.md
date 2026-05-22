# Spec ID: 008 — v0.2.0 self-evaluation 공개 + 명명 정직성 회복

> 헌장 § 5.4 의 "평가 결과 공개" 의무를 처음으로 운영. 결과에 따라 README·플러그인 매니페스트의 명명을 평가 등급에 맞게 정직화한다.

## What (무엇을)

세 가지를 한 묶음으로 처리한다:

1. **v0.2.0 self-evaluation** — 새 헌장 § 5 (3-Tier 등급) 적용. F1-F5 각각의 진척 평가 + 등급 자동 결정.
2. **평가 결과 공개** — `docs/fde-self-evaluation.md` 신규. F# 별 평가·근거·등급 결정 과정·다음 강화 후보 목록.
3. **명명 갱신** — 평가 등급에 맞게 README·plugin.json·marketplace.json 의 description 정직화. § 5.3 공통 조건 (헌장·자기평가 README 링크) 도 같이 충족.

## Why (왜) — 비즈니스 가치

PR #22 가 헌장의 binding 력을 회복시켰음. 그러나 *적용* 이 안 되면 헌장은 *장식* 으로 남는다. 본 spec 이 헌장을 *처음으로 자기 자신에게 적용* 하는 사례.

세 가지 동시 해결:

1. **헌장 § 5.4 위반 차단** — "평가 결과는 README 또는 별도 문서에서 공개" 의무 발효 중. 미공개 시 본 헌장이 자기 자신을 위반.
2. **헌장 § 5.2 위반 차단** — "자기 평가 등급보다 *높은* 명명 사용 ❌". 현재 매니페스트의 "FDE 방법론을 ... 구현한 ... 하네스" 가 v0.2.0 평가 결과 (예상 FDE-inspired) 보다 *높은* 명명 — 머지 시점부터 위반.
3. **다음 사이클 의식 시작** — § 5.4 "다음 사이클 시작 시 재평가" 의 첫 운영 사례. 이후 모든 spec PR 의 의식이 된다.

## Expected outcome (정량)

- README/plugin.json/marketplace.json 의 description 이 평가 등급과 *완전 일치* — 측정: PR 머지 직후 헌장 § 5.2 위반 0
- `docs/fde-self-evaluation.md` 공개 — 측정: 외부 사용자가 "왜 이 등급인지" 를 한 문서 읽고 답 가능
- 다음 PR 부터 *평가표가 PR 본문의 표준 부분* 이 됨 — 측정: 다음 3개 PR 의 100% 가 부록 A 양식의 self-check 를 본문에 포함

## Done means (완료 정의)

### 평가 (1)

- [ ] v0.2.0 (main = 9625b69 — 헌장 갱신 직후) 의 F1-F5 평가 완료. 각 F# 의 § 2 의 모든 bullet 을 *현재 구현* 에 비추어 충족 여부 판정
- [ ] 등급 자동 결정 — § 5.2 의 표에 따라 *깊은 진척 ≥ 3* / *강제 ≥ 2* / *강제 ≤ 1* 중 어느 것인지

### 공개 (2)

- [ ] `docs/fde-self-evaluation.md` 신규 — 다음 섹션:
  - § 1 평가 시점 (commit SHA + 헌장 버전)
  - § 2 F1-F5 각각의 진척 평가 + *근거 출처* (어느 파일·spec·hook 이 어느 bullet 을 충족하는가)
  - § 3 § 5.3 공통 조건 (3-Actor 명시·측정 추적·README 링크) 충족 여부
  - § 4 자동 결정된 등급
  - § 5 다음 사이클의 강화 후보 (어떤 F# 의 어떤 bullet 을 깊은 진척으로 끌어올릴지)
  - § 6 갱신 규칙 — *다음 평가 시점은 다음 사이클 시작 시* (§ 5.4 의 단방향 룰 따름)

### 명명 (3)

- [ ] 평가 등급에 맞게 description 갱신 (예상 등급 FDE-inspired 가정 시):
  - `README.md` 첫 단락 — "FDE 방법론을 ... 구현한 ... 하네스" → "FDE 실천 일부를 차용한 AI 코딩 에이전트 하네스" 류
  - `.claude-plugin/plugin.json` description — 동기
  - `.codex-plugin/plugin.json` description + `interface.shortDescription` + `interface.longDescription` — 동기
  - `marketplace.json` interface.shortDescription — 동기

### 헌장 § 5.3 공통 조건 (필수)

- [ ] `README.md` 에서 `docs/fde-criteria.md` 명시 링크 (이미 있음 확인 또는 추가)
- [ ] `README.md` 에서 `docs/fde-self-evaluation.md` 명시 링크 (신규 추가)
- [ ] 3-Actor Model 책임 분리가 도구 안에서 명시됨 — `templates/AGENTS.md` 의 "두 역할" 섹션이 *3-Actor* 로 갱신되거나, 별도 PR 로 미루기로 *의식적 보류* 명시
- [ ] 가치 사이클 § 3 의 *측정* 단계 추적 가능 — 현재는 미달, *의식적 보류* 명시 (spec 006R 후보)

### 매니페스트 동기

- [ ] 두 매니페스트 (`.claude-plugin/`, `.codex-plugin/`) 의 version `0.2.0 → 0.2.1` 동기 (patch — 정직성 fix 성격, 동작 capability 변경 없음)
- [ ] `./test.sh` 의 `version_sync` 가 `0.2.1` 로 통과

## Out of scope (안 하는 것)

- F1-F5 *자체* 의 강화 — spec 006R/009+ 별도 사이클
- 3-Actor Model 의 *완전한* 도구 적용 (`templates/AGENTS.md` 의 Echo·Delta·AI 3 actor 재구성) — 본 PR 에선 *의식적 보류*, 별도 spec
- 가치 사이클 § 3 의 측정 단계 도구 추가 (outcome.log 등) — 본 PR 에선 *의식적 보류*, spec 006R 후보
- spec 006 (`claude/spec-006-value-cycle` 브랜치) 운명 결정 — 본 PR 머지 후 별도
- 다른 헌장 외 문서의 명명 사용처 발견·갱신 — 본 spec 범위는 위 4개 파일만

## Context (참고 자료)

- 헌장: `docs/fde-criteria.md` (PR #21·#22)
- 평가 시점 commit: `9625b69` (PR #22 머지 직후, main HEAD)
- 직전 사이클에서 진행한 *시범 평가* (PR #22 review 응답) — 본 spec 에서 *공식 평가* 로 재실행 후 차이 비교

## Open questions (불명확한 점)

- **명명의 *정확한 문구*** — "FDE-inspired SDD harness" / "FDE 실천 일부를 차용한 AI 코딩 에이전트 하네스" / 기타. 작성 시점에 결정. *조건: § 5.2 의 등급보다 *낮은* 명명이어야 안전*.
- **평가 결과 공개 *위치*** — `docs/` 본문 + README 한 줄 요약 + 링크. 본 spec 에선 이 형식으로 진행.

## Risks (위험 요소)

- **평가 결과가 *과도하게 비관적* 으로 보일 가능성** — 외부 사용자가 "FDE-inspired" 라벨만 보고 도구 외면. 인지: `docs/fde-self-evaluation.md` 본문에 *roadmap* 포함 ("현재 FDE-inspired, F# 강화로 FDE proper 진행 중")
- **명명 변경이 *외부 incoming* 에 영향** — 이미 issue #17 같은 외부 신호가 들어온 상태. 외부 사용자에게 명명 변경의 *이유* 가 보여야 신뢰 유지. 인지: 본 PR description 에 명확히 설명
- **헌장 § 5 의 자동 등급 결정 룰이 *반대 결과* 를 줄 가능성** — 예: 예상 "FDE-inspired" 인데 평가 시 "이름에서 FDE 제외" 등급이 나오면 명명이 더 크게 바뀜. 인지: 평가가 끝난 *후* 명명 결정 (Done means 의 순서 보장 — 평가 (1) → 공개 (2) → 명명 (3))
- **헌장 § 5.3 의 *공통 조건* 중 일부가 미충족** (예: 3-Actor 가 `templates/AGENTS.md` 에 명시 안 됨) → 모든 FDE 등급 자격 박탈 가능. 인지: § 5.3 충족 여부도 평가 본문에 명시, 미달이면 등급은 *이름에서 FDE 제외* 로 강제

## Rollback plan (롤백 계획)

- 명명 변경 git revert — 0.2.0 명명으로 복원
- `docs/fde-self-evaluation.md` 삭제 (사용자 영향 없음)
- 매니페스트 version `0.2.1 → 0.2.0` 되돌림
- 사용자 영향: 명명이 *덜 정직한* 상태로 돌아감 — 권장하지 않음

---

## 부록 — 본 spec 의 self-check (헌장 § 6.1 + 부록 A 양식)

```
변경: v0.2.0 self-evaluation 공개 + 명명 정직성 회복
spec: specs/008-self-evaluation.md

진척 평가:
  F1 (co-location)         ⬛ 진척 없음  ☑ 의식적 보류 (본 spec 은 평가·공개·명명만, F# 강화 ❌)
  F2 (속도)                 ⬛ 진척 없음  ☑ 의식적 보류 (동일)
  F3 (우선순위)             ⬛ 진척 없음  ☑ 의식적 보류 (동일)
  F4 (operator 언어)        ⬛ 진척 없음  ☑ 의식적 보류 (동일)
  F5 (양방향 학습)          ⬛ 진척 없음  ☑ 의식적 보류 (동일)

3-Actor Model 영향:
  ☑ 책임 분리 위반 가능성 없음 (도구 본체 변경 없음, 매니페스트 description 만)

의식적 보류 사유:
  본 spec 은 *F# 자체* 가 아니라 *헌장의 binding 력 운영* 의 첫 사례.
  F# 의 평가는 *기록* 하고 *공개* 만 함. F# 강화는 spec 006R/009+
  에서 별도 진행. 본 PR 의 메타-진척: 헌장 § 5.4 의 "공개 의무" 와
  § 5.2 의 "정직성 원칙" 의 첫 운영.

집계: 깊은 진척 0개 + 얕은 진척 0개 + 의식적 보류 5개 + 우연한 미진척 0개

판정:
  ☑ 머지 가능 (3-Actor 위반 없음 + 모든 F# 의식적 보류 = 정직)
  근거: 본 spec 의 가치는 *F# 진척* 이 아니라 *헌장 운영 의식의 시작*.
  spec 007 이 헌장의 *binding 력* 을 회복시켰다면, spec 008 은 헌장을
  *실제로 운영* 한다.
```
