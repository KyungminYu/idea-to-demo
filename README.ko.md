# idea-to-demo

> 요구사항을 넣으면 동작하는 데모가 나온다. 한 단계씩, 검토하면서.

AI 코딩 에이전트로 해커톤·포트폴리오 프로젝트를 만드는 템플릿입니다.
사람은 `REQUIREMENTS.md` **한 파일만** 채웁니다. 그다음 에이전트가 구조 설계, 프레임워크·API 정의, 마일스톤 계획, 코드 생성, 문서 작성을 차례로 진행하고, 단계마다 멈춰서 검토를 받습니다.

English: [README.md](README.md)

## 단계

| # | 단계 | 명령어 | 결과물 |
|---|---|---|---|
| 0 | 요구사항 정리 | `/intake` | `specs/00-brief.md`: 범위, 완료 기준, 가정 |
| 1 | 구조 설계와 뼈대 | `/architect` | `specs/01-architecture.md`, 실행되는 빈 `app/` |
| 2 | 프레임워크·API 정의 | `/define-api` | `reference/`의 공식 문서, 데이터 모델, `specs/api/openapi.yaml`, 타입이 정해진 스텁 |
| 3 | 구현 계획 | `/plan` | `specs/03-plan.md`: 시간 안에 끝나는, 각각 데모 가능한 마일스톤 |
| 4 | 구현 | `/build` | 실행할 때마다 마일스톤 하나씩, 테스트 포함 |
| 5 | 문서화 | `/document` | README, 아키텍처, 피치, 데모 대본, 제작 기록 |

`/next`는 현재 단계를 승인하고 다음 단계를 실행합니다. `/status`는 현재 위치를 보여줍니다.
진행 상태와 에이전트가 내린 결정은 모두 `PROGRESS.md`에 기록됩니다.

## 에이전트 팀

각 단계는 서브에이전트 팀이 진행하고, 결과가 사람에게 오기 전에 리뷰를 거칩니다.

| 역할 | 쓰는 파일 | 단계 |
|---|---|---|
| **조율자 (coordinator)**: 메인 세션 | `PROGRESS.md` | 전체: 일을 나눠 맡기고, 리뷰를 돌리고, 사람에게 보고 |
| **디자이너 (designer)** | `specs/`, `reference/`, `docs/` | 0~3단계, 5단계 문서 |
| **개발자 (developer)** | `app/` | 1단계 뼈대, 2단계 스텁, 4단계 구현, 5단계 `app/README.md` |
| **리뷰어 (reviewer)** | 없음 (읽기 전용) | 모든 단계 끝에 검토, 수정은 최대 2회 |

**Claude Code와 Codex 모두에서** 동작합니다. 역할은 `roles/*.md`에 한 번만 쓰고, `scripts/sync-agents.sh`가 여기서 `.claude/agents/*.md`와 `.codex/agents/*.toml`을 만듭니다. 서브에이전트가 없는 도구는 한 세션 안에서 역할 파일을 바꿔 읽으며 같은 흐름으로 진행합니다.
시간이나 토큰을 아끼려면 `REQUIREMENTS.md`에서 `Review loop: off`로 설정하세요.

## 시작하기

1. 이 템플릿으로 **새 레포**를 만듭니다. 템플릿 자체에는 절대 채우지 않습니다. 여기서는 파이프라인이 실행을 거부합니다.

   ```bash
   gh repo create my-project --template KyungminYu/idea-to-demo --private --clone
   ```

2. `REQUIREMENTS.md`를 채웁니다. 해커톤 공지, PDF, 샘플 데이터 같은 자료는 `inputs/`에 넣습니다.
3. Claude Code로 폴더를 열고 실행합니다.

   ```
   /intake
   ```

4. 결과물을 읽고, 마음에 안 들면 spec 파일을 직접 고치거나 피드백을 붙여서 넘어갑니다.

   ```
   /next Postgres 말고 SQLite로
   ```

5. 5단계가 끝날 때까지 `/next`를 반복합니다. 단계마다 커밋하는 걸 권장합니다.

다른 에이전트(Codex, Cursor 등)는 `AGENTS.md`를 읽습니다. "run step 0", 그다음 "next"라고 말하면 됩니다.

## 여러 프로젝트에서 쓰는 법

이 레포는 틀일 뿐입니다. 프로젝트마다 이 템플릿으로 별도 레포를 만들기 때문에, 프로젝트끼리도, 템플릿과도 섞이지 않습니다.

| 템플릿이 관리 (프로젝트에서 수정 금지) | 프로젝트가 관리 |
|---|---|
| `workflow/`, `roles/`, `AGENTS.md`, `CLAUDE.md`, `.claude/`, `.codex/`, `scripts/` | `REQUIREMENTS.md`, `inputs/`, `PROGRESS.md`, `specs/`, `reference/`, `app/`, `docs/`, `README*.md` |

- **workflow 개선**: 프로젝트가 아니라 이 템플릿 레포에서 고칩니다. `roles/`를 고쳤다면 `scripts/sync-agents.sh`를 실행하고 생성된 파일도 함께 커밋합니다.
- **진행 중인 프로젝트에 최신 workflow 반영**: 프로젝트 폴더에서 실행합니다. 템플릿이 관리하는 파일만 덮어씁니다. URL은 처음 한 번만 필요합니다.

  ```bash
  scripts/update-workflow.sh https://github.com/KyungminYu/idea-to-demo.git
  ```

- **결과물 소개**: 완성된 프로젝트는 `examples/README.md`에 링크만 겁니다. 코드를 복사하지 않습니다.
- **안전장치**: 모든 단계는 먼저 `scripts/check-not-template.sh`를 실행합니다. 레포 이름(원격이 없으면 폴더 이름)이 `idea-to-demo`면 멈춥니다. 템플릿을 그냥 `git clone`한 경우도 막히니, 템플릿 버튼이나 `gh repo create --template`을 쓰세요.

## 왜 단계별로 하나

- **실수를 일찍 잡습니다.** 스택을 잘못 고르면 1단계에서 한 줄 고치면 되지, 4단계에서 다시 짤 필요가 없습니다.
- **API를 지어내지 않습니다.** 코드는 모델의 기억이 아니라 2단계에서 저장한 공식 문서를 보고 작성합니다.
- **언제든 데모할 수 있습니다.** 마지막으로 끝난 마일스톤이 곧 동작하는 데모가 되도록 순서를 잡습니다.
- **과정이 남습니다.** `PROGRESS.md`와 `docs/build-log.md`에 에이전트를 어떻게 이끌었는지 남아서, 생성된 코드가 아니라 포트폴리오가 됩니다.
