# 고객 engagement 시작

입력: 고객 slug (예: `acme`). 비어 있으면 사용자에게 묻는다.

단계 정의와 게이트는 `references/methodology.md` §3.1을 따른다. 템플릿 경로는 이 스킬 폴더(SKILL.md가 있는 폴더) 기준이다.

현재 작업 디렉터리에서 다음을 순서대로 한다.

1. `engagements/{고객}/`이 이미 있으면 멈추고 사용자에게 알린다. 덮어쓰지 않는다.
2. `engagements/{고객}/`와 `engagements/{고객}/weeks/`를 만든다.
3. `assets/templates/brief.md`를 `engagements/{고객}/brief.md`로 복사하고 `{client}`를 고객 slug로 바꾼다.
4. `engagements/failure-modes.md`가 없을 때만 `assets/templates/failure-modes.md`로 만든다. 있으면 건드리지 않는다.
5. 사용자에게 아래를 안내한다.
   - 만든 파일의 경로
   - `brief.md`에서 먼저 채울 항목: 경영진 스폰서, 챔피언 후보, Day 1과 Day 30
   - 다음 단계: `/fde-qualify`
