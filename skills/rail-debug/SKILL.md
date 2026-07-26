---
name: rail-debug
description: Diagnosis loop for hard bugs and performance regressions. Use when the user says "debug this"/"diagnose", or reports something broken/throwing/failing/slow.
---

# Rail Debug

A discipline for hard bugs. Skip phases only when explicitly justified.

When exploring the codebase, read `docs/monorail/CONTEXT.md` (if it exists) and check ADRs under `docs/monorail/adr/` in the area you're touching.

## Phase 1 — Build a feedback loop

**This is the skill.** If you have a **tight** pass/fail signal for the bug — one that goes red on _this_ bug — you will find the cause. Without one, staring at code will not save you.

Spend disproportionate effort here. Be aggressive. Be creative. Refuse to give up.

### Ways to construct one — try in roughly this order

1. Failing test at whatever seam reaches the bug
2. Curl / HTTP script against a running dev server
3. CLI invocation with a fixture input
4. Headless browser script (Playwright / Puppeteer)
5. Replay a captured trace
6. Throwaway harness for the buggy path
7. Property / fuzz loop
8. Bisection harness between two known-good states
9. Differential loop (old vs new)
10. Structured HITL checklist as last resort (human clicks; you drive the checklist)

### Tighten the loop

Make it faster, sharper (assert the exact symptom), and more deterministic.

### Non-deterministic bugs

Raise reproduction rate until the bug is debuggable (loop, stress, pin timing).

### When you cannot build a loop

Stop. List what you tried. Ask for environment access, a captured artifact, or temporary instrumentation. Do **not** hypothesise without a loop.

### Completion criterion

Phase 1 is done when you can name **one command** you have already run, that is red-capable on this bug, deterministic (or high-rate), fast, and agent-runnable. No red-capable command → no Phase 2.

## Phase 2 — Reproduce + minimise

Run the loop red. Confirm it matches the **user's** symptom. Minimise: cut inputs/config/steps one at a time until every remaining element is load-bearing.

## Phase 3 — Hypothesise

Generate **3–5 ranked falsifiable hypotheses** before testing any. Show the list to the user (don't block if AFK).

Format: "If \<X\> is the cause, then \<changing Y\> will make the bug disappear / \<changing Z\> will make it worse."

## Phase 4 — Instrument

Each probe maps to a Phase 3 prediction. Change one variable at a time. Prefer debugger/REPL, then targeted logs with a unique `[DEBUG-xxxx]` prefix. For perf: measure first (baseline), then bisect.

## Phase 5 — Fix + regression test

If a **correct seam** exists (exercises the real bug pattern at the call site): write the failing regression test first, then fix, then re-run the Phase 1 loop on the original scenario.

If no correct seam exists, that is the finding — document it; architecture may be blocking lock-down.

## Phase 6 — Cleanup + post-mortem

- [ ] Original Phase 1 loop is green
- [ ] Regression test passes (or missing seam documented)
- [ ] All `[DEBUG-...]` instrumentation removed
- [ ] Throwaway harnesses deleted or clearly marked
- [ ] Correct hypothesis stated for the next debugger

Ask what would have prevented this bug. If the answer is architectural, recommend a follow-up `/rail-align` (then `/rail-spec` if the fix is large) — do not invent a skill that is not in the rail pack.

If diagnosis happened mid-feature and an implementation issue remains, suggest resuming with `/rail-build` on that issue in a **fresh** session.
