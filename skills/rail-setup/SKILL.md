---
name: rail-setup
description: Configure a repo for rail skills — local docs/monorail tracker and domain doc layout. Run once per repo before other rail engineering skills.
disable-model-invocation: true
---

# Rail Setup

Scaffold per-repo configuration that rail engineering skills assume:

- **Work tracker** — always local markdown under `docs/monorail/` (no remote tracker choice)
- **Domain docs** — where `CONTEXT.md` and ADRs live

This is prompt-driven, not a deterministic script. Explore, present, confirm, then write.

## Process

### 1. Explore

Read what exists; do not assume:

- `AGENTS.md` / `CLAUDE.md` — either present? Already has `## Agent skills`?
- `CONTEXT.md`, `CONTEXT-MAP.md`, `docs/adr/`
- `docs/agents/` — prior rail-setup output?
- `docs/monorail/` — already in use?
- Monorepo signals (`pnpm-workspace.yaml`, package `workspaces`, populated `packages/*`)

### 2. Present and confirm

Summarise present vs missing. Then:

**Work tracker** — state that rail uses `docs/monorail/` only. Show the template at `templates/work-tracker.md` (relative to this skill). Confirm path wording only if the user wants a non-default root (default: `docs/monorail/`). If they insist on a remote tracker, refuse for rail skills and stop — rail v1 is local-only.

**Domain docs** — default single-context (`CONTEXT.md` + `docs/adr/`). Offer multi-context only when exploration found monorepo signals.

### 3. Confirm draft

Show drafts of:

- `## Agent skills` block for `CLAUDE.md` or `AGENTS.md`
- `docs/agents/work-tracker.md` (from template, path adjusted if needed)
- `docs/agents/domain.md` (from template)

Let the user edit before writing.

### 4. Write

**Pick file for Agent skills block:**

- If `CLAUDE.md` exists, edit it
- Else if `AGENTS.md` exists, edit it
- If neither exists, ask which to create — do not pick for them
- Never create both

**Agent skills block** (adapt if work root changed) — include these bullets verbatim in the target file:

- Heading: `## Agent skills`
- Line: This repo uses **rail** skills. Work artifacts live under `docs/monorail/`.
- Bullet: Work tracker: `docs/agents/work-tracker.md`
- Bullet: Domain docs: `docs/agents/domain.md`
- Line: Run `/rail-setup` again only if these conventions change. Prefer `/rail` to see the main flow.

Write `docs/agents/work-tracker.md` and `docs/agents/domain.md` from the templates in this skill folder.

### Completion

Done when both agent docs exist, the Agent skills block is present, and you told the user they can start with `/rail-align` or `/rail`.
