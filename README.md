# Rail Skills

English | [中文](README.zh-CN.md)

Local-first Agent Skills for a clear engineering flow: **align → spec → slice → build**. All rail docs (work artifacts, glossary, ADRs) live under `docs/monorail/` — no GitHub/GitLab Issues dependency.

## Install

Via [skills.sh](https://skills.sh) / the [Skills CLI](https://github.com/vercel-labs/skills):

```bash
npx skills add guangzan/monorail
```

In each business repo, run `/rail-setup` once before other rail engineering skills.

## Main chain

```text
/rail-align ─┬─ light ──→ align.md  ══╗
             └─ map   ──→ decisions* ═╩══→ /rail-spec ══→ /rail-slice ──→ /rail-build*
```

`══→` auto-continues in the same session (planning chain). `*` / `──→` may need a fresh session. Each `/rail-build` takes one unblocked issue. Concurrent builds require **one git worktree per issue** (same cwd is forbidden). `/rail-spec` refuses to write without `align.md` or a cleared map.

## Skills

### Main chain

| Skill                                      | Role                                                |
| ------------------------------------------ | --------------------------------------------------- |
| [`rail-setup`](skills/rail-setup/SKILL.md) | Configure all rail docs under `docs/monorail/`      |
| [`rail-align`](skills/rail-align/SKILL.md) | Align (light → `align.md`; or map mode)             |
| [`rail-spec`](skills/rail-spec/SKILL.md)   | Write `spec.md` from `align.md` / cleared map       |
| [`rail-slice`](skills/rail-slice/SKILL.md) | Break `spec.md` into `issues/NN-*.md` with blockers |
| [`rail-build`](skills/rail-build/SKILL.md) | Implement one issue (parallel ⇒ worktrees)          |

### Side paths & helpers

| Skill                                        | Role                                                |
| -------------------------------------------- | --------------------------------------------------- |
| [`rail`](skills/rail/SKILL.md)               | Router — which skill/flow fits                      |
| [`rail-grill`](skills/rail-grill/SKILL.md)   | Stateless grilling                                  |
| [`rail-pass`](skills/rail-pass/SKILL.md)     | Cross-session pass document                         |
| [`rail-debug`](skills/rail-debug/SKILL.md)   | Hard-bug diagnosis loop                             |
| [`rail-review`](skills/rail-review/SKILL.md) | Standards + Spec review (opt-in; not part of build) |

### Vocabulary

| Skill                                  | Role                                        |
| -------------------------------------- | ------------------------------------------- |
| [`rail-tdd`](skills/rail-tdd/SKILL.md) | Red-green-refactor (also used inside build) |

## Acknowledgments

Ideas and inspiration from [mattpocock/skills](https://github.com/mattpocock/skills).
