# reference

Official docs for every framework, library and API the app uses. Filled in by step 2 (`/define-api`).
The agent writes code against these files, not its memory.

- One file per dependency: `<name>-<version>.md` (or `.txt` for `llms.txt` dumps).
- First line of each file: the source URL and the date it was fetched.
- You can add files yourself before step 2 (for example sponsor API docs). The agent will use them.
