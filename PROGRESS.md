# Progress

The coordinator reads this file at the start of every step and updates it at the end.
Status: `todo` → `review` (generated, waiting for you) → `done` (you moved on with `/next`).

Current step: 0

| # | Step | Command | Output | Status |
|---|---|---|---|---|
| 0 | Intake | `/intake` | `specs/00-brief.md` | todo |
| 1 | Research | `/research` | `specs/01-research.md`, `reference/papers/` | todo |
| 2 | Architecture & scaffold | `/architect` | `specs/02-architecture.md`, `app/` skeleton | todo |
| 3 | Framework & API definition | `/define-api` | `specs/03-interfaces.md`, `specs/api/`, `reference/`, typed stubs in `app/` | todo |
| 4 | Build plan | `/plan` | `specs/04-plan.md` | todo |
| 5 | Build | `/build` | code and tests in `app/`, one milestone per run | todo |
| 6 | Documentation | `/document` | `app/README.md`, `docs/` | todo |

## Milestones

Filled in by step 4.

## Decision log

Every step appends the decisions it made and the assumptions it had to take.

| Step | Decision | Why |
|---|---|---|

## Review log

One row per review round.

| Step | Round | Verdict | Blockers / majors | Left open |
|---|---|---|---|---|
