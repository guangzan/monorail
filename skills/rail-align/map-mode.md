# Map mode reference

Use only when `/rail-align` has entered map mode.

## Map body (`docs/monorail/<effort>/map.md`)

Required headings: `## Destination`, `## Notes`, `## Decisions so far`, `## Not yet specified`, `## Out of scope`.

Decisions so far entries look like: `- [<closed ticket title>](./decisions/NN-slug.md) — <one-line gist>`.

Layout after charting / work-through:

```
docs/monorail/<effort>/
  map.md
  decisions/NN-<slug>.md
  notes/NN-<slug>.md       # required when a research ticket is resolved
```

## Ticket (`docs/monorail/<effort>/decisions/NN-<slug>.md`)

Required fields/headings:

- Title: `# NN — <title>`
- `Type: decision | research | prototype` (default `decision` when unsure)
- `Status: open` (values: `open` | `claimed` | `resolved`)
- `Blocked by: None` or `Blocked by: NN, NN`
- `## Question`
- `## Answer` (filled on resolve)

### Choosing `Type` (charting and fog graduation)

- **`decision`** — preference / trade-off; conversation is enough
- **`research`** — verifiable fact gap owned by primary sources (official docs, source, specs, first-party APIs). Signal: “we don’t know whether X is true / what the authority says.” Not for taste
- **`prototype`** — discussion fidelity too low (“does this feel right?” / “what should it look like?”). Not a substitute for looking up facts

Light mode does not create these typed tickets; escalate to map when a chain of research/prototype work needs persistence.

## Charting session

1. Confirm / ask for the effort slug (`docs/monorail/<effort>/`). Reuse an existing work directory for this effort if one already exists; later `/rail-spec` and `/rail-slice` **must** use this same slug
2. Name Destination via grilling (and update `docs/monorail/CONTEXT.md` / ADRs when terms crystallise)
3. Breadth-first grill for open questions; assign each creatable ticket a `Type`
4. If **no fog** — do not create a map; return to light mode
5. Write `map.md` + creatable ticket files; wire `Blocked by` in a second pass
6. Stop — charting does not resolve tickets

## Work-through session

1. Load `map.md` only (low-res)
2. Pick frontier ticket (user-named or lowest unblocked open/unclaimed)
3. Claim (`Status: claimed`) before work
4. Resolve by `Type` (below); set `Status: resolved`; append gist to Decisions so far
5. Graduate fog into new tickets with the correct `Type` as questions become sharp
6. At most **one** ticket resolved per session (any `Type`)

### Resolve: `decision`

HITL. One-question grilling until the human answers. Write `## Answer`. Update `docs/monorail/CONTEXT.md` / ADRs when terms crystallise.

### Resolve: `research`

AFK-first. Do not ask preference questions. Investigate against **primary sources** only; cite each claim. Always write `docs/monorail/<effort>/notes/NN-<slug>.md` with the full write-up. `## Answer` stays short: verdict + link to `../notes/NN-<slug>.md`.

If the work reveals a preference question instead of a fact gap: stop; change `Type` to `decision` or open a new decision ticket — do not fake a factual close.

### Resolve: `prototype`

HITL. Before building, pick the branch:

- **Logic** — state / behaviour feel → small throwaway runnable (often a tiny terminal or in-memory harness)
- **UI** — look / layout → rough throwaway UI variants the human can react to

Rules: clearly marked throwaway; one command to run; no polish; do not merge prototype code to main as product. `## Answer` must record what was tested, the verdict, and the path or branch of the artifact — do not paste large code into the ticket.

If the real blocker is a fact gap: retarget/split as `research`; do not use code instead of sources.

## Clear map → spec

When no open tickets remain and Not yet specified is empty (or only out-of-scope remains), the map is clear. **Continue the planning chain** for this same `<effort>` slug: read and follow `/rail-spec` in this same session (it will continue to `/rail-slice`). Do **not** stop and ask the user to type `/rail-spec`. Spec may cite `notes/` and prototype verdicts; those artifacts do **not** auto-become `issues/`.

**Exceptions (stop instead):** user asked to stop after the map; context near limits → `/rail-pass`.

Do **not** require `align.md` after a cleared map — `map.md` + resolved `decisions/` satisfy `/rail-spec`'s adequacy gate. If both `align.md` and a map exist for the same slug, `/rail-spec` folds both (map answers win on conflict unless the user says otherwise).
