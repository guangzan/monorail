---
name: rail-align
description: Align on a plan or design — light grilling with domain docs by default; map mode for foggy multi-session efforts. Light mode always writes docs/monorail/<slug>/align.md before handing off to spec.
disable-model-invocation: true
---

# Rail Align

Sharpen an idea before spec/build. Two modes — pick with an opening gate.

If `docs/agents/work-tracker.md` or `docs/agents/domain.md` is missing, tell the user to run `/rail-setup` first and stop.

## Opening gate

After the user states the idea, ask one question:

> Is this small enough to settle in **this** conversation, or is it foggy / multi-session?

- **This conversation** → **Light mode**
- **Foggy / multi-session** → **Map mode** (read [`map-mode.md`](map-mode.md))
- If unsure: start light; escalate to map only when fog appears mid-session and the user agrees

If map mode's first breadth pass finds **no fog**, do not create a map — stay in light mode.

## Light mode (default)

1. Interview one question at a time (same discipline as `/rail-grill`), with recommended answers
2. Actively maintain domain docs:
   - Challenge terms against `CONTEXT.md`
   - Sharpen fuzzy language; propose canonical terms
   - When a hard-to-reverse decision crystallises, write an ADR under the path in `docs/agents/domain.md`
   - Create `CONTEXT.md` / `docs/adr/` lazily when first needed
3. When the decision tree is resolved and the user confirms shared understanding, **persist before stopping**:
   - Confirm the feature slug (`docs/monorail/<slug>/`) — reuse an existing work directory for this effort if one already exists; do not invent a parallel slug
   - Write `docs/monorail/<slug>/align.md` using the template below (create the directory if needed)
   - Domain docs alone are **not** enough — `/rail-spec` requires this file (or a cleared map)
4. Suggest the human next step: `/rail-spec` for this same `<slug>` (do not invoke it)

### `align.md` template

Use these exact headings:

- `## Intent` — what we're building and why (user perspective)
- `## Decisions settled` — bulleted consensus from this align (trade-offs the user owned)
- `## Deferred` — explicitly parked; not blockers for spec (or `None`)
- `## Out of scope`
- `## Domain pointers` — links/paths to `CONTEXT.md` terms and ADRs touched (or `None`)

Do **not** treat conversation memory as the pass. If context is near limits before step 3, write `/rail-pass` and finish `align.md` in the next session from that pass document — never suggest `/rail-spec` without a durable align or map artifact.

## Map mode

Follow [`map-mode.md`](map-mode.md). Confirm the effort slug before writing any `docs/monorail/` files. Still update `CONTEXT.md` / ADRs when terms crystallise. Produce **decisions**, not implementation deliverables.

Map mode does **not** require `align.md` — `map.md` + resolved `decisions/` are the durable source for `/rail-spec`.

## Completion

- Light: user confirms alignment; `align.md` written; domain docs updated as needed
- Map charting: `map.md` + initial `decisions/` written (each with a `Type`); no tickets resolved in the charting session
- Map work-through: exactly one ticket resolved (any `Type`); map index updated; research tickets also write `notes/`

Near context limits: stop and suggest `/rail-pass` instead of continuing degraded.
