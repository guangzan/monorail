---
name: rail
description: Ask which rail skill or flow fits. Router over the rail pack.
disable-model-invocation: true
---

# Rail

A **flow** is a path through skills. Most work follows the **main chain**.

## Main chain: idea → ship

1. **`/rail-setup`** — once per repo (all rail docs under `docs/monorail/`)
2. **`/rail-align`** — light grilling → writes `align.md`; map mode if foggy/multi-session
3. **`/rail-spec`** — write `docs/monorail/<feature>/spec.md` from `align.md` and/or a cleared map (refuses empty context)
4. **`/rail-slice`** — write `issues/NN-*.md` with blockers
5. **`/rail-build`** — one issue per session / worktree; drives `/rail-tdd`, then marks done. Concurrent builds require **separate git worktrees** (see `rail-build`)

### Planning chain (auto-continue)

**align → spec → slice** is one planning chain. When a stage finishes successfully in this session, **continue the next stage in the same session** by reading and following that skill's `SKILL.md` — do **not** stop and ask the user to type the next `/rail-*`.

- Light align writes `align.md` → continue `/rail-spec` → continue `/rail-slice`
- Cleared map (no open tickets / fog) → continue `/rail-spec` → continue `/rail-slice`
- Standalone `/rail-spec` auto-continues to `/rail-slice`; `/rail-slice` ends the planning chain (suggest `/rail-build` only)

**Do not auto-continue into `/rail-build`.** After slice (or when build finishes an issue), suggest `/rail-build` for a **fresh** session. Clear context between each `/rail-build`. To run several builds at once, set up **one git worktree per issue** first — more sessions on the same cwd are not parallel-safe.

**Stop auto-continue when:** the user asked to stop after this stage; context is near limits (use `/rail-pass`); or an adequacy / map / fail-closed gate says stop.

If the window breaks mid-chain, durable `align.md` / map / `spec.md` still feed the next skill when the user resumes.

## In-pack handoffs only

Handoffs (auto-continue or suggest) use the **next rail skill by exact name** (`/rail-align`, `/rail-spec`, `/rail-slice`, `/rail-build`, …). Do **not** substitute lookalike skills from other packs (e.g. `/to-spec` for `/rail-spec`, `/to-tickets` / `/to-issues` for `/rail-slice`) even if those are installed in the same agent.

## Side paths

- No codebase → `/rail-grill`
- Context full / branch session → `/rail-pass`
- Hard bug → `/rail-debug`

## Vocabulary underneath

- `/rail-tdd` — red-green-refactor (also used inside build)
- `/rail-review` — Standards + Spec review (opt-in; not part of build)

## Map ticket types (not separate skills)

In `/rail-align` **map mode**, decision tickets may be `Type: decision | research | prototype` (see `rail-align/map-mode.md`). There is no `/rail-research` or `/rail-prototype` skill.

## Not in this pack (yet)

triage, standalone wayfinder, architecture-improve tours — use other packs or wait for a later rail version.
