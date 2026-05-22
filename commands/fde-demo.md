---
name: fde-demo
description: 스플릿 모드 sprint 종료 시점의 movable demo 실행 + 가설 검증 기록. .harness/demo-log.md 에 추가하고 다음 사이클 결정 트리거.
---

# Sprint Demo (움직이는 데모 + 가설 검증)

> **모드**: 스플릿 (헌장 § 1.4). 본 커맨드는 *sprint 종료 시점* 의 의식 — 며칠 sprint 의 *최종 검증*.

## 인자

- `$ARGUMENTS` — sprint spec ID (선택). 비어있으면 진행 중인 sprint 자동 식별.

## 절차

1. **대상 sprint spec 식별**
   - $ARGUMENTS 가 있으면 그것 사용
   - 없으면 `specs/` 의 `mode: split` + deadline 임박 spec 자동 선택
   - 0개 — 사용자에게 알림 후 종료

2. **`.harness/demo-log.md` 보장**
   - 없으면 생성 (헤더 포함: "# Sprint Demo Log")

3. **Spec 의 Done means 점검**
   - sprint 의 모든 Done means 가 *demo-able* 인지 확인
   - 미달 항목 있으면 사용자에게 알림 — "이 항목 demo 가능?" 확인

4. **Demo 실행 가이드** (사용자가 실제 demo 수행)
   - AI 는 *demo 실행 자체를 하지 않는다* — Engineer 가 Operator 옆에서 직접
   - AI 는 *demo 절차 안내* 만 (Done means 의 각 항목을 *어떻게 보여줄지*)

5. **Demo 결과 수집** (Engineer 가 직접 입력)
   - Operator 반응 — *직접 인용* 우선 ("음 이거 쓸만하네", "이건 X 가 빠졌어")
   - Done means 각 항목 통과 여부
   - Spec 의 Expected outcome 가설 vs 실제 결과 비교
   - 누적된 daily ratchet (`.harness/daily-ratchet.log`) 자동 첨부

6. **다음 사이클 결정** (Engineer 가 선택, AI 는 안내만)
   - **가설 검증됨** → 딥다이브 모드로 전환 검토 (`templates/AGENTS.md` 의 mode 슬롯 변경) + 구조화된 spec 으로 확장
   - **가설 부분 검증** → 같은 sprint 모드 1회 더 (다른 ID 의 새 sprint)
   - **가설 부정** → `reject` (헌장 § 7.2 의 spec lifecycle) + 다른 마찰 우선순위
   - **모드 전환** → 챔피언 모드 (장기 운영 단계 진입 시) 또는 다른 sprint

7. **`.harness/demo-log.md` 에 entry 추가**:
   ```markdown
   ## {ISO 8601 날짜} — spec {ID} {제목}

   ### Operator 반응
   > {직접 인용 1}
   > {직접 인용 2}

   ### Done means
   - [x] 항목 1 — 통과 (demo 에서 확인)
   - [ ] 항목 2 — 미달 ({사유})

   ### 가설 검증
   - Expected outcome: {spec 의 가설}
   - 실제 결과: {demo 에서 본 것}
   - 판정: {검증됨 / 부분 / 부정}

   ### Daily 누적
   {.harness/daily-ratchet.log 의 본 sprint 관련 entries 자동 첨부}

   ### 다음 사이클 결정
   - {모드 전환 / 같은 sprint 1회 더 / reject / 다른 sprint}
   - 근거: {Engineer 의 한 단락}
   ```

8. **`.harness/done.log` 또는 `.harness/failure-log` 갱신**
   - 가설 검증됨 + Done means 모두 통과 → done.log
   - 부분/부정 → failure-log (4가지 분기 중 하나 — `implementation-retry`·`spec-revise`·`split-spec`·`reject`)

## 절대 하지 말 것

- AI 가 demo 를 *대신 실행* 하지 않는다 — Engineer 가 Operator 옆에서 직접
- Operator 반응을 *해석/요약* 하지 않는다 — 직접 인용
- 다음 사이클 결정을 *자동 선택* 하지 않는다 — Engineer 와 Operator 의 합의
- 가설 검증 판정을 *AI 가 단독 결정* 하지 않는다 — Engineer 의 책임

## 트리거 키워드

다음 표현 시 본 커맨드 권장:
- "demo 실행", "sprint 끝", "데모 시간"
- "가설 검증", "Operator 에게 보여줄 시간"
- `/fde-demo`
