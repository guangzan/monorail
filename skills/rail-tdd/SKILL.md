---
name: rail-tdd
description: Test-driven development with red-green-refactor. Use when building a behaviour test-first, fixing a bug with a regression test, or when rail-build needs TDD at an agreed seam.
---

# Rail TDD

TDD is the red → green loop. This skill is the reference that makes that loop produce tests worth keeping.

When exploring the codebase, read `docs/monorail/CONTEXT.md` (if it exists) so vocabulary matches the project's domain language, and respect ADRs under `docs/monorail/adr/` in the area you're touching.

## What a good test is

Tests verify behavior through public interfaces, not implementation details. A good test reads like a specification and survives refactors.

See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mocking guidelines.

## Seams — where tests go

A **seam** is the public boundary you test at. Tests live at seams, never against internals.

**Test only at pre-agreed seams.** Before writing any test, write down the seams under test and confirm them with the user. No test is written at an unconfirmed seam.

Ask: "What's the public interface, and which seams should we test?"

## Anti-patterns

- **Implementation-coupled** — mocks internals, tests private methods, or verifies via side channels. Tell: breaks on refactor with unchanged behaviour.
- **Tautological** — assertion recomputes the expected value the way the code does. Expected values need an independent source of truth.
- **Horizontal slicing** — all tests first, then all implementation. Work in **vertical slices** instead — one test → one implementation → repeat.

## Rules of the loop

- **Red before green.** Write the failing test first, then only enough code to pass it.
- **One slice at a time.** One seam, one test, one minimal implementation per cycle.
- **Refactoring is not part of the loop.** It belongs to review (`/rail-review`), not the red → green cycle.

## Completion

A behaviour is done when its failing test went red, then green, and the agreed seam still holds.
