---
name: fde-daily
description: 스플릿 모드의 매일 끝 한 줄 학습 기록. .harness/daily-ratchet.log 에 추가하고 AGENTS.md promote 후보 안내.
---

# Daily Ratchet (매일 끝 한 줄 학습)

> **모드**: 스플릿 (헌장 § 1.4). 본 커맨드는 *매일 sprint 끝* 의 의식.

## 인자

- `$ARGUMENTS` — 오늘 학습 한 줄 (선택). 비어있으면 사용자에게 묻기.

## 절차

1. **`.harness/daily-ratchet.log` 보장**
   - 없으면 생성

2. **현재 진행 중인 sprint spec 식별**
   - `specs/` 에서 `mode: split` frontmatter + deadline 미경과 spec 검색
   - 0개 — 사용자에게 알림 ("진행 중인 sprint 가 없습니다. `/fde-sprint` 먼저 실행하세요")
   - 1개 — 그것 사용
   - 2개+ — 사용자에게 선택지 제시

3. **학습 입력 수집**
   - $ARGUMENTS 가 있으면 사용
   - 비어있으면 `templates/daily-ratchet-template.md` 기반으로 사용자에게 묻기:
     - 오늘 학습 (한 줄)
     - 내일 의도 (한 줄)
     - 정체된 부분 (있으면, 선택)

4. **`.harness/daily-ratchet.log` 에 추가**
   - 포맷: `{ISO 8601 datetime} spec {ID} learning: {학습 내용}`
   - 추가 정보 (내일 의도·정체) 가 있으면 다음 줄에 들여쓰기로
   - 예시:
     ```
     2026-05-22T18:30:00Z spec 013 learning: 자동 알림 로직이 cron 으로는 동작하지만 macOS slept 환경에서 누락
       next: launchd 로 전환 시도
       stuck: launchd 의 권한 설정 명확하지 않음
     ```

5. **promote 후보 안내**
   - 학습 내용이 *양의 패턴* ("X 가 통한다") 이면 → AGENTS.md `## 검증된 패턴` 섹션 promote 안내
   - 학습 내용이 *음의 패턴* ("X 는 하지 말 것") 이면 → AGENTS.md `## 절대 하지 말 것` promote 안내
   - 도메인 학습 ("Operator 가 X 라고 부른다") → AGENTS.md `## 운영자가 가르친 것` promote 안내
   - 가능성 학습 ("Operator 가 X 가 가능한지 몰랐음") → AGENTS.md `## 운영자에게 보여준 가능성` promote 안내
   - **promote 자동 실행 ❌** — 사용자가 직접 결정. AI 는 *제안* 만.

6. **누적 안내**:
   - "지금까지 이 sprint 의 daily 기록: N 건. sprint 종료 시 `/fde-demo` 에서 retrospective 자료로 사용됩니다."

## 절대 하지 말 것

- AI 가 학습 내용을 *대신 작성* 하지 않는다 — Engineer 본인의 발화
- promote 를 *자동* 으로 하지 않는다 — 사용자 검토 필수 (헌장 § 1.2)
- 이미 같은 일자에 입력된 daily 가 있으면 *추가 추가* (덮어쓰기 ❌) — 한 일에 여러 학습 가능

## 트리거 키워드

다음 표현 시 본 커맨드 권장:
- "오늘 끝났다", "데일리 정리", "오늘 학습"
- "내일 의도", "스프린트 매일 끝"
- `/fde-daily`
