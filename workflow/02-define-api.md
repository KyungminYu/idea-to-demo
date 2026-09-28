# Step 2 · Framework & API definition

Pin down every interface before writing logic: the external libraries and APIs you depend on, and the contracts inside the app.

## Do

### A. External frameworks and APIs

1. List every framework, library, SDK and third-party API the architecture needs.
2. For each one, fetch the **official** docs for the pinned version and save the relevant parts in `reference/`. Prefer `llms.txt` / `llms-full.txt` when the project publishes one. Name files `<name>-<version>.md` or `.txt`, and record the source URL at the top.
3. From those docs, write down the exact calls you'll use: function or endpoint, signature, auth, rate limits, and gotchas. Don't write a signature you haven't seen in the docs.
4. Pin versions in the dependency manifest in `app/`.

### B. Internal contracts

5. Data model: entities, fields, types, relations, and example records.
6. Interfaces between components:
   - HTTP API → `specs/api/openapi.yaml` (OpenAPI 3.1)
   - events or messages → a schema per message
   - modules → a typed function signature per public function
7. Generate typed stubs in `app/` from the contracts: models or types, route handlers and service functions with correct signatures that return a clear "not implemented" error. The app must still start.
8. Add one contract test per endpoint or public function that asserts the shape, and mark it expected-to-fail or skipped until step 4.

## Output: `specs/02-interfaces.md`

```markdown
# Interfaces

## External dependencies
| Name | Version | Docs (reference/ file + URL) | Used for |

### <dependency>
Exact calls with signatures, auth, limits, gotchas.

## Data model
Tables or types, plus a Mermaid ER diagram if there's more than two entities.

## Internal API
Summary table of every endpoint or function: name, input, output, errors, and which must-have feature it serves.
Full contract in `specs/api/`.

## Traceability
| Must-have feature (from brief) | Interfaces it needs |
```

## Done when

Every must-have feature maps to at least one interface, every external call is backed by a file in `reference/`, and the app still starts with the stubs in place.
