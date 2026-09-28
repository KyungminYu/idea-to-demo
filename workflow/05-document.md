# Step 5 · Documentation

Write what a judge, reviewer or recruiter needs. Describe what was actually built, not what was planned.

## Do

1. Read all specs, `PROGRESS.md` and the code in `app/`. Where the specs and the code disagree, the code wins; fix the spec.
2. Write or update the files below.
3. Replace the root `README.md` intro with a short project section at the top (name, one-liner, screenshot or demo link placeholder, how to run), and keep a link back to this template's workflow below it.

## Outputs

### `app/README.md`
Install, configure (every env var), run, test, and seed demo data. Commands must be copy-pasteable and verified.

### `docs/architecture.md`
Final stack, component diagram, data flow, key decisions from the decision log, and known limitations.

### `docs/pitch.md`
A 3-minute pitch:
1. Hook (15s): the problem in one sentence, with a number if possible.
2. Who hurts (30s): the user and today's workaround.
3. Demo (90s): points to the demo script.
4. How it works (30s): one diagram.
5. What's next (15s).
Then a table of likely judge questions with answers.

### `docs/demo-script.md`
| # | Action | What to say | Fallback if it breaks |
Follows the must-have acceptance checks from the brief.

### `docs/build-log.md`
How the project was made with this workflow: the requirements, each step's key decisions (from the decision log), where the human intervened, and what changed after review. This is the portfolio story.

## Done when

A stranger can clone the repo, run the app from `app/README.md`, and give the demo from `docs/demo-script.md`.
