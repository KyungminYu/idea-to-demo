# idea-to-demo

> Problem in, research-backed demo out. One reviewed step at a time.

A template for building hackathon and portfolio projects with a team of AI coding agents.
You describe the problem in **one file**, `REQUIREMENTS.md`. The agents then research the most recent strong papers for each part of the problem, design the structure on that evidence, pin down framework and API definitions, plan the milestones, write the code, and write the docs. Every method in the code traces back to a verified paper. They stop after every step so you can review.

Modeled on [kvrancic/spine](https://github.com/kvrancic/spine), which was built from a hackathon task, an idea, a paper-driven technical brief and framework docs. This template turns that process into a repeatable pipeline.

한국어: [README.ko.md](README.ko.md)

## Pipeline

| # | Step | Command | You get |
|---|---|---|---|
| 0 | Intake | `/intake` | `specs/00-brief.md`: scope, acceptance checks, assumptions |
| 1 | Research | `/research` | `specs/01-research.md`: per goal, recent papers compared against a baseline, a decision, and concrete signals to build; verified notes in `reference/papers/` |
| 2 | Architecture & scaffold | `/architect` | `specs/02-architecture.md` citing the evidence, and a runnable empty `app/` |
| 3 | Framework & API definition | `/define-api` | official docs in `reference/`, data model, `specs/api/openapi.yaml`, typed stubs |
| 4 | Build plan | `/plan` | `specs/04-plan.md`: demoable milestones, baseline before method |
| 5 | Build | `/build` | one milestone per run, with tests; method code cites its paper |
| 6 | Documentation | `/document` | README, architecture, pitch, demo and technical video scripts, evidence trace, build log |

`/next` approves the current step and runs the next one. `/status` shows where you are.
Progress and every decision the agent makes are tracked in `PROGRESS.md`.

## Agent team

Each step is run by a small team of subagents, with a review loop before you see the result.

| Role | Writes | Steps |
|---|---|---|
| **coordinator** (your main session) | `PROGRESS.md` | all: hands out tasks, runs the review loop, reports to you |
| **researcher** | `specs/01-research.md`, `reference/papers/` | 1, and any research gap found later |
| **designer** | other `specs/`, `reference/`, `docs/` | 0, 2–4, docs in 6 |
| **developer** | `app/` | scaffold in 2, stubs in 3, build in 5, `app/README.md` in 6 |
| **reviewer** | nothing (read-only) | after every step, opening **every** cited paper to verify it; up to 2 fix rounds |

Works in both **Claude Code** and **Codex**. The roles are written once in `roles/*.md`, and `scripts/sync-agents.sh` generates `.claude/agents/*.md` and `.codex/agents/*.toml` from them. Tools without subagents follow the same flow in one session, switching roles by reading the role files.
To save time or tokens, set `Review loop: off` in `REQUIREMENTS.md`. `Research:` sets how much needs papers (`methods`, `all` or `off`) and `Paper recency` how recent they must be.

## How the research works

- **Search, don't recall.** The researcher queries arXiv, Semantic Scholar and OpenAlex and logs every query.
- **Recent and best, but buildable.** Papers are ranked by recency, venue, citations and benchmark results, and whether code exists. The winner is the strongest method that fits your time budget, always compared against a simple baseline.
- **No invented papers.** A paper counts only after the researcher has opened it, and the reviewer opens every cited paper again to confirm title, authors, year and that it supports what's claimed.
- **Traceable to code.** Specs cite evidence IDs (`E3 §4.2`), code comments name them, and `docs/evidence-trace.md` follows each decision from paper to function to test.

## Quick start

1. Create a **new repo** from this template. Never fill in the template itself; the pipeline refuses to run here.

   ```bash
   gh repo create my-project --template KyungminYu/idea-to-demo --private --clone
   ```

2. Fill in `REQUIREMENTS.md`. Put raw material (hackathon brief, PDFs, sample data, papers you already know) in `inputs/`.
3. Open the folder with Claude Code and run:

   ```
   /intake
   ```

4. Read what it produced. Edit the spec files directly if you disagree, or pass feedback along:

   ```
   /next use SQLite instead of Postgres
   ```

5. Repeat `/next` until step 6 is done. Commit after each step.

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
roles/              researcher, designer, developer, reviewer (source of truth)
.claude/agents/     generated Claude Code subagents
.codex/agents/      generated Codex subagents
.claude/commands/   slash commands that run the steps
scripts/            template guard, workflow updater, agent sync
specs/              research and design outputs of steps 0–4
reference/papers/   verified paper notes, written in step 1
reference/          official framework and API docs, fetched in step 3
app/                generated code and tests
docs/               generated human-facing docs
examples/           projects built with this template
```

## Why step by step

- **Mistakes are caught early.** A weak method or wrong stack costs one edit in steps 1–2, not a rewrite in step 5.
- **No invented methods or APIs.** Methods come from verified papers in step 1 and code is written against docs saved in step 3, not the model's memory.
- **Always demoable.** Milestones are ordered so the last finished one is a working demo.
- **Reviewable story.** `PROGRESS.md` and `docs/build-log.md` show how you steered the agent, which is what makes this a portfolio piece rather than just generated code.

