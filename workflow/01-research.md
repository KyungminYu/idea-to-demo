# Step 1 · Research

Find the current best published methods for each part of the problem, so every later design decision rests on evidence instead of guesswork.
The output is a paper-driven menu of techniques grouped by goal, with concrete signals and metrics you can compute, and a decision for each goal.

Scope comes from `Research:` in `REQUIREMENTS.md`:
- `methods` (default): algorithms, metrics, models, evaluation. Tool choices like web frameworks rely on official docs in step 3, not papers.
- `all`: also back architecture and tooling choices with papers or published benchmarks where they exist.
- `off`: skip this step. Write a one-line `specs/01-research.md` saying so, and later steps mark method choices "no evidence (research off)".

## Do

1. **Break the problem into goals.** From `specs/00-brief.md`, list the sub-problems whose solution method is a real choice (e.g. "detect key-person risk in a communication graph", "score communication waste"). Skip goals with an obvious standard answer and say why.
2. **Search, don't recall.** For each goal, query paper APIs and record every query:
   - arXiv: `http://export.arxiv.org/api/query?search_query=...`
   - Semantic Scholar: `https://api.semanticscholar.org/graph/v1/paper/search?query=...&fields=title,year,venue,citationCount,externalIds,openAccessPdf,abstract`
   - OpenAlex: `https://api.openalex.org/works?search=...`
   Add surveys and benchmark leaderboards when they exist. Also include foundational papers for the dataset or the domain (e.g. the dataset's own paper).
3. **Filter for "recent and best".**
   - Recency: published within `Paper recency` from `REQUIREMENTS.md` (default 3 years). Older papers only if they're the foundation later work builds on; mark them `foundational`.
   - Quality: peer-reviewed venue or a well-cited preprint; citations relative to age; results on public benchmarks.
   - Feasibility: code or a library implementation exists, and it fits the time budget and compute available.
4. **Verify every paper you keep.** Open its page (DOI, arXiv or publisher URL) and confirm title, authors and year. Never cite a paper you haven't opened. If you can't open it, drop it.
5. **Compare per goal.** 2–3 candidates plus a simple baseline. Pick one and give the reason; say what was rejected and why. Prefer the method that gives the best demo within budget over the absolute state of the art.
6. **Extract what to build.** For the chosen method: the concrete signals, formulas, parameters and evaluation you'll use, each tagged with its evidence ID and the section it came from.
7. **Save notes, not copies.** For each kept paper, write `reference/papers/E<n>-<short-name>.md`: citation, URL/DOI, date opened, a 3–5 line summary in your own words, and exactly what this project takes from it (section, equation, table). Don't commit full PDFs unless the license clearly allows it; link them.

## Output: `specs/01-research.md`

```markdown
# Research

## Search log
| Goal | Source | Query | Filters | Date | Hits kept |

## G1 · <goal>

### Candidates
| ID | Paper (year, venue) | Method in one line | Quality signal (citations, benchmark) | Code | Fits budget? |
Include a baseline row.

### Signals and metrics to adopt
- <signal or formula> — E<n> §<section>

### Decision
Chosen: E<n>, because …
Baseline kept for comparison: …
Rejected: E<m>, because …
Risks: …

## G2 · …

## Evidence index
| ID | Title | Authors | Year | Venue | URL / DOI | Opened on | Notes file | Tag (recent / foundational) |

## Gaps
Goals where no good evidence was found, and the fallback approach.
```

## Done when

Every goal has a decision backed by at least one opened, recorded paper (or is listed under Gaps), every evidence ID has a notes file in `reference/papers/`, and the search log shows how each paper was found.
