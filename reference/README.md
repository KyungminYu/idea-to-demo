# reference

Everything the agents build against instead of their memory.

- `papers/`: one notes file per verified paper, written by the researcher in step 1 (`/research`). IDs (`E1`, `E2`, …) match the evidence index in `specs/01-research.md`.
- Everything else: official docs for every framework, library and API the app uses, fetched in step 3 (`/define-api`).

- One file per dependency: `<name>-<version>.md` (or `.txt` for `llms.txt` dumps).
- First line of each file: the source URL and the date it was fetched.
- You can add files yourself before step 3 (for example sponsor API docs). The agent will use them.
