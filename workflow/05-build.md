# Step 5 · Build

Implement **one milestone per run**. If the human named one (e.g. `/build M2`), build that one; otherwise build the first unchecked milestone in `PROGRESS.md`.

## Do

1. Read the milestone in `specs/04-plan.md`, the interfaces it touches in `specs/03-interfaces.md`, the research decisions and paper notes it cites (`specs/01-research.md`, `reference/papers/`), and the matching docs in `reference/`.
2. For each task:
   - implement against the existing stubs; keep the signatures from the contract. If a contract turns out to be wrong, update `specs/03-interfaces.md` and `specs/api/` first and log why;
   - where code implements a research method, put a short comment above it naming the evidence and section, e.g. `# Method: E3 §4.2 (betweenness on reply graph)`. Use the parameters from the paper notes unless the spec says otherwise;
   - turn the matching contract tests on and add tests for the logic;
   - run the tests.
3. Run the milestone's demo check yourself. Fix until it passes.
4. Update `app/README.md` if commands or env vars changed, and `.env.example` for any new variable.
5. Check off the tasks and the milestone in `specs/04-plan.md` and `PROGRESS.md`.
6. Suggest a commit message (`feat(M2): …`) but don't commit unless asked.

## Don't

- Start the next milestone.
- Add features outside the milestone, even small ones. Put ideas under "Nice to have" in the brief instead.
- Leave failing tests without saying so in your summary.

## Done when

The demo check passes, tests pass (or failures are listed with a reason), and the milestone is checked off.
