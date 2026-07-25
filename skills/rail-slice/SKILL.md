---
name: rail-slice
description: Break an existing docs/monorail/<feature>/spec.md into tracer-bullet issues under issues/, each with Blocked by edges.
disable-model-invocation: true
---

# Rail Slice

Break an existing **spec** into **implementation** tickets — vertical tracer bullets with blocking edges. Local files only.

If `docs/agents/work-tracker.md` is missing, tell the user to run `/rail-setup` and stop.

## Process

### 1. Gather context

Require an existing `docs/monorail/<feature-slug>/spec.md`. If missing, stop and suggest `/rail-spec` — do not slice from conversation alone.

If `spec.md` exists but there is neither `align.md` nor a `map.md` for the same slug, warn that the spec may be unanchored and ask whether to proceed or return to `/rail-align` — do not silently treat a hollow chain as fine.

Derive `<feature-slug>` from the spec path (or from the sole matching `docs/monorail/*/spec.md` if unambiguous). Do not invent a parallel slug. Read the spec fully; use conversation only to enrich tickets.

### 2. Explore (optional)

Prefer domain vocabulary. Prefactor opportunities: "make the change easy, then make the easy change."

### 3. Draft vertical slices

Rules:

- Each slice is a narrow **complete** path through layers (not horizontal one-layer work)
- Demoable or verifiable alone
- Fits one fresh context window
- Prefactors first
- Wide mechanical refactors: expand → migrate batches → contract (not forced into one tracer bullet)

Give each ticket blocking edges.

### 4. Quiz the user

Present numbered list: Title, Blocked by, What it delivers. Ask granularity / edges / merge-split. Iterate until approved.

### 5. Publish

Write one file per ticket at `docs/monorail/<feature-slug>/issues/<NN>-<slug>.md` (same directory as `spec.md`), numbered from `01`, blockers first. Never a single combined tickets file.

Each issue file must include:

- Title line: `# NN — <Ticket title>`
- `Status: open`
- `Blocked by: None` or `Blocked by: NN, NN`
- `## What to build` — end-to-end behaviour from the user perspective
- `## Acceptance criteria` — checklist items

`Blocked by` lists `NN` numbers/titles or `None`.

### Completion

Files written; tell the user to work the frontier with `/rail-build` (one issue per session, clear context between).

Near context limits: stop and suggest `/rail-pass` instead of publishing a degraded slice set.
