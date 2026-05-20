---
name: fde-workflow
description: Spec 파일을 코드로 변환하는 FDE 방법론 워크플로우를 수행할 때 사용합니다. 사용자가 "spec을 구현해줘", "다음 작업할 spec", "FDE 워크플로우", "specs/ 폴더의 작업"을 언급하거나, 프로젝트 루트에 specs/ 폴더가 있는 작업을 시작할 때 자동으로 트리거됩니다.
---

# FDE Workflow Skill

이 스킬은 Forward Deployed Engineer 방법론을 AI 코딩 에이전트의 작업 사이클로 구현한 것입니다. Spec → Plan → Implement → Verify → Ratchet 의 5단계 루프를 따릅니다.

## 기본 원칙

1. **Spec이 계약이다** — `specs/*.md` 파일이 "무엇을 만들지"에 대한 단일 진실 공급원(single source of truth)입니다. Spec에 없는 것은 만들지 않습니다.
2. **인간 승인 게이트** — 코드를 작성하기 전에 반드시 계획을 사람에게 보고하고 승인을 받습니다.
3. **Ratchet 원리** — 실패가 발견되면 같은 실패가 다시 일어나지 못하도록 `AGENTS.md` 또는 `CLAUDE.md`의 "절대 하지 말 것" 섹션에 규칙을 추가합니다.

## 작업 사이클

### 1단계: Discovery (다음 작업 찾기)

```
1. specs/ 폴더의 모든 .md 파일을 확인한다
2. .harness/done.log 에 ID가 없는 spec 중 가장 작은 번호를 선택한다
3. 해당 spec을 읽고 사용자에게 다음을 한 단락으로 보고한다:
   - Spec ID와 제목
   - "What" 한 줄 요약
   - "Done means" 체크리스트 개수
```

### 2단계: Planning (계획 수립)

코드를 한 줄도 작성하기 전에 다음을 사용자에게 제시한다:

```
계획:
- 수정/생성할 파일 목록 (최대 5개)
- 추가할 함수/엔드포인트 시그니처
- 작성할 테스트 케이스 목록
- 예상 위험 요소
```

사용자의 명시적 "진행해" 승인 전에는 절대 다음 단계로 넘어가지 않는다.

### 3단계: Implementation (구현)

승인된 계획대로만 구현한다. 계획에 없는 파일을 수정하게 되면 즉시 멈추고 계획을 갱신해 다시 승인받는다.

### 4단계: Verification (검증)

Spec의 "Done means" 체크리스트를 한 항목씩 확인한다:
- 자동 테스트가 정의된 항목은 직접 실행한다
- 수동 확인 항목은 사용자에게 어떻게 검증할지 명확히 안내한다

**모두 통과한 경우**: `.harness/done.log` 에 완료 기록 후 5단계 Ratchet 으로 진행.

**한 항목이라도 실패한 경우**: 사용자와 다음 4가지 분기 중 하나를 합의한다:

- `implementation-retry` — 구현 결함, 같은 spec 으로 Implementation 재진입
- `spec-revise` — spec 모호 또는 Done means 부적절, spec 수정 후 `/fde-plan` 재실행
- `split-spec` — spec 너무 큼, 일부를 별도 spec 으로 분리
- `reject` — 가치 평가 변경, 작업 중단 (spec 은 보관, done.log 에 추가 안 함)

결정은 `.harness/failure-log` 에 `{ISO 8601 UTC} {Spec ID} {decision}: {요약}` 형식으로 한 줄 기록한다.

### 5단계: Ratchet (학습 누적)

구현 중 다음 중 하나라도 발생했다면 `AGENTS.md` 또는 `CLAUDE.md`를 업데이트한다:
- 사용자가 코드를 거부하거나 큰 폭으로 수정함
- 테스트가 한 번 이상 실패한 후 통과함
- spec 해석이 모호해서 사용자에게 다시 물어봐야 했음

`AGENTS.md`의 "절대 하지 말 것" 또는 "주의사항" 섹션에 한 줄 규칙으로 추가한다. 규칙은 구체적이어야 한다 ("주의 깊게 하라" ❌ / "데이터베이스 마이그레이션은 항상 backward-compatible해야 한다" ✅).

마지막으로 `.harness/done.log` 에 spec ID를 추가한다.

## 사용 가능한 슬래시 커맨드

- `/fde-init` — 새 프로젝트에 FDE 하네스 구조를 만든다
- `/fde-spec` — 새 spec 파일을 템플릿으로 생성한다
- `/fde-plan` — 현재 진행 중인 spec의 계획을 다시 보여준다
- `/fde-done` — 현재 spec을 완료 처리한다 (검증 후)

## 트리거 키워드

다음 표현이 사용자 메시지에 나오면 이 스킬을 적용한다:
- "spec 구현", "spec을 코드로", "specs/ 폴더"
- "다음 작업", "다음 spec", "FDE 워크플로우"
- "Done means", "Spec ID"
