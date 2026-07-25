---
name: rail-pass
description: Compact the current conversation into a pass document for a fresh agent session.
disable-model-invocation: true
---

# Rail Pass

Write a pass document so a fresh agent can continue. Save under the OS temp directory **or** `docs/monorail/<feature>/pass-<date>.md` if a feature slug is active and the user prefers repo-local — ask once if unclear.

## Include

- Goal of the next session
- Decisions already made (pointers to `CONTEXT.md`, ADRs, `docs/monorail/**` paths — do not duplicate)
- If light align finished decisions but `align.md` is not written yet: say so explicitly and make writing `align.md` the next-session goal (do not suggest `/rail-spec` until it exists)
- Open questions
- Suggested skills (`/rail-align`, `/rail-build`, …)
- Exact file paths to read first (`align.md`, `map.md`, `spec.md`, issue file, …)

## Rules

- Redact secrets and PII
- If the user passed arguments, treat them as the next session focus
- Do not continue implementing in this session after writing the pass document
