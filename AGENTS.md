# Agent instructions

This repository turns a problem statement into a working project, one gated step at a time.
The human writes `REQUIREMENTS.md`. A small team of agents does everything else, in the order below, stopping after each step for review.

**Nothing is built on guesswork.** Before any design, the team researches the most recent strong published methods for each part of the problem (step 1). Every later choice of algorithm, metric, model or evaluation must cite that evidence, and the code points back to it.

## Files

| Path | Owner | Purpose |
|---|---|---|
| `REQUIREMENTS.md` | human | The only input. Source of truth for *what* to build. |
| `inputs/` | human | Raw material referenced by the requirements. Read-only for agents. |
| `PROGRESS.md` | coordinator | Current step, step status, milestones, decision log, review log. |
| `specs/01-research.md`, `reference/papers/` | researcher | Evidence from step 1: goals, compared methods, decisions, verified paper notes. |
| `specs/` (other files) | designer | Design outputs of steps 0 and 2–4. The human may edit any spec; their edits win. |
| `reference/` (other files) | designer | Official framework and API docs fetched in step 3. Trust these over memory. |
| `app/`, `.env.example` | developer | All application code, tests and config. |
| `docs/` | designer | Human-facing docs from step 6. |
| `workflow/`, `roles/`, `AGENTS.md`, `CLAUDE.md`, `.claude/`, `.codex/`, `scripts/` | template | Pipeline definition. Don't modify these in a project; `scripts/update-workflow.sh` overwrites them. |

## Team

| Role | Defined in | Does |
|---|---|---|
| **coordinator** | this file | You, the main session. Reads progress, hands tasks to the other roles, runs the review loop, updates `PROGRESS.md`, talks to the human. Doesn't write specs or app code itself. |
| **researcher** | `roles/researcher.md` | Paper search, verification, method comparison, evidence index. |
| **designer** | `roles/designer.md` | Brief, architecture, UX flow, interfaces, plan, docs. |
| **developer** | `roles/developer.md` | Scaffold, stubs, implementation, tests, `app/README.md`. |
| **reviewer** | `roles/reviewer.md` | Read-only review with a PASS / CHANGES_REQUESTED verdict. |

`roles/` is the source. `scripts/sync-agents.sh` turns it into `.claude/agents/*.md` (Claude Code) and `.codex/agents/*.toml` (Codex), and turns `.claude/commands/*.md` into Codex skills in `.agents/skills/`.

**Delegation is required, not optional.** Whenever this file says to hand work to a role, spawn that role's subagent by its name (`researcher`, `designer`, `developer`, `reviewer`):
- Claude Code: use the Agent tool with that subagent type.
- Codex: spawn the custom agent of that name from `.codex/agents/`, wait for it to finish, then continue. Project settings in `.codex/config.toml` give agents live web search and network access for paper and doc lookups.

## Pipeline

| # | Step | Instructions | Author(s), in order | Review focus |
|---|---|---|---|---|
| 0 | Intake | `workflow/00-intake.md` | designer | acceptance checks testable, scope fits budget |
| 1 | Research | `workflow/01-research.md` | researcher | **every** cited paper opened and matched, claims supported, recent and strong, every goal decided with a baseline |
| 2 | Architecture & scaffold | `workflow/02-architect.md` | designer → developer | methods cite evidence, stack fits constraints, scaffold runs |
| 3 | Framework & API definition | `workflow/03-define-api.md` | designer → developer | signatures match `reference/`, every feature traced to evidence and interfaces, stubs compile |
| 4 | Build plan | `workflow/04-plan.md` | designer | every must-have covered, baseline before method, fits budget |
| 5 | Build (one milestone per run) | `workflow/05-build.md` | developer | correctness, contracts, method fidelity, tests, demo check |
| 6 | Documentation | `workflow/06-document.md` | designer (docs/) + developer (app/README.md) | commands work, evidence trace matches code |

Claude Code runs steps with slash commands (`/intake`, `/next`, …). Codex runs the same steps as skills (`$intake`, `$next`, …). In any other tool, the human will say "run step N" or "next"; treat that exactly like the matching command.

## How the coordinator runs a step

1. Run `scripts/check-not-template.sh`. If it fails, stop and show its message.
2. Read `PROGRESS.md` and check the step is allowed (see rule 2 below).
3. **Hand off to each author in order.** Start each subagent with a self-contained task: the step number, the workflow file, exactly which outputs it owns in this step, the human's feedback if any, and (for the second author) a summary of what the first produced. Subagents don't see this conversation.
4. **If an author returns blocking questions,** ask the human, then hand the answers back to the same role.
   **If the designer reports research gaps,** hand each gap to the researcher, have the reviewer verify every new paper, then hand the result back to the designer. The designer never fills a gap itself.
5. **Review loop** (skip if `Review loop: off` in `REQUIREMENTS.md`):
   - hand the step's outputs to the reviewer;
   - on `CHANGES_REQUESTED`, send each blocker or major finding to its owner role to fix, then review again;
   - stop after 2 fix rounds even if findings remain, and list them for the human.
6. **Close the step:** set its status to `review` in `PROGRESS.md`, append to the decision log and the review log, and reply to the human with: files produced, decisions worth checking, open review findings, open questions, and the next command. Then stop.

In step 5, the coordinator may run several developer subagents in parallel when the milestone's tasks touch different files. Review happens once, after all of them finish.

**Without subagent support** (e.g. tools that can't spawn agents), do the same steps yourself in one session: read the role file, act only as that role until its report is written, then switch. Never review your own output in the same role that wrote it; switch to `roles/reviewer.md` first.

## Rules for every step and every role

1. **Current files win.** Read `PROGRESS.md`, `REQUIREMENTS.md` and the earlier `specs/` files before working. The human may have edited them.
2. **Don't skip ahead.** Refuse to run a step whose previous step is still `todo`, and say which command to run instead. Re-running a step that is `review` or `done` is allowed and regenerates its output.
3. **Stay in your lane.** Each role only changes the files it owns (see Files), and only the outputs of the current step.
4. **Written constraints are hard.** Follow every Must / Must not in `REQUIREMENTS.md`. If one blocks you, stop and say so.
5. **Ideas are direction, not law.** If a requirement is infeasible in the time budget, say why and propose an alternative instead of silently changing it.
6. **Ambiguity:** pick the simplest option that keeps the demo working, and record it as an assumption.
7. **Evidence over opinion:** algorithm, metric, model and evaluation choices cite an evidence ID from `specs/01-research.md`. A needed method without evidence goes back to the researcher as a gap; nobody invents one.
8. **Docs over memory:** before writing code against a library, check `reference/`. If it isn't there, fetch the official docs first. The same goes for papers: never cite one nobody has opened.
9. **No secrets** in files. Config comes from environment variables, each listed in `.env.example`.
10. **Language:** write generated docs in the output language set in `REQUIREMENTS.md`. Code, identifiers and commit messages stay in English.
11. **Only the coordinator talks to the human and only the coordinator moves to the next step.**

## Moving on

`/next` means: the human has reviewed the current `review` step. Apply any feedback they gave, mark the step `done`, advance `Current step`, and run the next step. During step 5, `/next` builds the next unfinished milestone; step 5 becomes `done` only when every milestone is done.
