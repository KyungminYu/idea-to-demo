# idea-to-demo

> Requirements in, working demo out. One reviewed step at a time.

A template for building hackathon and portfolio projects with an AI coding agent.
You fill in **one file**, `REQUIREMENTS.md`. The agent then designs the structure, pins down framework and API definitions, plans the milestones, writes the code, and writes the docs. It stops after every step so you can review.

한국어: [README.ko.md](README.ko.md)

## Pipeline

| # | Step | Command | You get |
|---|---|---|---|
| 0 | Intake | `/intake` | `specs/00-brief.md`: scope, acceptance checks, assumptions |
| 1 | Architecture & scaffold | `/architect` | `specs/01-architecture.md` and a runnable empty `app/` |
| 2 | Framework & API definition | `/define-api` | official docs in `reference/`, data model, `specs/api/openapi.yaml`, typed stubs |
| 3 | Build plan | `/plan` | `specs/03-plan.md`: demoable milestones within your time budget |
| 4 | Build | `/build` | one milestone per run, with tests |
| 5 | Documentation | `/document` | README, architecture, pitch, demo script, build log |

`/next` approves the current step and runs the next one. `/status` shows where you are.
Progress and every decision the agent makes are tracked in `PROGRESS.md`.

## Agent team

Each step is run by a small team of subagents, with a review loop before you see the result.

| Role | Writes | Steps |
|---|---|---|
| **coordinator** (your main session) | `PROGRESS.md` | all: hands out tasks, runs the review loop, reports to you |
| **designer** | `specs/`, `reference/`, `docs/` | 0–3, docs in 5 |
| **developer** | `app/` | scaffold in 1, stubs in 2, build in 4, `app/README.md` in 5 |
| **reviewer** | nothing (read-only) | after every step; up to 2 fix rounds |

Works in both **Claude Code** and **Codex**. The roles are written once in `roles/*.md`, and `scripts/sync-agents.sh` generates `.claude/agents/*.md` and `.codex/agents/*.toml` from them. Tools without subagents follow the same flow in one session, switching roles by reading the role files.
To save time or tokens, set `Review loop: off` in `REQUIREMENTS.md`.

## Quick start

1. Create a **new repo** from this template. Never fill in the template itself; the pipeline refuses to run here.

   ```bash
   gh repo create my-project --template KyungminYu/idea-to-demo --private --clone
   ```

2. Fill in `REQUIREMENTS.md`. Put raw material (hackathon brief, PDFs, sample data) in `inputs/`.
3. Open the folder with Claude Code and run:

   ```
   /intake
   ```

4. Read what it produced. Edit the spec files directly if you disagree, or pass feedback along:

   ```
   /next use SQLite instead of Postgres
   ```

5. Repeat `/next` until step 5 is done. Commit after each step.

Using another agent (Codex, Cursor, …)? It reads `AGENTS.md`. Say "run step 0", then "next".

## Using it across many projects

This repo is only the mold. Every project is its own repo created from it, so projects never touch the template or each other.

Files are split by owner:

| Template-owned (don't edit in a project) | Project-owned |
|---|---|
| `workflow/`, `roles/`, `AGENTS.md`, `CLAUDE.md`, `.claude/`, `.codex/`, `scripts/` | `REQUIREMENTS.md`, `inputs/`, `PROGRESS.md`, `specs/`, `reference/`, `app/`, `docs/`, `README*.md` |

- **Improving the workflow:** make the change in this template repo, not in a project. After editing `roles/`, run `scripts/sync-agents.sh` and commit the generated files too.
- **Getting the latest workflow into an existing project:** run this from the project. It only overwrites template-owned files. The URL is needed the first time only.

  ```bash
  scripts/update-workflow.sh https://github.com/KyungminYu/idea-to-demo.git
  ```

- **Showcasing results:** link finished projects in `examples/README.md`. Don't copy their code here.
- **Safety:** every step first runs `scripts/check-not-template.sh`, which stops the pipeline when the repo (or, without a remote, the folder) is named `idea-to-demo`. A plain `git clone` of the template is blocked too; use the template button or `gh repo create --template`.

## Layout

```
REQUIREMENTS.md     you write this
inputs/             your raw material
PROGRESS.md         step status, milestones, decision log
AGENTS.md           rules every agent follows (CLAUDE.md imports it)
workflow/           exact instructions for each step
roles/              designer, developer, reviewer (source of truth)
.claude/agents/     generated Claude Code subagents
.codex/agents/      generated Codex subagents
.claude/commands/   slash commands that run the steps
scripts/            template guard, workflow updater, agent sync
specs/              design outputs of steps 0–3
reference/          official framework and API docs, fetched in step 2
app/                generated code and tests
docs/               generated human-facing docs
examples/           projects built with this template
```

## Why step by step

- **Mistakes are caught early.** A wrong stack choice costs one edit in step 1, not a rewrite in step 4.
- **No invented APIs.** Code is written against docs saved in step 2, not the model's memory.
- **Always demoable.** Milestones are ordered so the last finished one is a working demo.
- **Reviewable story.** `PROGRESS.md` and `docs/build-log.md` show how you steered the agent, which is what makes this a portfolio piece rather than just generated code.

Inspired by [kvrancic/spine](https://github.com/kvrancic/spine), which was built from idea and tech instruction files.
