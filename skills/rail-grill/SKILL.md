---
name: rail-grill
description: Relentless interview to sharpen a plan or design when there is no codebase. Saves nothing locally.
disable-model-invocation: true
---

# Rail Grill

Interview the user relentlessly about every aspect of the plan until shared understanding. Walk each branch of the decision tree, resolving dependencies one by one. For each question, provide your recommended answer.

## Rules

- Ask **one question at a time**; wait for the answer before continuing
- Prefer multiple-choice when options are clear
- If a *fact* is findable in the environment, look it up — do not ask
- Decisions belong to the user — put each one to them
- Do **not** write `CONTEXT.md`, ADRs, or `docs/monorail/` files (no codebase / intentionally stateless)
- Do **not** implement code

## Completion

Stop when every decision-tree branch is resolved and the user confirms shared understanding. Suggest the human next step — do not invoke those skills yourself:

- Have a repo, not yet set up → `/rail-setup`, then `/rail-align`
- Have a repo, already set up → `/rail-align` (writes `align.md` / domain docs; required before `/rail-spec`)
- Do **not** jump straight to `/rail-spec` after a stateless grill — alignment must be persisted in the repo first
