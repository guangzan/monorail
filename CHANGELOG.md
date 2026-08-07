# monorail

## 0.2.0

### Minor Changes

- [`1bb4586`](https://github.com/guangzan/monorail/commit/1bb458605cd742ee1a5b94c17a63132f98458ffa) Thanks [@guangzan](https://github.com/guangzan)! - `/rail-build` gains **Batch mode**: several small frontier issues run sequentially in one session — fresh implementer sub-agent per issue, seams confirmed once up front, no check-ins between issues. Sequential throughput; parallel builds still require one worktree per issue.

- [`fb3a2c1`](https://github.com/guangzan/monorail/commit/fb3a2c180a6e3baa1192dafd5c0b77559aa53905) Thanks [@guangzan](https://github.com/guangzan)! - `/rail-build` no longer runs `/rail-review` or gates `done` on review findings — review is opt-in. `/rail-tdd` returns refactoring to the red-green-refactor loop.

- [`14ca0ce`](https://github.com/guangzan/monorail/commit/14ca0ce437d94ea58111cf490d84ca6b5828c17c) Thanks [@guangzan](https://github.com/guangzan)! - `/rail-build` runs a read-only parallel scout (code map, test/seam precedents, domain docs) before TDD.

- [`b617bf5`](https://github.com/guangzan/monorail/commit/b617bf58ba76182f2c102b7a48f7a6c9c7424881) Thanks [@guangzan](https://github.com/guangzan)! - Concurrent `/rail-build` runs require one git worktree per issue; same-cwd parallel builds are forbidden.

- [`7d576c5`](https://github.com/guangzan/monorail/commit/7d576c59c1436dd2e30f9db2160ce5b2626c1748) Thanks [@guangzan](https://github.com/guangzan)! - Consolidate all rail docs under `docs/monorail/` (glossary, ADRs, and setup convention files — no scatter to repo root / `docs/agents/` / `docs/adr/`).

- [`bd25d32`](https://github.com/guangzan/monorail/commit/bd25d327113496136ec39ee5b70bffe951bb1dd9) Thanks [@guangzan](https://github.com/guangzan)! - Planning chain auto-continues align → spec → slice in the same session; build still starts in a fresh session.

### Patch Changes

- [`fd50742`](https://github.com/guangzan/monorail/commit/fd50742ce722dfbc6131aec5d8e81746affffefd) Thanks [@guangzan](https://github.com/guangzan)! - `/rail-align` opens light immediately when the ask is clear; only asks about map mode when foggy or complex.

- [`a97cd8c`](https://github.com/guangzan/monorail/commit/a97cd8c59823ddf88e6ca0e7ddfb9c850f6070f2) Thanks [@guangzan](https://github.com/guangzan)! - `/rail-align` always opens a new work-directory slug on persist/charting — never ask, never reuse a sibling effort.

- [`9635550`](https://github.com/guangzan/monorail/commit/9635550213b6b2e22cda07e4e3ff25c0ec3f3588) Thanks [@guangzan](https://github.com/guangzan)! - `/rail-grill` finishes by outputting the plan and asking only whether to implement or adjust — no "confirm full scope?" gate before suggesting `/rail-align`.

- [`ddbd08f`](https://github.com/guangzan/monorail/commit/ddbd08f46fc8c7ef3aed0e9e6a32dc5d45e124c2) Thanks [@guangzan](https://github.com/guangzan)! - `/rail-grill` closing asks only implement-or-adjust — no `/rail-*` handoff suggestions.

- [`c8fe55c`](https://github.com/guangzan/monorail/commit/c8fe55c4ed7b83b16d94439602061954a5ac588c) Thanks [@guangzan](https://github.com/guangzan)! - Harden main-chain handoffs so agents suggest exact `/rail-*` next steps and do not substitute foreign-pack lookalikes (`/to-tickets`, `/to-issues`, `/to-spec`, …).

- [`ae287e8`](https://github.com/guangzan/monorail/commit/ae287e805eb90e08c98de0aaa7fd43638ac22f2c) Thanks [@guangzan](https://github.com/guangzan)! - `/rail-slice` asks the user only on real merge/split/edge trade-offs; obvious single slices publish without ceremonial A/B/C approval.
