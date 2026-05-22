# Graduation Note — {champion-id}

> **챔피언 모드의 transfer 양식** (헌장 § 1.4). Engineer → 고객측 champion 이양.
> **이 문서는 *함께 읽고 토론* 하기 위한 것**. 단순 전달 ❌.

## 메타

- **차기 champion**: {champion-id}
- **인수 시작**: {ISO 8601 날짜}
- **인수 Engineer**: <!-- Engineer 의 식별자 -->
- **챔피언 모드 시작 일자**: <!-- 도구를 처음 사용한 일자 -->
- **graduation note 생성일**: <!-- 본 파일 생성 일자 -->

## 도메인 용어

> *Champion 이 가장 먼저 흡수해야 할 도메인 vocabulary. Operator 가 가르친 단어들.*
> `AGENTS.md` 의 *"운영자가 가르친 것"* 섹션에서 자동 옮김.

<!-- AI 가 AGENTS.md 의 해당 섹션을 그대로 인용. 없으면 placeholder -->
- (도메인 용어 자산이 누적 안 됨 — F5 양방향 학습 강화가 우선)

## 검증된 패턴

> *Engineer 가 *통한다고 확인한* 한 줄 규칙·접근. champion 이 *다음 사이클에서 적용* 해야 할 것.*
> `AGENTS.md` 의 *"검증된 패턴"* 섹션에서 자동 옮김.

<!-- AI 가 AGENTS.md 의 해당 섹션을 그대로 인용. 없으면 placeholder -->
- (검증된 패턴 자산이 누적 안 됨 — F5 양방향 학습 강화가 우선)

## 절대 하지 말 것 (음의 학습)

> *Engineer 가 *겪었던* 실수. Champion 이 *같은 실수 안 하도록*.*
> `AGENTS.md` 의 *"절대 하지 말 것"* 섹션에서 자동 옮김.

<!-- AI 가 AGENTS.md 의 해당 섹션을 그대로 인용 -->

## 오픈 spec 큐

> *완료 안 된 spec 들. champion 이 *우선순위 결정* 할 자료.*
> `specs/` 의 `.harness/done.log` 에 없는 spec 들 + 각각의 What 한 줄.

<!-- AI 가 자동 채움 -->
- specs/{ID}-{kebab}.md — {What 첫 줄}
- ...

## 차후 contact

> *champion 이 *막힐 때* Engineer 에게 비동기로 물을 수 있는 channel.*

<!-- 사용자가 직접 채울 것 -->
- 채널 1 (예: 이메일, Slack DM, Discord):
- 응답 보장 시간 (예: 영업일 24h, 비영업일 best-effort):
- 응답 *못 함* 가정 기간 (예: 인수 후 6개월, 그 이후는 champion 자체 판단):

## 인수 일정 — 3 페이즈

> *FDE 실천의 표준 인수 패턴. 시간은 도구 환경·champion 능력에 따라 조정.*

### 페이즈 1 — Shadow (champion 이 Engineer 옆에서 *본다*)

- 시작 일자:
- 종료 일자:
- champion 의 의무: 매일 옆에서 관찰, 질문 자유, 코드 작성 금지
- Engineer 의 의무: 평소대로 일하되 *왜 이렇게 하는지* 항상 설명

### 페이즈 2 — Pair (champion 과 Engineer 가 *함께 한다*)

- 시작 일자:
- 종료 일자:
- champion 의 의무: 매 사이클 *최소 한 단계* 책임 (예: spec 작성·Plan 평가)
- Engineer 의 의무: champion 의 작업 *결과만* 검토, *방법* 에 개입 ❌

### 페이즈 3 — Solo (champion 이 *주도하고 Engineer 가 본다*)

- 시작 일자:
- 종료 일자:
- champion 의 의무: 사이클 전체 책임. Engineer 는 *비동기* 만
- Engineer 의 의무: 명백한 위험만 환기, 작은 마찰은 champion 의 학습 기회로 둠

### 페이즈 4 — Departure (Engineer 가 *떠난다*)

- 일자:
- champion 이 *자체 유지 가능* 한 증거:
  - [ ] 마지막 한 사이클을 champion 이 *혼자* 완주
  - [ ] champion 이 차기 champion 후보를 식별
  - [ ] Engineer 의 contact 가 *6개월간 한 번도 호출 안 됨*
- 위 셋 다 충족 시 Engineer 는 정식으로 *떠남* — 본 graduation 의 *완료*

## Champion 이 첫 며칠에 읽을 것

> *champion 에게 *순서대로* 권장하는 reading list.*

1. `AGENTS.md` — 프로젝트의 누적 규칙
2. `docs/fde-criteria.md` — 도구의 헌장
3. `docs/fde-self-evaluation.md` — 현재 도구 등급·강화 후보
4. `specs/` 의 최근 머지된 spec 3개 — 가장 최근의 도메인 진척
5. 본 graduation note — 인수 자체의 가이드

## 미해결 질문 — Engineer 가 champion 에게 *유산* 으로 남기는 질문

> *Engineer 가 답을 못 찾은 것. champion 이 *시간이 지나면서* 답을 찾을 후보.*

<!-- Engineer 가 직접 채움 -->
- 질문 1:
- 질문 2:
- 질문 3:

---

## graduation 의 *완료* 신호

champion 이 다음을 *스스로* 할 수 있으면 graduation 완료:

- [ ] 신규 spec 을 작성한다 (헌장 § 6.1 의 self-check 양식 사용)
- [ ] `/fde-plan` 응답을 평가한다 (진행/수정/거절)
- [ ] `/fde-done` 의 실패 분기를 결정한다 (4가지 중 하나)
- [ ] Ratchet 규칙을 *추가* 한다 (음의·양의·도메인·가능성 4 방향)
- [ ] 차기 champion 후보를 식별·육성한다 (재귀 — graduation 의 graduation)

위 5개 다 ✅ → champion 이 *진짜 champion* 됨. graduation 종료.
