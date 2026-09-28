# Agent instructions

This repository turns a single requirements file into a working project, one gated step at a time.
The human writes `REQUIREMENTS.md`. You do everything else, in the order below, stopping after each step for review.

## Files

| Path | Owner | Purpose |
|---|---|---|
| `REQUIREMENTS.md` | human | The only input. Source of truth for *what* to build. |
| `inputs/` | human | Raw material referenced by the requirements. Read-only for you. |
| `PROGRESS.md` | you | Current step, step status, milestones, decision log. |
| `workflow/`, `AGENTS.md`, `CLAUDE.md`, `.claude/commands/`, `scripts/` | template | Pipeline definition. Don't modify these in a project; they're overwritten by `scripts/update-workflow.sh`. |
| `specs/` | you | Design outputs of steps 0–3. The human may edit them; their edits win. |
| `reference/` | you | Official docs you downloaded in step 2. Trust these over your memory. |
| `app/` | you | All application code and tests. |
| `docs/` | you | Human-facing docs from step 5. |

## Pipeline

| # | Step | Instructions |
|---|---|---|
| 0 | Intake | `workflow/00-intake.md` |
| 1 | Architecture & scaffold | `workflow/01-architect.md` |
| 2 | Framework & API definition | `workflow/02-define-api.md` |
| 3 | Build plan | `workflow/03-plan.md` |
| 4 | Build (repeat per milestone) | `workflow/04-build.md` |
| 5 | Documentation | `workflow/05-document.md` |

If your tool has no slash commands, the human will say "run step N" or "next". Treat that exactly like the matching command.

## Rules for every step

0. **Never run in the template.** Before anything else, run `scripts/check-not-template.sh`. If it fails, stop, show its message, and do nothing else. Don't edit, bypass or work around it.
1. **Start** by reading `PROGRESS.md`, then `REQUIREMENTS.md`, then every `specs/` file from earlier steps. Earlier outputs may have been edited by the human; use the current file contents, not what you remember writing.
2. **Don't skip ahead.** Refuse to run a step whose previous step is still `todo`, and say which command to run instead. Re-running a step that is `review` or `done` is allowed: it regenerates that step's output.
3. **Stay in scope.** Only create or change the outputs listed for the current step.
4. **Written constraints are hard.** Follow every Must / Must not in `REQUIREMENTS.md`. If one blocks you, stop and say so.
5. **Ideas are direction, not law.** If a requirement is infeasible in the time budget, say why and propose an alternative instead of silently changing it.
6. **Ambiguity:** pick the simplest option that keeps the demo working, and record it in the decision log.
7. **Docs over memory:** before writing code against a library, check `reference/`. If it isn't there, fetch the official docs first.
8. **No secrets** in files. Read config from environment variables and list each one in `.env.example`.
9. **Write generated docs** in the output language set in `REQUIREMENTS.md`. Code, identifiers and commit messages stay in English.
10. **End** every step the same way:
    - set the step's status to `review` in `PROGRESS.md` and append to the decision log;
    - reply with: what you produced (file list), decisions worth checking, open questions, and the next command;
    - then stop. Don't start the next step on your own.

## Moving on

`/next` means: the human has reviewed the current `review` step. Mark it `done`, advance `Current step`, and run the next step. During step 4, `/next` builds the next unfinished milestone; step 4 becomes `done` only when every milestone is done.
