---
name: rail
description: Ask which rail skill or flow fits. Router over the rail pack.
disable-model-invocation: true
---

# Rail

A **flow** is a path through skills. Most work follows the **main chain**.

## Main chain: idea → ship

1. **`/rail-setup`** — once per repo (local `docs/monorail/` + domain docs)
2. **`/rail-align`** — light grilling → writes `align.md`; map mode if foggy/multi-session
3. **`/rail-spec`** — write `docs/monorail/<feature>/spec.md` from `align.md` and/or a cleared map (refuses empty context)
4. **`/rail-slice`** — write `issues/NN-*.md` with blockers
5. **`/rail-build`** — one issue per session; drives `/rail-tdd`, closes with `/rail-review`

Prefer keeping align → spec → slice in one window. If the window breaks, durable `align.md` / map still feed `/rail-spec`. Clear context between each `/rail-build`.

## Side paths

- No codebase → `/rail-grill`
- Context full / branch session → `/rail-pass`
- Hard bug → `/rail-debug`

## Vocabulary underneath

- `/rail-tdd` — red-green-refactor (also used inside build)
- `/rail-review` — Standards + Spec review (also used inside build)

## Map ticket types (not separate skills)

In `/rail-align` **map mode**, decision tickets may be `Type: decision | research | prototype` (see `rail-align/map-mode.md`). There is no `/rail-research` or `/rail-prototype` skill.

## Not in this pack (yet)

triage, standalone wayfinder, architecture-improve tours — use other packs or wait for a later rail version.
