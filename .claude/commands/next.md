---
description: Approve the current step and run the next one
argument-hint: [feedback on the current step]
---

Read `PROGRESS.md` and follow the "Moving on" section of `AGENTS.md`.

- If the user gave feedback below, apply it to the current step's outputs first, then mark it `done`.
- If the current step is still `todo`, run it instead of skipping it.
- If every step is `done`, say so and suggest what to polish.

User feedback: $ARGUMENTS
