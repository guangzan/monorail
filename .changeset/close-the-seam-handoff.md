---
"monorail": minor
---

Close the seam handoff from spec to build and harden the build run:

- **`/rail-slice`** — each task file now carries a required `Seams:` line (the code-anchored seams from the spec's `## Testing Decisions` that apply to that task) plus an optional `Touchpoints:` line (files it will touch). Slice also runs a story-coverage check so no numbered User Story is silently dropped.
- **`/rail-build`** — consumes each task's `Seams:` line instead of re-deriving seams in the build session; the implementer brief, scout prompts, and TDD entry all use the task's own seams. Adds a stale-`claimed` recovery rule (a crash-left claim no longer silently blocks the frontier) and a standardized, audit-able done-gate block under each task's `## Comments`. The end of a run cross-checks that every User Story is covered by a `done` task before declaring the queue clear.
- **`/rail-tdd`** — scopes seam confirmation: standalone use still confirms with the user; inside a build it records the pre-agreed task seams and raises only on a real contradiction (no mid-run prompts).
- **`/rail-align`** — adds a budget checkpoint before auto-continuing into spec: when the grilling has already consumed a large share of the session's context, it stops with `align.md` written so `/rail-spec`'s code-grounding pass and single seam confirmation run in a fresh window.
