# Step 2 · Architecture & scaffold

Choose the stack, design the structure, and create an empty but runnable skeleton in `app/`.

## Do

1. Read `specs/00-brief.md` and `specs/01-research.md`.
2. Pick the stack. Use the preferred stack from `REQUIREMENTS.md` where given. Where it's blank, choose what gets a demo working fastest with the least moving parts, and prefer one language across the stack when reasonable. The chosen methods from research may dictate libraries (e.g. a graph library that implements the chosen algorithm). For each choice, give one alternative you rejected and why.
3. Design components and data flow. Keep it as small as the must-have scope allows. Every component that implements a research goal names its evidence IDs.
4. Write `specs/02-architecture.md`.
5. Scaffold `app/`:
   - create the directory tree from the spec, using the framework's official generator where one exists;
   - add minimal config: dependency manifest, formatter/linter, test runner, `.env.example` entries;
   - make it start: a hello-world page, endpoint or CLI command;
   - write `app/README.md` with install, run and test commands.
6. Run install, start and test commands and confirm they work. If something can't run in this environment (for example no network), say exactly what you couldn't verify.

## Output: `specs/02-architecture.md`

```markdown
# Architecture

## Stack
| Layer | Choice | Version | Rejected alternative | Why |

## Components
| Component | Responsibility | Inputs → outputs | Method (evidence IDs) |
Method column: the research decision it implements, or "—" for plain plumbing.

## Screens and user flow
Skip if there's no UI. Each screen: what the user sees and does there. Then the exact path the demo follows.

## Data flow
A diagram (Mermaid or ASCII) of the main demo path.

## Directory layout
The `app/` tree with one-line comments.

## Cross-cutting
Config and env vars, error handling, logging, how tests run.

## Risks
What could sink the demo, and the fallback for each.
```

## Done when

`app/` starts with the documented command and the tree matches the spec.
