---
name: rail-build
description: Implement one docs/monorail issue — drive rail-tdd at agreed seams, then commit.
disable-model-invocation: true
---

# Rail Build

Implement **one** implementation issue from `docs/monorail/<feature>/issues/` — or a small **batch** of frontier issues in one session (see **Batch mode** below).

If `docs/monorail/work-tracker.md` is missing, tell the user to run `/rail-setup` and stop.

## Process

1. Load the issue file and its parent `spec.md`. If `spec.md` is missing, stop and suggest `/rail-spec`. Confirm blockers are done (blocker issues show `Status: done`).
2. If the issue is too large for one context window, stop and suggest `/rail-slice` re-split or `/rail-align` — do not hard-code a giant ticket.
3. Claim: set `Status: claimed` on the issue file before coding.
4. **Parallel scout** (read-only) — before writing any test or production code, map the territory with concurrent sub-agents (see below). Synthesize their reports, then confirm seams with the user if not already agreed in the spec's Testing Decisions.
5. Drive `/rail-tdd` at the agreed seams. Do **not** start TDD until scout has returned (or the sequential fallback finished).
6. Run typecheck / relevant tests regularly; full suite once at the end.
7. Set issue `Status: done` when the issue's behaviour is covered (TDD complete at the agreed seams) and typecheck / relevant tests are green. Do **not** run `/rail-review` as part of build — review is opt-in via a separate session when the user wants it.
8. Commit on the current branch only when the user's rules / request allow committing.
9. Stop. Suggest the next **frontier** issue for a **fresh** session (or **Batch mode** when several small frontier issues are unblocked). If no open/unblocked issues remain, say the feature's implementation queue is clear (human decides merge/ship; a new feature starts at `/rail-align`).

**Frontier (implementation):** `Status: open`, every listed blocker is `Status: done`, not claimed; lowest `NN` wins (see `docs/monorail/work-tracker.md`).

Do not start a second issue in the same session **unless the run is Batch mode** (below). Never start a second issue in the same working tree **concurrently** — batch runs are strictly sequential.

## Batch mode (one session, many small issues)

Default remains one issue per session. **Batch mode** is throughput for several *small* frontier issues in one session — fewer sessions, not parallelism. Parallel execution still requires worktrees (next section).

**Opt in when:** the user asks for several issues, or several small frontier issues are unblocked and you propose it. Fit check:

- Same feature (same `spec.md`) so one scout + one seam confirmation covers the run
- Each issue fits one fresh context window (rail-slice already guarantees this)
- No two issues edit the same files — check paths up front; if files overlap, order the later issue **after** the one that owns the file, or drop it from the batch

**Do not batch:** a heavy slice that needs its own context budget, or a set whose total file map is too large to hold once. Size the batch so every issue's implementer still gets a fresh window.

### 1. Pre-flight (once, batched)

- **File map:** list per-issue files; order the batch by file ownership and `Blocked by` edges, not by `NN`.
- **Contradiction scan:** acceptance criteria that conflict, two issues owning the same public symbol, seams that overlap. Present everything as **one** batched question before coding — not one interrupt per issue.
- **Seams:** write down the seams per issue from the spec's Testing Decisions, confirm once, then never ask again mid-batch.

### 2. Claim and record

- Claim each issue (`Status: claimed`) and commit those edits before the run, so status is durable (follow the user's commit rules).
- Under each issue's `## Comments`, append `Batch <date>: start — <base commit>`; after each issue, append `done — <commits>`. These lines are the resume map after `/rail-pass` or a crash.

### 3. Run the batch (sequential, no check-ins)

For each issue in order:

1. **Dispatch a fresh implementer sub-agent** (sequential — wait for it to return before the next). Its brief must be self-contained: absolute paths to the issue file and `spec.md`, `What to build` and `Acceptance criteria` pasted in full, the agreed seams for this issue, and "TDD at these seams — red before green; do not touch other issues' files; read-only on the tracker". If the harness cannot spawn sub-agents, implement the issue yourself — **sequentially**. Never dispatch two implementers on the same tree, even in batch.
2. When it returns: run typecheck / relevant tests yourself and check the acceptance criteria against the code.
3. Green → set `Status: done`, append the `done` line, commit (per the user's commit rules), continue. **Do not pause between issues** to ask "continue?" — the batch was the go-ahead.
4. Red or criteria not met → send the failing evidence back to the same implementer (its context is intact); if it cannot resolve, stop per §4. Never mark `done` on red.

### 4. Stop conditions (per-issue, not per-session)

- Hard bug / unclear failure on issue *k* → commit issues *1..k-1*, leave issue *k* `claimed` with a `## Comments` note (or revert to `open`), stop, suggest `/rail-debug` in a fresh session. Completed work stays committed — never roll back.
- Context near limits → `/rail-pass`; the `## Comments` run lines resume the batch.
- Spec/issue wrong → stop the batch; same rule as single-issue build (`/rail-align`, leave `claimed`/`open`, never `done`).

`done` still means green at the agreed seams, per issue — a partially implemented issue is not `done`. Run the full suite once at the end of the batch.

Batch is sequential throughput; it does not replace **Parallel builds** below (true concurrency still needs one worktree per issue — combine freely: one batch per worktree).

## Parallel builds (worktree-mandatory)

Default remains one issue in the current worktree — or a **batch** (see above). To run **more than one** `/rail-build` at once, isolation is a **git worktree**, not "more sessions".

**Hard rule:** never two build writers on the same working tree — whether two Cursor sessions, two sub-agents, or any mix. Same-cwd concurrent builds are forbidden; stop and set up worktrees instead.

### Setup (primary worktree only, serially)

1. Pick N frontier issues (`Status: open`, blockers `done`).
2. Claim each (`Status: claimed`) on the **primary** worktree.
3. Commit those claim edits on the integration branch so Status is durable before fork (follow the user's commit rules).
4. For each claimed issue, add a dedicated worktree + branch from that commit, e.g.:
   - branch: `rail/build/<feature>-<NN>`
   - path: repo-sibling or `.worktrees/<feature>-<NN>` (create `.worktrees/` if needed; do not commit build artifacts from it)
   - `git worktree add <path> -b rail/build/<feature>-<NN> <integration-ref>`
5. Start **one** `/rail-build` per worktree (fresh session; **cwd = that worktree**). The issue is already claimed — verify `claimed`, do not claim a different issue.

### During / after

- Each build writes only inside its own worktree. Do not edit other worktrees' files.
- Mark `Status: done` and commit on that issue's branch when the solo done gate passes.
- **Integrate serially** into the integration branch (merge or rebase **one branch at a time**). Resolve conflicts on the integration branch. Do not parallel-merge.
- Remove worktrees after their branches are integrated.

Parallel builds do **not** mean dispatching implementation sub-agents on one tree — **batch** dispatches them strictly sequentially; parallel means separate worktrees (and usually separate sessions). Keep scout's same-tree implementation ban.

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

**Do not** dispatch implementation or fix sub-agents in parallel on the same working tree during build — that is out of scope for scout. For multi-issue throughput, use **Parallel builds** (worktrees) above.

## Escape hatches (mid-build)

- Hard bug / unclear failure → suggest `/rail-debug` (prefer a fresh session if context is already heavy)
- Context full / near degraded → `/rail-pass`; do not push on
- Spec/issue wrong or incomplete (missing requirement, bad slice) → **stop**; do not keep coding. Suggest `/rail-align` (update `align.md` or map); when alignment is durable again the **planning chain** auto-continues (`/rail-spec` → `/rail-slice`). Leave the issue `Status: claimed` or revert to `open` with a `## Comments` note; do not mark `done`
