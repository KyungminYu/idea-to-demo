# Step 0 · Intake

Turn `REQUIREMENTS.md` (and anything in `inputs/`) into a clear, complete brief. No design, no code.

## Do

1. Read `REQUIREMENTS.md` and every file it references in `inputs/`.
2. Find gaps: blank sections, contradictions, features that don't fit the time budget, vague terms ("fast", "smart").
3. If anything **blocks design** (unknown core feature, unknown target platform, contradicting constraints), ask the human up to 5 focused questions, each with your suggested default. Wait for answers. For everything else, assume and move on.
4. Write `specs/00-brief.md`.

## Output: `specs/00-brief.md`

```markdown
# Brief

## Summary
One paragraph a judge could read in 20 seconds.

## Users and problem

## Scope
### Must have (demo)
Numbered. Each item has an acceptance check: "User can … and sees …".
### Nice to have
### Out of scope

## Constraints
Must / Must not, copied and made precise.

## Success criteria
How the demo proves each judging criterion.

## Assumptions
Everything you decided that wasn't written down.

## Open questions
Non-blocking ones the human should answer before step 1.
```

## Done when

Every must-have feature has an acceptance check, and there are no blocking questions left.
