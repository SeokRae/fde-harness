---
name: fde-done
description: 현재 진행 중인 spec을 검증 후 완료 처리합니다. Done means 체크리스트를 한 항목씩 확인합니다.
---

# Spec 완료 처리 (검증 우선)

인자 (선택): $ARGUMENTS — 검증할 spec ID. 비어있으면 최근 작업한 spec 추정.

다음 절차를 따라줘:

1. **검증할 spec 선택**
   - 인자로 ID가 주어졌으면 그것을 사용
   - 아니면 가장 최근에 수정된 spec 파일을 후보로 제시하고 사용자에게 확인받음

2. **Done means 체크리스트 검증**
   spec의 "Done means" 섹션의 각 항목을 다음 기준으로 분류한다:

   - **자동 검증 가능**: 테스트 명령 실행 가능 → 직접 실행하고 결과 보고
   - **수동 확인 필요**: 사용자에게 정확한 검증 방법 안내 (예: "브라우저에서 /login 페이지 접속해서 잘못된 비밀번호 입력 시 401 응답 확인")

3. **결과 보고 형식**
   ```
   ✅ Spec {ID} 검증 결과:

   [x] 자동: POST /login 엔드포인트 존재 — 통과 (test_login_endpoint)
   [x] 자동: 잘못된 비밀번호 시 401 — 통과 (test_invalid_password)
   [ ] 수동: JWT 토큰 만료 24h — 사용자 확인 필요
       → 검증 방법: ...
   ```

4. **실패 처리 (한 항목이라도 실패한 경우)**

   Done 처리하지 않고, 사용자와 다음 4가지 분기 중 하나를 합의한다:

   | Decision | 트리거 | 다음 단계 |
   |----------|--------|---------|
   | `implementation-retry` | 구현 결함이며 spec 자체는 유효 | Implementation 재진입 (같은 spec 계속) |
   | `spec-revise` | spec 모호 또는 Done means 부적절 | spec 수정 후 `/fde-plan` 재실행 |
   | `split-spec` | 현재 spec 너무 큼, 일부는 별도로 | 새 spec 분리 + 현재 spec 축소 |
   | `reject` | 가치 평가 변경, 작업 중단 | spec 보관 (done.log 추가 안 함) |

   결정 후 `.harness/failure-log` 에 한 줄로 추가:

   ```
   {ISO 8601 UTC} {Spec ID} {decision}: {한 줄 요약}
   ```

   예시:

   ```
   2026-05-20T14:15:00Z 001 implementation-retry: DB 마이그레이션 down 누락
   2026-05-20T15:30:00Z 001 spec-revise: 수동 검증 항목 추가 필요
   2026-05-20T16:45:00Z 001 split-spec: 인증 부분을 002로 분리
   ```

   `.harness/failure-log` 파일이 없으면 빈 파일을 먼저 만들고 기록한다 (안전 가드).

5. **완료 처리 (모두 통과한 경우에만)**
   - `.harness/done.log` 에 한 줄로 추가: `{ISO 날짜} {Spec ID} {제목}`
   - 사용자에게 완료 알림 + 다음 spec 안내

6. **Ratchet 학습 (구현 중 문제가 있었다면)**
   사용자에게 묻는다:
   - "이번 작업에서 다시는 일어나면 안 되는 실수가 있었나요?"
   - 있다면 `AGENTS.md` 의 "절대 하지 말 것" 또는 "주의사항" 섹션에 한 줄 규칙으로 추가
   - 추가 전 사용자에게 정확한 문구를 보여주고 승인받는다
   - `.harness/failure-log` 에 기록된 실패가 있다면 그것들이 좋은 Ratchet 후보다 — 패턴을 묶어 한 줄 규칙으로 압축
