---
name: rail-slice
description: Break an existing docs/monorail/<feature>/spec.md into tracer-bullet tasks under tasks/, each with Blocked by edges. Ends the planning chain — next step is user-triggered `/rail-build <feature-slug>` (same-session serial default; open a fresh session when context is heavy).
disable-model-invocation: true
---

# Rail Slice

Break an existing **spec** into **implementation** tasks — vertical tracer bullets with blocking edges. Local files only.

Confirm with the shell before concluding it is missing (`ls docs/monorail/work-tracker.md`, or read the path directly) — search tools skip gitignored paths, so an empty Glob/Grep result is **not** evidence of absence. If it is missing on disk, tell the user to run `/rail-setup` and stop.

## Process

### 1. Gather context

Require an existing `docs/monorail/<feature-slug>/spec.md`. Confirm it with the shell (`ls <path>`, or read it) before concluding it is missing — search tools skip gitignored paths, so an empty Glob/Grep result is **not** evidence of absence. If it is missing on disk, stop and suggest `/rail-spec` — do not slice from conversation alone.

If `spec.md` exists but there is no `align.md` for the same slug, warn that the spec may be unanchored and ask whether to proceed or return to `/rail-align` — do not silently treat a hollow chain as fine.

Derive `<feature-slug>` from the spec path (or, when the shell listing of `docs/monorail/` shows exactly one effort holding a `spec.md`, from that). Do not invent a parallel slug. Read the spec fully; use conversation only to enrich tasks.

### 2. Explore (optional)

Prefer domain vocabulary. Prefactor opportunities: "make the change easy, then make the easy change."

### 3. Draft vertical slices

Rules:

- Each slice is a narrow **complete** path through layers (not horizontal one-layer work)
- Demoable or verifiable alone
- Fits one fresh context window
- Prefactors first
- Wide mechanical refactors: expand → migrate batches → contract (not forced into one tracer bullet)

Give each task blocking edges.

### 4. Ask only on real trade-offs

Humans adjudicate **trade-offs**, not obviously correct slices.

- **No fork → publish.** If the draft has no meaningful alternative you would actually recommend (typical: one narrow task, `Blocked by: None`; or a clear linear chain with obvious order), **do not** quiz. Do **not** invent A/B/C options or ask "approve this list?". Go to Publish.
- **Real fork → ask only that fork.** Quiz when merge vs split, blocker order, or "is this prefactor its own task?" has real session-fit / risk trade-offs. Present the contested choice (and your recommendation); iterate until resolved. Do not pad with ceremonial whole-list approval.
- **User hold → wait.** If the user asked to review the draft first or not write yet, present Title / Blocked by / What it delivers and wait — do not publish.

### 5. Publish

Write one file per task at `docs/monorail/<feature-slug>/tasks/<NN>-<slug>.md` (same directory as `spec.md`), numbered from `01`, blockers first. Never a single combined tasks file.

Each task file must include:

- Title line: `# NN — <Task title>`
- `Status: open`
- `Blocked by: None` or `Blocked by: NN, NN`
- `Seams:` — the code-anchored seams from the spec's `## Testing Decisions` that apply to **this** task, each with the file/test pointer that anchors it. This is how the spec's single seam decision reaches the implementer — never leave the seam derivation to be re-done in the build session
- `Touchpoints:` (recommended) — the concrete files/paths this task will touch, so `/rail-build`'s file-map pre-flight derives ownership from the tasks instead of re-scanning
- `## What to build` — end-to-end behaviour from the user perspective
- `## Acceptance criteria` — checklist items

`Blocked by` lists `NN` numbers/titles or `None`.

**Story-coverage check (before publish):** every numbered `## User Stories` entry in `spec.md` maps to at least one task (or is explicitly out of scope). List any uncovered story as a warning in the completion message — do not silently drop a story.

### Completion

Files written. Emit the completion message with this **hard template** — field names and order are fixed; omit optional sections only when their condition is false. Do **not** auto-continue into `/rail-build`. Do **not** suggest `/implement`, `/triage`, or other foreign-pack equivalents.

```
**描述**
<1–2 sentence effort summary, ~30–80 Chinese characters, compressed from the spec opening / Problem→Solution>

**已发布**
<feature-slug>
- [align.md](docs/monorail/<feature-slug>/align.md)
- [spec.md](docs/monorail/<feature-slug>/spec.md)
- [tasks/<NN>-<task-slug>.md](docs/monorail/<feature-slug>/tasks/<NN>-<task-slug>.md)
  - Title: <task title>
  - Status: open
  - Blocked by: None | NN, NN

**警告**
- <uncovered User Story>   # only when the story-coverage check found gaps

下一步：需要你手动触发 `/rail-build <feature-slug>`。上下文较重时可开新会话执行。
```

Rules for filling it:

- `**描述**` — compress the effort into 1–2 sentences (~30–80 Chinese characters) from the spec opening / Problem→Solution; do not paste the whole Problem section
- `**已发布**` — list the whole effort tree: `align.md` only if it exists on disk, then `spec.md`, then every `tasks/NN-*.md` just written
- keep the bare `<feature-slug>` line under `**已发布**`
- render each file as a markdown link whose **label** is the short name relative to the effort directory (`align.md`, `spec.md`, `tasks/<NN>-<task-slug>.md`) and whose **target** is the repo-relative path `docs/monorail/<feature-slug>/…`
- `align.md` / `spec.md` stay flat linked bullets (no nested metadata)
- each task path expands exactly three nested keys, in order: `Title:`, `Status:`, `Blocked by:`
- `**警告**` appears only when at least one numbered User Story is uncovered; otherwise omit the whole section
- the final line is exactly `下一步：需要你手动触发 `/rail-build <feature-slug>`。上下文较重时可开新会话执行。` — substitute the real slug; no serial/worktree/foreign-pack digressions here

Near context limits: stop and suggest `/rail-pass` instead of publishing a degraded slice set.
