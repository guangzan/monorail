---
name: rail-align
description: Align on a plan or design — light grilling with domain docs by default; map mode for foggy multi-session efforts. Light mode writes docs/monorail/<slug>/align.md then auto-continues the planning chain (spec → slice).
disable-model-invocation: true
---

# Rail Align

Sharpen an idea before spec/build. Two modes — pick with an opening gate.

If `docs/monorail/work-tracker.md` or `docs/monorail/domain.md` is missing, tell the user to run `/rail-setup` first and stop.

## Opening gate

After the user states the idea, ask one question:

> Is this small enough to settle in **this** conversation, or is it foggy / multi-session?

- **This conversation** → **Light mode**
- **Foggy / multi-session** → **Map mode** (read [`map-mode.md`](map-mode.md))
- If unsure: start light; escalate to map only when fog appears mid-session and the user agrees

If map mode's first breadth pass finds **no fog**, do not create a map — stay in light mode.

## Light mode (default)

1. Interview one question at a time (same discipline as `/rail-grill`), with recommended answers
2. Actively maintain domain docs (paths from `docs/monorail/domain.md`):
   - Challenge terms against `docs/monorail/CONTEXT.md`
   - Sharpen fuzzy language; propose canonical terms
   - When a hard-to-reverse decision crystallises, write an ADR under `docs/monorail/adr/`
   - Create `docs/monorail/CONTEXT.md` / `docs/monorail/adr/` lazily when first needed
3. When the decision tree is resolved and the user confirms shared understanding, **persist before continuing**:
   - **Pick a new feature slug** (`docs/monorail/<slug>/`) — agent chooses; **never ask** the user; **never reuse** an existing `docs/monorail/<slug>/` work directory (related prior efforts stay separate; link them from Domain pointers if useful). If the user already named a free slug, use it; if that path exists or the name is reserved, invent a distinct unused kebab-case slug (suffix if needed). Reserved names: `CONTEXT.md`, `CONTEXT-MAP.md`, `adr`, `work-tracker.md`, `domain.md`
   - **Do not** interview for slug (no A/B/C, no “new vs continue”) — slug is path bookkeeping, not a decision-tree branch
   - Write `docs/monorail/<slug>/align.md` using the template below (create the directory)
   - Domain docs alone are **not** enough — `/rail-spec` requires this file (or a cleared map)
4. **Continue the planning chain** for this same `<slug>`: read and follow `/rail-spec` in this same session (then that skill continues to `/rail-slice`). Do **not** stop and ask the user to type `/rail-spec`. Do **not** substitute `/to-spec` or other foreign-pack equivalents.
   - **Exceptions (stop instead):** user asked to stop after align; context near limits → `/rail-pass`

### `align.md` template

Use these exact headings:

- `## Intent` — what we're building and why (user perspective)
- `## Decisions settled` — bulleted consensus from this align (trade-offs the user owned)
- `## Deferred` — explicitly parked; not blockers for spec (or `None`)
- `## Out of scope`
- `## Domain pointers` — links/paths to `docs/monorail/CONTEXT.md` terms and ADRs touched (or `None`)

Do **not** treat conversation memory as the pass. If context is near limits before step 3, request `/rail-pass` and finish `align.md` in the next session from that pass document — never suggest `/rail-spec` without a durable align or map artifact.

## Map mode

Follow [`map-mode.md`](map-mode.md). Charting opens a **new** effort slug (same rules as light persist — never ask, never reuse); work-through stays on the map's existing slug. Still update `docs/monorail/CONTEXT.md` / ADRs when terms crystallise. Produce **decisions**, not implementation deliverables.

Map mode does **not** require `align.md` — `map.md` + resolved `decisions/` are the durable source for `/rail-spec`.

## Completion

- Light: user confirms alignment; `align.md` written; domain docs updated as needed; then auto-continue into `/rail-spec` (unless an exception above applies)
- Map charting: `map.md` + initial `decisions/` written (each with a `Type`); no tickets resolved in the charting session — **stop** (do not auto-continue; next session works tickets)
- Map work-through: exactly one ticket resolved (any `Type`); map index updated; research tickets also write `notes/` — **stop** unless the map is now clear, in which case auto-continue into `/rail-spec` (see `map-mode.md`)

Near context limits: stop and suggest `/rail-pass` instead of continuing degraded.
