---
"monorail": minor
---

`/rail-build` no longer forces a fresh session per task. A build is a **user-triggered serial run**: after a task goes green, it continues to the next frontier task in the same session (no fresh session, no "continue?" check-ins). Non-trivial tasks are still isolated in a fresh implementer sub-agent; trivial tasks run inline. One up-front question sets the run length — "run to queue-clear, or pause between tasks for review?" — with run-to-clear as the default. Stops are reactive: queue clear, user narrowing/ending the run, hard bug (`/rail-debug`), or genuine context degradation (`/rail-pass` or a fresh sub-agent). The old **Batch mode** term is retired — serial-in-one-session is now the default behaviour. Parallel builds still require one git worktree per task; the worktree hard rule is unchanged.
