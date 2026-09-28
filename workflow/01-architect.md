# Step 1 · Architecture & scaffold

Choose the stack, design the structure, and create an empty but runnable skeleton in `app/`.

## Do

1. Read `specs/00-brief.md`.
2. Pick the stack. Use the preferred stack from `REQUIREMENTS.md` where given. Where it's blank, choose what gets a demo working fastest with the least moving parts, and prefer one language across the stack when reasonable. For each choice, give one alternative you rejected and why.
3. Design components and data flow. Keep it as small as the must-have scope allows.
4. Write `specs/01-architecture.md`.
5. Scaffold `app/`:
   - create the directory tree from the spec, using the framework's official generator where one exists;
   - add minimal config: dependency manifest, formatter/linter, test runner, `.env.example` entries;
   - make it start: a hello-world page, endpoint or CLI command;
   - write `app/README.md` with install, run and test commands.
6. Run install, start and test commands and confirm they work. If something can't run in this environment (for example no network), say exactly what you couldn't verify.

## Output: `specs/01-architecture.md`

```markdown
# Architecture

## Stack
| Layer | Choice | Version | Rejected alternative | Why |

## Components
One line each: responsibility, inputs, outputs.

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
