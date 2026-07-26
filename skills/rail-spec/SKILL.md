---
name: rail-spec
description: Synthesize durable align/map sources (and current conversation) into docs/monorail/<feature>/spec.md. Refuse empty context — do not invent a thin spec.
disable-model-invocation: true
---

# Rail Spec

Turn **durable alignment** into a spec. Prefer synthesis over interview — but **never** invent a spec from thin air.

If `docs/monorail/work-tracker.md` is missing, tell the user to run `/rail-setup` and stop.

## Process

### 1. Confirm the feature slug

Before reading or writing work files:

- If the user named one, use it
- Else list `docs/monorail/*/align.md`, `docs/monorail/*/map.md`, and `docs/monorail/*/spec.md` (skip reserved names: `adr`, `work-tracker.md`, `domain.md`, `CONTEXT.md`, `CONTEXT-MAP.md`); reuse the matching effort's directory slug when unambiguous; if several, ask
- If `docs/monorail/<slug>/align.md` or `map.md` already exists for this effort, **do not** invent a different slug for the spec

### 2. Adequacy gate (fail closed)

Collect sources for this `<slug>`:

| Source | Counts as adequate? |
|---|---|
| `docs/monorail/<slug>/align.md` | Yes |
| `docs/monorail/<slug>/map.md` with at least one resolved decision linked under Decisions so far (or map clear: no open tickets, Not yet specified empty / only out-of-scope) | Yes |
| Substantial align discussion **in this same session** that has not yet been written to `align.md` | Yes — but write `align.md` first (same template as `/rail-align` light), then continue |
| `docs/monorail/<slug>/pass-*.md` or a pass path the user passed | Enrichment only — **not** sufficient alone |
| `docs/monorail/CONTEXT.md` / ADRs alone | **No** |
| Empty / unrelated conversation | **No** |

If **no** adequate source: **stop**. Tell the user to run `/rail-align` for this slug (or keep grilling in this session, then persist `align.md`). Do **not** write `spec.md`.

If the map still has open decision tickets or non-empty fog under Not yet specified: **stop**. Suggest finishing `/rail-align` map mode first — do not spec over unresolved fog.

### 3. Fold durable sources

- If `align.md` exists, read it fully — fold Intent / Decisions settled / Out of scope into the spec; do not leave consensus only in `align.md`
- If `map.md` exists, read Decisions so far and linked decision answers (and `notes/` when cited) — fold them in; do not leave decisions only on the map
- Use conversation only to enrich, never as the sole source after a fresh session

### 4. Explore and seams

Explore the codebase if needed. Use `docs/monorail/CONTEXT.md` vocabulary; respect ADRs under `docs/monorail/adr/`.

Sketch test seams (prefer existing, highest seam, few seams). Confirm seams with the user before writing.

### 5. Gap-closing only (not a full grill)

If durable sources exist but a **few** gaps block a coherent spec, ask only those questions — one at a time. If gaps are large or re-open the decision tree, stop and suggest `/rail-align` instead of pushing a hollow spec.

### 6. Write and stop

Write `docs/monorail/<feature-slug>/spec.md` using the template below.

Stop. Suggest `/rail-slice` as the next human step.

Near context limits: stop and suggest `/rail-pass` instead of writing a degraded spec.

## Spec template

Use these exact headings in `spec.md`:

- `## Problem Statement`
- `## Solution`
- `## User Stories` (numbered: As a \<actor\>, I want \<feature\>, so that \<benefit\>)
- `## Implementation Decisions` (modules/interfaces/architecture/schema/API — no fragile file paths unless quoting a prototype snippet that encodes a decision)
- `## Testing Decisions` (external behaviour; seams; prior art)
- `## Out of Scope`
- `## Further Notes`
