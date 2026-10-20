# Work tracker: Local Markdown (rail)

All rail docs for this repo live under `docs/monorail/` — work artifacts, domain glossary/ADRs, and these convention files. Do not scatter to the repo root, `docs/agents/`, or `docs/adr/`.

## Layout

```
docs/monorail/
  CONTEXT.md              # glossary (see domain.md)
  CONTEXT-MAP.md          # multi-context only
  adr/                    # ADRs
  work-tracker.md         # this file
  domain.md               # domain doc conventions
  <feature-slug>/         # one effort per directory
```

**Reserved names** (not feature slugs): `CONTEXT.md`, `CONTEXT-MAP.md`, `adr`, `work-tracker.md`, `domain.md`.

## Reading and listing

Decide whether a rail doc exists — and list `docs/monorail/` contents — with the shell (`ls` / `test -f`, or reading the path directly). Search tools skip gitignored paths, so an empty Glob/Grep result is **not** evidence a file is missing.

## Feature conventions

- One feature/effort per directory: `docs/monorail/<feature-slug>/`
- **Slug naming**: a user-named slug is used as-is (no prefix); an agent-invented slug is `YYYY-MM-DD-NN-<kebab>` (`NN` = the day's global sequence `01`, `02`, … — count today's existing date-prefixed effort dirs + 1). The date prefix sorts efforts chronologically and prevents collisions
- Align output: `docs/monorail/<feature-slug>/align.md` — required before `/rail-spec`
- Session pass (optional): `docs/monorail/<feature-slug>/pass-<date>.md` — from `/rail-pass`
- Spec: `docs/monorail/<feature-slug>/spec.md`
- Implementation tasks: `docs/monorail/<feature-slug>/tasks/<NN>-<slug>.md`, numbered from `01`
  - Each task file carries `Seams:` (the code-anchored seams from the spec's `## Testing Decisions` that apply to that task) and optional `Touchpoints:` (files it will touch); `/rail-build` consumes both (see `/rail-slice`, `/rail-build`)
- Keep align, spec, and tasks under the **same** `<feature-slug>` for one effort (planning chain stays in that directory)
- **New** `/rail-align` always opens a **new** `<feature-slug>/` — never ask the user for the slug; never write into another effort's directory (link prior aligns from Domain pointers if needed)
- Triage/status is a `Status:` line near the top of each ticket file
- Implementation task status: `open` | `claimed` | `done` (`done` implies a `## Comments` done-gate block — see `/rail-build`)
- Comments append under a `## Comments` heading

## When a skill says "publish to the work tracker"

Create or update files under `docs/monorail/<feature-slug>/` (create the directory if needed). Never use GitHub Issues, GitLab Issues, or other remote trackers for rail work.

## When a skill says "fetch the ticket"

Read the file at the given path. The user normally passes the path or task number.

## Frontier

- **Implementation tasks:** `Status: open`, every `Blocked by` target is `Status: done`, not yet `claimed`; lowest `NN` wins
- **Serial `/rail-build`:** tasks run **sequentially in one session by default** (claim each first; one worktree, no parallel writers); start in a fresh session when the planning context is already heavy — see `/rail-build`
- **Parallel `/rail-build`:** only on distinct frontier tasks; **one git worktree per task** (claim on the primary worktree first). Same working tree must not run two builds at once — see `/rail-build` Parallel builds

## Adequacy for `/rail-spec`

`/rail-spec` may write `spec.md` only when at least one of these holds for the slug:

- `align.md` exists (from `/rail-align`)

`docs/monorail/CONTEXT.md` / ADRs alone are not enough. Handoff files enrich but do not replace `align.md`.
