---
name: rail-build
description: Implement one docs/monorail issue — drive rail-tdd at agreed seams, then rail-review, then commit.
disable-model-invocation: true
---

# Rail Build

Implement **one** implementation issue from `docs/monorail/<feature>/issues/`.

If `docs/monorail/work-tracker.md` is missing, tell the user to run `/rail-setup` and stop.

## Process

1. Load the issue file and its parent `spec.md`. If `spec.md` is missing, stop and suggest `/rail-spec`. Confirm blockers are done (blocker issues show `Status: done`).
2. If the issue is too large for one context window, stop and suggest `/rail-slice` re-split or `/rail-align` — do not hard-code a giant ticket.
3. Claim: set `Status: claimed` on the issue file before coding.
4. **Parallel scout** (read-only) — before writing any test or production code, map the territory with concurrent sub-agents (see below). Synthesize their reports, then confirm seams with the user if not already agreed in the spec's Testing Decisions.
5. Drive `/rail-tdd` at the agreed seams. Do **not** start TDD until scout has returned (or the sequential fallback finished).
6. Run typecheck / relevant tests regularly; full suite once at the end.
7. Run `/rail-review` against the branch fixed point (ask user if unclear).
8. **Done gate:** set issue `Status: done` only when both review axes have no blocking findings, **or** the user explicitly accepts the residual risk. Otherwise fix findings (or stop) — do not mark done.
9. Commit on the current branch only when the user's rules / request allow committing.
10. Stop. Suggest the next **frontier** issue for a **fresh** session. If no open/unblocked issues remain, say the feature's implementation queue is clear (human decides merge/ship; a new feature starts at `/rail-align`).

**Frontier (implementation):** `Status: open`, every listed blocker is `Status: done`, not claimed; lowest `NN` wins (see `docs/monorail/work-tracker.md`).

Do not start a second issue in the same session.

## Parallel scout

Parent agent stays the orchestrator. Scout is **read-only** — sub-agents must not edit files, claim issues, or start implementation.

Send a **single message** with up to three Agent/Task tool calls (explore / general-purpose). If the harness cannot spawn parallel sub-agents, run the three scopes **sequentially** — do not skip a scope that applies.

| Sub-agent | Scope | Return |
| --------- | ----- | ------ |
| **Code map** | Paths, types, and call chains named or implied by the issue / `What to build` | Relevant files + how they connect (under ~300 words) |
| **Test / seam precedents** | Existing tests and public boundaries near those paths | Candidate seams and nearby test patterns to reuse (under ~300 words) |
| **Domain docs** | `docs/monorail/CONTEXT.md` (if present), ADRs under `docs/monorail/adr/` that touch this area, plus any repo coding-standards docs | Binding terms, constraints, and standards that apply (under ~200 words) |

Omit a sub-agent only when its inputs clearly do not exist (e.g. no `CONTEXT.md` and no ADRs — skip Domain docs and note that). Always run **Code map** and **Test / seam precedents** when any code exists in the repo.

Each scout prompt must include: absolute paths to the issue file and `spec.md`, the issue's `What to build` (or equivalent) pasted in full, and "read-only — do not modify the repo".

After all scouts return: synthesize into a short seam proposal for the user (or reuse seams already settled in the spec). Then continue at step 5.

**Do not** dispatch implementation or fix sub-agents in parallel on the same working tree during build — that is out of scope for scout.

## Escape hatches (mid-build)

- Hard bug / unclear failure → suggest `/rail-debug` (prefer a fresh session if context is already heavy)
- Context full / near degraded → `/rail-pass`; do not push on
- Spec/issue wrong or incomplete (missing requirement, bad slice) → **stop**; do not keep coding. Suggest `/rail-align` (update `align.md` or map); when alignment is durable again the **planning chain** auto-continues (`/rail-spec` → `/rail-slice`). Leave the issue `Status: claimed` or revert to `open` with a `## Comments` note; do not mark `done`
