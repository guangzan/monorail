# Rail Skills

English | [中文](README.zh-CN.md)

Local-first Agent Skills for a clear engineering flow: **align → spec → slice → build**. Work artifacts live as markdown under `docs/monorail/` — no GitHub/GitLab Issues dependency.

## Install

Via [skills.sh](https://skills.sh) / the [Skills CLI](https://github.com/vercel-labs/skills):

```bash
npx skills add guangzan/monorail
```

In each business repo, run `/rail-setup` once before other rail engineering skills.

## Main chain

```text
/rail-align ── light ──→ align.md ──→ /rail-spec → /rail-slice → /rail-build*
              └─ map ──→ decisions* ─┘
```

`*` may span sessions. Each `/rail-build` takes one unblocked issue. `/rail-spec` refuses to write without `align.md` or a cleared map.

## Skills

### User-invoked

| Skill                                          | Role                                                |
| ---------------------------------------------- | --------------------------------------------------- |
| [`rail`](skills/rail/SKILL.md)                 | Router — which skill/flow fits                      |
| [`rail-setup`](skills/rail-setup/SKILL.md)     | Configure local `docs/monorail/` + domain docs          |
| [`rail-align`](skills/rail-align/SKILL.md)     | Align (light → `align.md`; or map mode)             |
| [`rail-grill`](skills/rail-grill/SKILL.md)     | Stateless grilling (no codebase)                    |
| [`rail-spec`](skills/rail-spec/SKILL.md)       | Write `spec.md` from `align.md` / cleared map       |
| [`rail-slice`](skills/rail-slice/SKILL.md)     | Break `spec.md` into `issues/NN-*.md` with blockers |
| [`rail-build`](skills/rail-build/SKILL.md)     | Implement one issue                                 |
| [`rail-pass`](skills/rail-pass/SKILL.md)       | Cross-session pass document                         |

### Model-invoked

| Skill                                            | Role                    |
| ------------------------------------------------ | ----------------------- |
| [`rail-tdd`](skills/rail-tdd/SKILL.md)           | Red-green-refactor      |
| [`rail-review`](skills/rail-review/SKILL.md)     | Standards + Spec review |
| [`rail-debug`](skills/rail-debug/SKILL.md)       | Hard-bug diagnosis loop |

## Acknowledgments

Ideas and inspiration from [mattpocock/skills](https://github.com/mattpocock/skills).
