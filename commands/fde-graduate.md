---
name: fde-graduate
description: 챔피언 모드의 transfer 메커니즘. Engineer 가 고객측 champion 에게 도메인·패턴·오픈 큐를 이양하는 양식을 생성합니다.
---

# Champion Graduation (Engineer → 고객측 챔피언 transfer)

> **모드**: 챔피언 (헌장 § 1.4). 본 커맨드는 *Long-term 모드 (6개월~1년+)* 의 transfer 단계 자산.
>
> **언제 사용**: Engineer 가 고객 환경에서 충분히 (보통 6개월+) 일한 후 고객측 인재(=차기 champion) 에게 인수할 때. Engineer 가 떠나도 자체 유지 가능하게.

## 인자

- `$ARGUMENTS` — 차기 champion 식별자 (예: "안수민", "trader-team-lead", "ops-cwn-02")

## 절차

1. **사용자 프로젝트 루트의 `graduation/` 폴더 보장**
   - 없으면 생성

2. **차기 champion 식별 확인**
   - $ARGUMENTS 가 비어있으면 사용자에게 묻기 — *"차기 champion 의 식별자는?"*
   - 식별자가 있으면 그것 사용

3. **인수 시작 일자 결정**
   - 현재 날짜를 기본값으로 사용 (ISO 8601)
   - 사용자가 다른 일자 지정 가능

4. **graduation note 생성**
   - 파일명: `graduation/{ISO 8601 날짜}-{champion-kebab}.md`
   - 플러그인의 `templates/graduation-template.md` 을 base 로 복사
   - 자동 채움:
     - 헤더 (champion 식별자, 시작 일자, Engineer 식별자 — 사용자가 입력)
     - `## 도메인 용어` 섹션: 현재 `AGENTS.md` 의 *"운영자가 가르친 것"* 섹션 내용을 가져와 채움 (없으면 placeholder + 사용자에게 안내)
     - `## 검증된 패턴` 섹션: 현재 `AGENTS.md` 의 *"검증된 패턴"* 섹션 내용을 가져옴 (없으면 placeholder)
     - `## 오픈 spec 큐`: `specs/` 의 `.harness/done.log` 에 없는 모든 spec ID + 한 줄 요약 (spec 의 What 섹션 첫 줄)
     - 나머지 (차후 contact, 인수 일정) 는 사용자가 직접 채울 빈 양식

5. **사용자에게 다음을 안내**:
   - 생성된 파일 경로 (절대 경로)
   - **반드시 사람이 직접 채워야 할 빈 슬롯 목록**:
     - 차후 contact (Engineer 의 비동기 channel)
     - 인수 일정의 3 페이즈 일자 (shadow / pair / solo)
   - **champion 에게 이 문서를 *함께 읽고* 토론할 것 권장** — 단순 전달 ❌ (헌장 § 1.2 의 "AI = Echo 의 대리" 위반 가능성)
   - 챔피언 모드의 다른 자산은 추후 spec 으로 확장 예정 — 현재는 graduation 만 (`docs/fde-criteria.md` § 1.4)

## 절대 하지 말 것

- AI 가 champion 의 *결정* 을 추정하지 않는다 — graduation note 는 *Engineer 의 압축본*, champion 의 응답은 *champion 본인의 입력*
- `AGENTS.md` 의 섹션을 *해석* 해서 새 표현으로 옮기지 않는다 — 원문 인용
- 차후 contact·인수 일정 같은 사람의 결정을 AI 가 채워넣지 않는다 (빈 슬롯 유지)
- 이미 존재하는 `graduation/{날짜}-{champion}.md` 가 있으면 덮어쓰지 않고 사용자에게 확인

## 트리거 키워드

다음 표현 시 본 커맨드 권장:
- "graduation", "champion 인수", "고객측 transfer", "내가 떠난 후"
- "Long-term", "6개월 후", "이제 인수해야"
- `/fde-graduate`
