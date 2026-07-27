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
- Do **not** write any `docs/monorail/` files (including `CONTEXT.md` / ADRs) — no codebase / intentionally stateless
- Do **not** implement code

## Completion

When every decision-tree branch is resolved:

1. **Output the plan** — a concise synthesis of decisions (goals, scope, key choices, out-of-scope). Do **not** ask the user to confirm "is this the full scope?" or re-gate on shared understanding; the interview already did that work.
2. **Ask only** whether to start implementation, or if anything still needs adjusting. Wait for that answer.
3. Do **not** implement code from this skill. If they want to proceed and a repo exists, suggest (do not invoke) `/rail-setup` then `/rail-align` when unset up, or `/rail-align` when already set up — so alignment lands in the repo before `/rail-spec`. Never jump straight to `/rail-spec` after a stateless grill.
