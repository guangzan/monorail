---
'monorail': minor
---

`/rail-build` no longer mandates a parallel read-only scout (3 sub-agents) before every task. Exploration is on demand and left to the agent — a small task can read one or two files and go straight to red-phase TDD. The seam re-check is preserved as a single inline step: open the file(s) the task's `Seams:` line points at before writing the first test, and if the code contradicts the spec's `## Testing Decisions`, stop and report per build §4 instead of re-deriving seams. The old `## Parallel scout` section becomes an optional, on-demand read-only sweep for unfamiliar or wide territory. Non-trivial tasks still default to a fresh implementer sub-agent, but whether to go inline is now the agent's call.