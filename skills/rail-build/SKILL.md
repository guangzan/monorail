---
name: rail-build
description: Implement docs/monorail tasks serially in one session — drive rail-tdd at agreed seams, then commit.
disable-model-invocation: true
---

# Rail Build

Implement tasks from `docs/monorail/<feature>/tasks/`. **One session, serial run**: after a task goes green, continue to the next frontier task in the **same** session — no fresh session, no "continue?" check-ins between tasks (unless the user chose review-pause up front).

If `docs/monorail/work-tracker.md` is missing, tell the user to run `/rail-setup` and stop.

## Process

1. Load the task file and its parent `spec.md`. If `spec.md` is missing, stop and suggest `/rail-spec`. Confirm blockers are done (blocker tasks show `Status: done`).
2. If the task is too large for one context window, stop and suggest `/rail-slice` re-split or `/rail-align` — do not hard-code a giant task.
3. Claim: set `Status: claimed` on the task file before coding.
4. **Parallel scout** (read-only) — before writing any test or production code, map the territory with concurrent sub-agents (see below). Synthesize their reports, then confirm seams with the user if not already agreed in the spec's Testing Decisions. If dispatch is delayed until the orchestrator context is heavy, write the synthesis to a scratch note so the implementer brief is not degraded.
5. Drive `/rail-tdd` at the agreed seams. Do **not** start TDD until scout has returned (or the sequential fallback finished).
6. Run typecheck / relevant tests regularly; full suite once at the end.
7. Set task `Status: done` when the task's behaviour is covered (TDD complete at the agreed seams) and typecheck / relevant tests are green. Do **not** run `/rail-review` as part of build — review is opt-in (see `/rail-review`).
8. Commit on the current branch only when the user's rules / request allow committing.
9. **Continue or stop.** Another frontier task exists and the user's go-ahead covers it → continue serially (see **Serial run**). Otherwise stop and report where you left off. When the run ends with no open/unblocked tasks remaining, say the feature's implementation queue is clear (human decides merge/ship; a new feature starts at `/rail-align`).

**Frontier (implementation):** `Status: open`, every listed blocker is `Status: done`, not claimed; lowest `NN` wins (see `docs/monorail/work-tracker.md`).

Never run two tasks in the same working tree **concurrently** — serial runs are strictly sequential. For actual parallelism use worktrees (**Parallel builds** below).

## Serial run (one session, task after task)

The default is **one prolonged session**: green tasks keep coming — one working tree, one commit per task, no new sessions. A serial run is throughput, not parallelism; parallel execution still requires worktrees (next section).

A serial run is the default once build starts. If the user has not already signalled the run's length, ask **once** up front — e.g. "run to queue-clear, or pause between tasks for review?" — then never ask again mid-run. Run to queue-clear is the default; the user can narrow it anytime ("just this task", "stop after task k").

Fit check (before the run):

- Same feature (same `spec.md`) so one scout + one seam confirmation covers the run
- Each task fits one fresh context window (rail-slice already guarantees this) — a **heavy** slice that needs its own context budget should be its own session, not folded into a serial run
- No two tasks edit the same files — check paths up front; if files overlap, order the later task **after** the one that owns the file, or drop it from the run

### 1. Pre-flight (once, per run)

- **File map:** list per-task files; order the run by file ownership and `Blocked by` edges, not by `NN`.
- **Contradiction scan:** acceptance criteria that conflict, two tasks owning the same public symbol, seams that overlap. Present everything as **one** up-front question before coding — not one interrupt per task.
- **Seams:** write down the seams per task from the spec's Testing Decisions, confirm once, then never ask again mid-run.
- **Review pause:** if the user chose "pause between tasks", insert a review stop after each task's commit (the commit is the hand-off point) and wait for a go-ahead before the next task.

### 2. Claim and record

- Claim each task (`Status: claimed`) and commit those edits before the run, so status is durable (follow the user's commit rules).
- Under each task's `## Comments`, append `Run <date>: start — <base commit>`; after each task, append `done — <commits>`. These lines are the resume map after `/rail-pass` or a crash.

### 3. Run (sequential, no check-ins)

For each task in order:

1. **Keep the orchestrator head clean.** For a **non-trivial** task, dispatch a **fresh implementer sub-agent** (sequential — wait for it to return before the next). Its brief must be self-contained: absolute paths to the task file and `spec.md`, `What to build` and `Acceptance criteria` pasted in full, the agreed seams for this task, and "TDD at these seams — red before green; do not touch other tasks' files; read-only on the tracker". If the harness cannot spawn sub-agents, implement the task yourself — **sequentially**. Never dispatch two implementers on the same tree. For a **trivial** task, implement it inline in the main session — no sub-agent overhead.
2. When the implementer returns (or you finish inline): run typecheck / relevant tests yourself and check the acceptance criteria against the code.
3. Green → set `Status: done`, append the `done` line, commit (per the user's commit rules), continue. **Do not pause between tasks** to ask "continue?" — the run was the go-ahead (unless review-pause was chosen in pre-flight).
4. Red or criteria not met → send the failing evidence back to the same implementer (its context is intact); if it cannot resolve, stop per §4. Never mark `done` on red.

### 4. Stop conditions (reactive, task-level)

- Hard bug / unclear failure on task *k* → commit tasks *1..k-1*, leave task *k* `claimed` with a `## Comments` note (or revert to `open`), stop, suggest `/rail-debug`. Completed work stays committed — never roll back.
- Context degraded (compaction keeps firing, reasoning quality drops, harness warns) → stop the run; hand the next task to a fresh implementer sub-agent or write `/rail-pass`. The `## Comments` run lines resume the run.
- Spec/task wrong → stop the run; same rule as a single task (`/rail-align`, leave `claimed`/`open`, never `done`).
- User narrowed or ended the run → stop at that point and report where you left off (what's `done`, what's next).
- Harness poor fit for long sessions → fall back to one-task-per-fresh-session mode. That is the escape hatch, not the default.

`done` still means green at the agreed seams, per task — a partially implemented task is not `done`. Run the full suite once at the end of the run.

A serial run does not replace **Parallel builds** below (true concurrency still needs one worktree per task — one serial run per worktree).

## Parallel builds (worktree-mandatory)

The default is one serial run in the current worktree. To run **more than one** `/rail-build` at once, isolation is a **git worktree**, not "more sessions".

**Hard rule:** never two build writers on the same working tree — whether two Cursor sessions, two sub-agents, or any mix. Same-cwd concurrent builds are forbidden; stop and set up worktrees instead.

### Setup (primary worktree only, serially)

1. Pick N frontier tasks (`Status: open`, blockers `done`).
2. Claim each (`Status: claimed`) on the **primary** worktree.
3. Commit those claim edits on the integration branch so Status is durable before fork (follow the user's commit rules).
4. For each claimed task, add a dedicated worktree + branch from that commit, e.g.:
   - branch: `rail/build/<feature>-<NN>`
   - path: repo-sibling or `.worktrees/<feature>-<NN>` (create `.worktrees/` if needed; do not commit build artifacts from it)
   - `git worktree add <path> -b rail/build/<feature>-<NN> <integration-ref>`
5. Start **one** `/rail-build` per worktree (cwd = that worktree). The task is already claimed — verify `claimed`, do not claim a different task.

### During / after

- Each build writes only inside its own worktree. Do not edit other worktrees' files.
- Mark `Status: done` and commit on that task's branch when the solo done gate passes.
- **Integrate serially** into the integration branch (merge or rebase **one branch at a time**). Resolve conflicts on the integration branch. Do not parallel-merge.
- Remove worktrees after their branches are integrated.

Parallel builds do **not** mean dispatching implementation sub-agents on one tree — a **serial run** dispatches them strictly sequentially; parallel means separate worktrees (usually separate sessions). Keep scout's same-tree implementation ban.

## Parallel scout

Parent agent stays the orchestrator. Scout is **read-only** — sub-agents must not edit files, claim tasks, or start implementation.

Send a **single message** with up to three Agent/Task tool calls (explore / general-purpose). If the harness cannot spawn parallel sub-agents, run the three scopes **sequentially** — do not skip a scope that applies.

| Sub-agent | Scope | Return |
| --------- | ----- | ------ |
| **Code map** | Paths, types, and call chains named or implied by the task / `What to build` | Relevant files + how they connect (under ~300 words) |
| **Test / seam precedents** | Existing tests and public boundaries near those paths | Candidate seams and nearby test patterns to reuse (under ~300 words) |
| **Domain docs** | `docs/monorail/CONTEXT.md` (if present), ADRs under `docs/monorail/adr/` that touch this area, plus any repo coding-standards docs | Binding terms, constraints, and standards that apply (under ~200 words) |

Omit a sub-agent only when its inputs clearly do not exist (e.g. no `CONTEXT.md` and no ADRs — skip Domain docs and note that). Always run **Code map** and **Test / seam precedents** when any code exists in the repo.

Each scout prompt must include: absolute paths to the task file and `spec.md`, the task's `What to build` (or equivalent) pasted in full, and "read-only — do not modify the repo".

After all scouts return: synthesize into a short seam proposal for the user (or reuse seams already settled in the spec). Then continue at step 5.

**Do not** dispatch implementation or fix sub-agents in parallel on the same working tree during build — that is out of scope for scout. For multi-task throughput, use **Parallel builds** (worktrees) above.

## Escape hatches (mid-build)

- Hard bug / unclear failure → suggest `/rail-debug` (fresh session only if the run's context is already heavy)
- Context full / near degraded → `/rail-pass`; do not push on — the `## Comments` run lines resume the run
- Spec/task wrong or incomplete (missing requirement, bad slice) → **stop**; do not keep coding. Suggest `/rail-align` (update `align.md` or map); when alignment is durable again the **planning chain** auto-continues (`/rail-spec` → `/rail-slice`). Leave the task `Status: claimed` or revert to `open` with a `## Comments` note; do not mark `done`
