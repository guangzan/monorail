---
"monorail": minor
---

`rail-spec` now runs a **mandatory read-only code-grounding pass** before writing: it reuses `rail-build`'s scout trio (code map, test/seam precedents, domain docs) to anchor the spec's `## Testing Decisions` seams in the actual code, and confirms seams with the user **once at spec time**. `rail-build`'s scout then plays a **verification** role — it checks the spec seams still hold and raises a seam question only when scout contradicts the spec. This removes the duplicate seam confirmation between spec and build and the rework from specs written blind to the code.
