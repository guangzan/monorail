---
name: rail-slice
description: Break an existing docs/monorail/<feature>/spec.md into tracer-bullet issues under issues/, each with Blocked by edges. Ends the planning chain — next step is rail-build in a fresh session.
disable-model-invocation: true
---

# Rail Slice

Break an existing **spec** into **implementation** tickets — vertical tracer bullets with blocking edges. Local files only.

If `docs/monorail/work-tracker.md` is missing, tell the user to run `/rail-setup` and stop.

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

### 4. Ask only on real trade-offs

Humans adjudicate **trade-offs**, not obviously correct slices.

- **No fork → publish.** If the draft has no meaningful alternative you would actually recommend (typical: one narrow ticket, `Blocked by: None`; or a clear linear chain with obvious order), **do not** quiz. Do **not** invent A/B/C options or ask "approve this list?". Go to Publish.
- **Real fork → ask only that fork.** Quiz when merge vs split, blocker order, or "is this prefactor its own ticket?" has real session-fit / risk trade-offs. Present the contested choice (and your recommendation); iterate until resolved. Do not pad with ceremonial whole-list approval.
- **User hold → wait.** If the user asked to review the draft first or not write yet, present Title / Blocked by / What it delivers and wait — do not publish.

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

Files written. In the completion message, list what was published (titles + blockers) so the user can still object next turn. **Stop here** — the planning chain ends at slice. Tell the user the next step is **`/rail-build`** on the frontier issue in a **fresh** session (one issue per session / worktree, clear context between). For multiple unblocked issues at once: small, non-overlapping issues can run as one **batch** in a single session (see `/rail-build` Batch mode); for true concurrency follow `/rail-build` **Parallel builds** (one git worktree per issue). Do **not** auto-continue into `/rail-build`. Do **not** suggest `/implement`, `/triage`, or other foreign-pack equivalents.

Near context limits: stop and suggest `/rail-pass` instead of publishing a degraded slice set.
