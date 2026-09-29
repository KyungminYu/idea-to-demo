# Step 4 · Build plan

Split the work into milestones that are each demoable on their own. If time runs out, the last finished milestone is the demo.

## Do

1. Read the brief, architecture and interfaces.
2. Order milestones by demo value:
   - **M1 walking skeleton**: the main demo path end to end, with fake or hard-coded data;
   - **M2…** replace fakes with real logic, one must-have feature at a time;
   - one milestone for the "wow" moment;
   - where research kept a baseline, build the baseline first and the chosen method after it, so there's always a working fallback;
   - **last: demo polish**: seed data, loading states, happy-path error messages.
3. Split each milestone into tasks small enough for one focused session. Each task names the interfaces from `specs/03-interfaces.md` it implements and, for method tasks, the evidence IDs.
4. Give each milestone an honest time estimate. If the total is over the time budget, cut nice-to-haves first, then propose cuts to must-haves and ask.
5. Write `specs/04-plan.md` and copy the milestone checklist into the Milestones section of `PROGRESS.md`.

## Output: `specs/04-plan.md`

```markdown
# Build plan

Time budget: … · Estimated total: …

## M1 · Walking skeleton (est. …)
Goal: …
Demo check: "Run …, open …, do …, see …"
- [ ] task — interfaces: … — evidence: … — test: …

## M2 · …

## Cut list
What was dropped to fit the budget, in the order it would come back.
```

## Done when

Every must-have feature appears in some milestone, and every milestone has a demo check a human can run.
