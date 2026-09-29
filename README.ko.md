# idea-to-demo

> 문제를 넣으면, 논문에 근거한 데모가 나온다. 한 단계씩, 검토하면서.

AI 코딩 에이전트 팀으로 해커톤·포트폴리오 프로젝트를 만드는 템플릿입니다.
사람은 `REQUIREMENTS.md` **한 파일에** 문제를 적습니다. 그다음 에이전트들이 문제의 각 부분에 대해 최신의 강력한 논문을 찾고, 그 근거 위에서 구조를 설계하고, 프레임워크·API를 정의하고, 마일스톤을 계획하고, 코드와 문서를 작성합니다. 코드의 모든 방법론은 검증된 논문까지 거슬러 올라갈 수 있습니다. 단계마다 멈춰서 검토를 받습니다.

[kvrancic/spine](https://github.com/kvrancic/spine)을 모델로 삼았습니다. Spine은 해커톤 과제, 아이디어, 논문 기반 기술 지침, 프레임워크 문서로부터 만들어졌습니다. 이 템플릿은 그 과정을 반복 가능한 파이프라인으로 만든 것입니다.

English: [README.md](README.md)

## 단계

| # | 단계 | 명령어 | 결과물 |
|---|---|---|---|
| 0 | 요구사항 정리 | `/intake` | `specs/00-brief.md`: 범위, 완료 기준, 가정 |
| 1 | 논문 조사 | `/research` | `specs/01-research.md`: 하위 문제별로 최신 논문과 기준선 비교, 선택한 방법, 구현할 구체적 지표. 검증된 논문 노트는 `reference/papers/` |
| 2 | 구조 설계와 뼈대 | `/architect` | 근거를 인용한 `specs/02-architecture.md`, 실행되는 빈 `app/` |
| 3 | 프레임워크·API 정의 | `/define-api` | `reference/`의 공식 문서, 데이터 모델, `specs/api/openapi.yaml`, 타입이 정해진 스텁 |
| 4 | 구현 계획 | `/plan` | `specs/04-plan.md`: 데모 가능한 마일스톤, 기준선을 먼저 구현 |
| 5 | 구현 | `/build` | 실행할 때마다 마일스톤 하나씩, 테스트 포함. 방법론 코드에 논문 인용 |
| 6 | 문서화 | `/document` | README, 아키텍처, 피치, 데모·기술 영상 대본, 근거 추적표, 제작 기록 |

`/next`는 현재 단계를 승인하고 다음 단계를 실행합니다. `/status`는 현재 위치를 보여줍니다.
진행 상태와 에이전트가 내린 결정은 모두 `PROGRESS.md`에 기록됩니다.

## 에이전트 팀

각 단계는 서브에이전트 팀이 진행하고, 결과가 사람에게 오기 전에 리뷰를 거칩니다.

| 역할 | 쓰는 파일 | 단계 |
|---|---|---|
| **조율자 (coordinator)**: 메인 세션 | `PROGRESS.md` | 전체: 일을 나눠 맡기고, 리뷰를 돌리고, 사람에게 보고 |
| **연구자 (researcher)** | `specs/01-research.md`, `reference/papers/` | 1단계, 이후 단계에서 근거가 부족할 때 |
| **디자이너 (designer)** | 나머지 `specs/`, `reference/`, `docs/` | 0단계, 2~4단계, 6단계 문서 |
| **개발자 (developer)** | `app/` | 2단계 뼈대, 3단계 스텁, 5단계 구현, 6단계 `app/README.md` |
| **리뷰어 (reviewer)** | 없음 (읽기 전용) | 모든 단계 끝에 검토. 인용된 논문은 **전부** 직접 열어 확인. 수정은 최대 2회 |

**Claude Code와 Codex 모두에서** 동작합니다. 역할은 `roles/*.md`에 한 번만 쓰고, `scripts/sync-agents.sh`가 여기서 `.claude/agents/*.md`와 `.codex/agents/*.toml`을 만듭니다. 서브에이전트가 없는 도구는 한 세션 안에서 역할 파일을 바꿔 읽으며 같은 흐름으로 진행합니다.
시간이나 토큰을 아끼려면 `REQUIREMENTS.md`에서 `Review loop: off`로 설정하세요. `Research:`로 논문 근거가 필요한 범위(`methods`, `all`, `off`)를, `Paper recency`로 논문의 최신성 기준을 정합니다.

## 논문 조사 방식

- **기억이 아니라 검색으로 찾습니다.** 연구자가 arXiv, Semantic Scholar, OpenAlex를 검색하고 모든 검색어를 기록합니다.
- **최신이면서 최선이되, 구현 가능해야 합니다.** 최근성, 학회·저널, 인용 수, 벤치마크 결과, 공개 코드 여부로 순위를 매깁니다. 시간 예산 안에서 구현할 수 있는 가장 강력한 방법을 고르고, 항상 단순한 기준선과 비교합니다.
- **가짜 논문을 막습니다.** 연구자가 직접 열어 본 논문만 인정하고, 리뷰어가 인용된 논문을 전부 다시 열어 제목, 저자, 연도, 그리고 주장이 논문으로 뒷받침되는지 확인합니다.
- **코드까지 추적됩니다.** spec은 근거 ID(`E3 §4.2`)를 인용하고, 코드 주석에도 적히며, `docs/evidence-trace.md`가 논문 → 설계 → 함수 → 테스트를 한 표로 이어 줍니다.

## 시작하기

1. 이 템플릿으로 **새 레포**를 만듭니다. 템플릿 자체에는 절대 채우지 않습니다. 여기서는 파이프라인이 실행을 거부합니다.

   ```bash
   gh repo create my-project --template KyungminYu/idea-to-demo --private --clone
   ```

2. `REQUIREMENTS.md`를 채웁니다. 해커톤 공지, PDF, 샘플 데이터, 이미 알고 있는 논문 같은 자료는 `inputs/`에 넣습니다.
3. Claude Code로 폴더를 열고 실행합니다.

   ```
   /intake
   ```

4. 결과물을 읽고, 마음에 안 들면 spec 파일을 직접 고치거나 피드백을 붙여서 넘어갑니다.

   ```
   /next Postgres 말고 SQLite로
   ```

5. 6단계가 끝날 때까지 `/next`를 반복합니다. 단계마다 커밋하는 걸 권장합니다.

### Codex에서

흐름은 같고, 슬래시 명령어 대신 스킬로 실행합니다.

1. 프로젝트를 열고 Codex가 물어보면 **신뢰(trust)** 를 선택합니다. 신뢰한 프로젝트에서만 `.codex/config.toml`과 `.codex/agents/`의 커스텀 에이전트를 읽습니다.
2. `$intake`를 실행하고, 이후 단계는 `$next`로 넘어갑니다. `/skills`로 전체 목록을 볼 수 있습니다.

`.codex/config.toml`이 파이프라인에 필요한 설정을 켜 두므로 따로 손댈 것이 없습니다. 논문을 열어 검증하기 위한 실시간 웹 검색, 논문 API와 패키지 설치를 위한 샌드박스 네트워크 접근, 최대 4개까지 병렬로 도는 서브에이전트가 켜집니다. 명령 실행 승인은 사용자의 Codex 설정을 그대로 따릅니다.
Codex 앱에서 논문 사이트에 접속이 안 되면 논문 조사 단계는 Codex CLI로 실행하세요. 앱이 설정의 `network_access`를 반영하지 않는 문제가 보고된 적이 있습니다([openai/codex#13373](https://github.com/openai/codex/issues/13373)). 이 경우에도 리뷰어는 검증되지 않은 논문을 통과시키지 않고 단계를 멈춥니다.

### 그 밖의 도구

서브에이전트나 스킬이 없는 도구는 `AGENTS.md`를 읽습니다. "run step 0", 그다음 "next"라고 말하면 한 세션이 역할 파일을 바꿔 가며 진행합니다.

## 여러 프로젝트에서 쓰는 법

이 레포는 틀일 뿐입니다. 프로젝트마다 이 템플릿으로 별도 레포를 만들기 때문에, 프로젝트끼리도, 템플릿과도 섞이지 않습니다.

| 템플릿이 관리 (프로젝트에서 수정 금지) | 프로젝트가 관리 |
|---|---|
| `workflow/`, `roles/`, `AGENTS.md`, `CLAUDE.md`, `.claude/`, `.codex/`, `.agents/`, `scripts/` | `REQUIREMENTS.md`, `inputs/`, `PROGRESS.md`, `specs/`, `reference/`, `app/`, `docs/`, `README*.md` |

- **workflow 개선**: 프로젝트가 아니라 이 템플릿 레포에서 고칩니다. `roles/`나 `.claude/commands/`를 고쳤다면 `scripts/sync-agents.sh`를 실행하고 생성된 파일도 함께 커밋합니다.
- **진행 중인 프로젝트에 최신 workflow 반영**: 프로젝트 폴더에서 실행합니다. 템플릿이 관리하는 파일만 덮어씁니다. URL은 처음 한 번만 필요합니다.

  ```bash
  scripts/update-workflow.sh https://github.com/KyungminYu/idea-to-demo.git
  ```

- **결과물 소개**: 완성된 프로젝트는 `examples/README.md`에 링크만 겁니다. 코드를 복사하지 않습니다.
- **안전장치**: 모든 단계는 먼저 `scripts/check-not-template.sh`를 실행합니다. 레포 이름(원격이 없으면 폴더 이름)이 `idea-to-demo`면 멈춥니다. 템플릿을 그냥 `git clone`한 경우도 막히니, 템플릿 버튼이나 `gh repo create --template`을 쓰세요.

## 왜 단계별로 하나

- **실수를 일찍 잡습니다.** 약한 방법론이나 잘못된 스택은 1~2단계에서 고치면 되지, 5단계에서 다시 짤 필요가 없습니다.
- **방법론도 API도 지어내지 않습니다.** 방법론은 1단계에서 검증한 논문에서, 코드는 3단계에서 저장한 공식 문서에서 가져옵니다.
- **언제든 데모할 수 있습니다.** 마지막으로 끝난 마일스톤이 곧 동작하는 데모가 되도록 순서를 잡습니다.
- **과정이 남습니다.** `PROGRESS.md`와 `docs/build-log.md`에 에이전트를 어떻게 이끌었는지 남아서, 생성된 코드가 아니라 포트폴리오가 됩니다.
