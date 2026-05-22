---
name: fde-sprint-workflow
description: FDE 스플릿 모드 (며칠~2주 사이클) 의 자동 트리거·의식 오케스트레이션. 사용자가 "스프린트", "며칠 안에", "movable demo", "throwaway", "매일 끝", "데일리 ratchet", "/fde-sprint", "/fde-daily", "/fde-demo" 를 언급하거나, `mode: split` frontmatter 가 있는 spec 작업 시 자동으로 트리거됩니다. 딥다이브·챔피언 모드 키워드 감지 시 본 스킬 비활성 권장.
---

# FDE Sprint Workflow Skill — 스플릿 모드 전용

> **모드**: 스플릿 (Split). 헌장 [`docs/fde-criteria.md`](../../docs/fde-criteria.md) § 1.4 의 3 모드 중 *며칠~2주 사이클* 전용.
>
> **다른 모드는 본 스킬의 범위 밖**:
> - 딥다이브 (1-3개월) — [`fde-workflow`](../fde-workflow/SKILL.md) 활성
> - 챔피언 (6개월+) — [`fde-champion-workflow`](../fde-champion-workflow/SKILL.md) 활성

이 스킬은 FDE *스플릿 모드* 의 의식을 AI 코딩 에이전트의 작업 루프로 구현합니다. 며칠 안의 *움직이는 데모* 가 핵심.

## 스플릿 모드의 5 페이즈

```
1. Observe                  │ Operator 옆에서 매일. 가장 큰 마찰 1개 식별
   └─ (인터뷰 ❌, 관찰 ✅ — F1 의 강한 적용)

2. Sketch                   │ Movable demo 의 형식 결정 (며칠 안 완성 가능 범위)
   └─ /fde-sprint <제목>      며칠 단위 spec 생성 (deadline 강제)

3. Build                    │ Throwaway prototype 허용. perfectionism 금지
   └─ (코드)

4. Daily                    │ 매일 끝 한 줄 학습 기록
   └─ /fde-daily             daily-ratchet.log 에 한 줄

5. Demo                     │ Movable demo 실행 + Operator 반응 기록
   └─ /fde-demo              demo-log.md 에 결과 + 가설 검증
```

## 기본 원칙 (스플릿 모드 한정)

1. **시간 단위 = 일** — 딥다이브 (주) 나 챔피언 (월) 과 다름. 매일 의식이 핵심
2. **F1·F2·F3 가 최대 강도** — Operator *매일 옆* + 며칠 deadline + 1 워크플로 only
3. **F4·F5 약화 OK** — 며칠 사이클이라 KPI 측정·양방향 학습 영속화 부족 OK. 다만 *demo 결과 → 가설 검증* 의 빠른 회수 (F4 의 *예시 적용*)
4. **Throwaway 허용** — Done means 가 *demo-able* 형식이면 OK. *production-ready* ❌. 가설 검증되면 *다음 사이클에서 다시 build*

## 의식 가이드라인

### 데일리 ratchet (`/fde-daily`)

매일 끝. 한 줄 학습 기록:

```
오늘 X 를 시도했는데 Y 가 작동 안 함 → 내일 Z 로 시도
```

- `.harness/daily-ratchet.log` 에 추가
- 양의 학습 (예: "이 패턴이 통한다") 이면 *AGENTS.md* 양의 학습 섹션 promote 후보
- 음의 학습 (예: "이건 다음에 안 함") 이면 *절대 하지 말 것* promote 후보
- 누적되면 sprint 종료 시 *retrospective* 자료

### Demo (`/fde-demo`)

sprint 종료 시점. *움직이는* 데모 실행:

```
1. Spec 의 Done means 가 *demo-able* 인지 확인
2. Operator 옆에서 demo 실행
3. Operator 반응 기록 (직접 인용 우선)
4. Spec 의 Expected outcome 가설과 비교
5. 다음 사이클 결정:
   - 가설 검증됨 → 딥다이브 모드로 전환 검토 (더 구조화)
   - 가설 부분 검증 → 같은 sprint 모드로 1회 더
   - 가설 부정 → reject, 다른 마찰 우선순위
```

## 모드 외 사용 안내

사용자 메시지에 *다른 모드 키워드* 가 보이면 본 스킬은 비활성 권장:

- **딥다이브 키워드**: "spec 구현", "다음 spec", "딥다이브 사이클", "Done means", "Spec ID" → [`fde-workflow`](../fde-workflow/SKILL.md) 활성
- **챔피언 키워드**: "champion 인수", "Long-term", "월간 리뷰", "graduation" → [`fde-champion-workflow`](../fde-champion-workflow/SKILL.md) 활성

## 트리거 키워드

다음 표현이 사용자 메시지에 나오면 이 스킬을 적용한다 (스플릿 모드 가정):

- "스프린트", "sprint", "며칠 안에", "며칠 단위"
- "movable demo", "움직이는 데모", "throwaway", "버려도 됨"
- "매일 끝", "데일리 ratchet", "오늘 학습"
- `/fde-sprint`, `/fde-daily`, `/fde-demo`
- 모드 명시 — "스플릿", "Split", "Hit team"
- `mode: split` frontmatter 가 있는 spec 작업
- `.harness/daily-ratchet.log` 가 존재하는 환경

**다른 모드 키워드 감지 시 본 스킬 비활성** — 위 § "모드 외 사용 안내" 참조.

## 관련 헌장 섹션

- [`docs/fde-criteria.md`](../../docs/fde-criteria.md) **§ 1.4** — 3 모드 정의 + 본 도구 스플릿 모드 지원 (spec 013 부터)
- [`docs/fde-criteria.md`](../../docs/fde-criteria.md) **§ 2.F1·F2·F3** — 스플릿 모드에서 최대 강도
- [`docs/fde-criteria.md`](../../docs/fde-criteria.md) **§ 7.2** — 스플릿 모드 미지원 결정 무효화 (spec 013)

## 관련 스킬

- [`skills/fde-workflow`](../fde-workflow/SKILL.md) — 딥다이브 모드. 스플릿 demo 가 *진짜 통한다* 확인 시 전환
- [`skills/fde-champion-workflow`](../fde-champion-workflow/SKILL.md) — 챔피언 모드. 딥다이브 누적 후 진입
- [`skills/discovery-echo`](../discovery-echo/SKILL.md) — 딥다이브의 Discovery 보조. 스플릿 모드는 *옆에서 관찰* 이 우선이라 본 스킬 사용 약화

## 관련 슬래시 커맨드

- `/fde-sprint <제목> [며칠]` — Sprint spec 생성 (`templates/spec-template-sprint.md` 기반)
- `/fde-daily [학습]` — 매일 끝 한 줄 학습 기록 (`.harness/daily-ratchet.log`)
- `/fde-demo` — Sprint 종료 demo + 가설 검증 기록 (`.harness/demo-log.md`)
