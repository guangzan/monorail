---
name: rail-build
description: Implement one docs/monorail issue — drive rail-tdd at agreed seams, then rail-review, then commit.
disable-model-invocation: true
---

# Rail Build

Implement **one** implementation issue from `docs/monorail/<feature>/issues/`.

If `docs/agents/work-tracker.md` is missing, tell the user to run `/rail-setup` and stop.

## Process

1. Load the issue file and its parent `spec.md`. If `spec.md` is missing, stop and suggest `/rail-spec`. Confirm blockers are done (blocker issues show `Status: done`).
2. If the issue is too large for one context window, stop and suggest `/rail-slice` re-split or `/rail-align` — do not hard-code a giant ticket.
3. Claim: set `Status: claimed` on the issue file before coding.
4. Drive `/rail-tdd` at seams from the spec's Testing Decisions (confirm seams with the user if not already agreed).
5. Run typecheck / relevant tests regularly; full suite once at the end.
6. Run `/rail-review` against the branch fixed point (ask user if unclear).
7. **Done gate:** set issue `Status: done` only when both review axes have no blocking findings, **or** the user explicitly accepts the residual risk. Otherwise fix findings (or stop) — do not mark done.
8. Commit on the current branch only when the user's rules / request allow committing.
9. Stop. Suggest the next **frontier** issue for a **fresh** session. If no open/unblocked issues remain, say the feature's implementation queue is clear (human decides merge/ship; a new feature starts at `/rail-align`).

**Frontier (implementation):** `Status: open`, every listed blocker is `Status: done`, not claimed; lowest `NN` wins (see `docs/agents/work-tracker.md`).

Do not start a second issue in the same session.

## Escape hatches (mid-build)

- Hard bug / unclear failure → suggest `/rail-debug` (prefer a fresh session if context is already heavy)
- Context full / near degraded → `/rail-pass`; do not push on
- Spec/issue wrong or incomplete (missing requirement, bad slice) → **stop**; do not keep coding. Suggest `/rail-align` (update `align.md` or map) then `/rail-spec` / `/rail-slice` as needed — leave the issue `Status: claimed` or revert to `open` with a `## Comments` note; do not mark `done`
