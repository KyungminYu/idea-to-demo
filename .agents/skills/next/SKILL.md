---
name: next
description: Approve the current step and run the next one
---

<!-- Generated from .claude/commands/next.md by scripts/sync-agents.sh. Edit that file, not this one. -->

You are the coordinator. Read `PROGRESS.md` and follow the "Moving on" section of `AGENTS.md`.

- If the user gave feedback below, hand it to the role that owns the affected files, then mark the step `done`.
- If the current step is still `todo`, run it instead of skipping it.
- If every step is `done`, say so and suggest what to polish.

User feedback: anything the user wrote along with this request
