---
mode: split
created: {YYYY-MM-DD}
deadline: {YYYY-MM-DD}
throwaway: true
---

# Spec ID: {ID} — {제목} (Sprint)

> **스플릿 모드 spec** (헌장 § 1.4). 며칠~2주 sprint 의 *움직이는 데모* 형식. *throwaway 허용*, 가설 검증 후 폐기·재시작 OK.

## What (무엇을) — Movable Demo 형식

<!--
한 줄 — *며칠 안에 demo 가능한 형식*.
예: "분석가 책상에서 매일 08:00 자동으로 어제 데이터 요약 알림 보여주기"
production-ready ❌, demo-able ✅
-->


## Why (왜) — Operator 의 며칠 안 검증할 가설

<!--
Operator 의 직접 발화 인용 우선.
예: "분석가 김XX: 매일 아침 보고서 요약을 손으로 만드는데 30분 걸린다. 자동화되면 분석에 집중 가능."

며칠 안에 *검증* 할 수 있는 가설로 좁힘.
-->


## Expected outcome (정량, Operator 단위)

<!--
며칠 안의 demo 에서 *측정 가능* 한 결과.
예: "demo 에서 분석가가 30초 안에 어제 요약 확인 가능" (정성)
예: "demo 후 분석가가 '이거 매일 쓸 수 있겠다' 라고 *직접* 발화" (질적)

Engineer 단위 (LOC·테스트 커버리지) ❌
-->


## Done means (Demo-able 체크리스트만)

<!--
*demo 에서 실제로 보여줄 수 있는* 항목만.
production 형식 ❌
예:
- [ ] 분석가 책상의 PC 에서 08:00 자동 실행
- [ ] 어제 데이터 요약이 화면에 표시
- [ ] 분석가가 클릭 1번으로 상세 확인
-->

- [ ]
- [ ]
- [ ]

## Out of scope (이번 sprint 가 안 하는 것)

<!--
스프린트의 *나머지* — 다음 sprint 후보로 분리.
예:
- 다른 분석가에게 확장 (이번은 김XX 한 명만)
- 알림 채널 확장 (이번은 PC 화면만)
- 데이터 검증 로직 (이번은 raw 데이터 그대로)
-->

-
-

## Daily ratchet 슬롯 (매일 한 줄 누적)

<!--
매일 끝 `/fde-daily` 가 자동 채울 자리. 또는 수동 기록.
sprint 진행 중 누적, sprint 종료 시 demo 자료.
-->

- {YYYY-MM-DD}:
- {YYYY-MM-DD}:

## Demo 일자 + 결과

<!--
sprint 종료 시점 `/fde-demo` 가 자동 채움.
-->

- **Demo 일자**: {deadline 또는 그 이전}
- **결과**: <!-- 가설 검증됨 / 부분 / 부정 -->
- **다음 사이클**: <!-- 딥다이브 전환 / 같은 sprint 1회 더 / reject -->

## Open questions (며칠 안 답 못 받은 것)

<!--
sprint 중 Operator 에게 묻지 못한 질문. 다음 sprint 또는 다음 모드의 입력.
-->

-

## Risks (며칠 sprint 의 위험)

<!--
스프린트가 *며칠 안에* 무너질 위험.
예:
- Operator 가 demo 일자에 부재
- 의존 시스템 (API 등) 의 변경 가능성
- "demo-able" 의 *진짜 demo-able* 인지 의심
-->

-

## Rollback plan

<!--
sprint 가 실패할 경우 어떻게 되돌리는가.
스플릿 모드는 *throwaway 허용* 이므로 보통:
"이 sprint 의 코드는 삭제. spec 은 failure-log 에 reject 또는 split-spec 으로 기록. 다음 sprint 우선순위 재결정."
-->

-
