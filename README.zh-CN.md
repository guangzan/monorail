# Rail Skills

[English](README.md) | 中文

本地优先的 Agent Skills，对应清晰的工程流程：**对齐 → 规格 → 切片 → 构建**。所有 rail 文档（工作产物、术语表、ADR）统一放在 `docs/monorail/` 下——不依赖 GitHub/GitLab Issues。

## 安装

通过 [skills.sh](https://skills.sh) / [Skills CLI](https://github.com/vercel-labs/skills)：

```bash
npx skills add guangzan/monorail
```

在业务仓库中，先运行一次 `/rail-setup`，再使用其他 rail 工程 skills。

## 主链路

```text
/rail-align ─┬─ light ──→ align.md  ══╗
             └─ map   ──→ decisions* ═╩══→ /rail-spec ══→ spec.md ═✳→ /rail-slice ──→ /rail-build*
```

`══→` 表示同会话自动续跑（规划链）。`✳` 表示**去留确认（go/no-go）**：写完 `spec.md` 后 `/rail-spec` 停下问一次——**继续**同会话切片、**改** spec、或**先停**（`spec.md` 已落盘，之后手动跑 `/rail-slice` 即可）。`*` 表示下一步**用户手动触发**——`/rail-build` 在同一会话里**串行跑** frontier tasks（非平凡 task 派发全新 implementer 子代理，无需新会话）。并发多张时必须 **一 task 一 git worktree**（禁止同一 cwd 并行）。没有 `align.md` 或未清完 map 时，`/rail-spec` 会拒绝写入。

## Skills

### 主链路

| Skill                                      | 作用                                                              |
| ------------------------------------------ | ----------------------------------------------------------------- |
| [`rail-setup`](skills/rail-setup/SKILL.md) | 配置：所有 rail 文档统一在 `docs/monorail/`                       |
| [`rail-align`](skills/rail-align/SKILL.md) | 对齐需求（light → `align.md`；或 map 模式）                       |
| [`rail-spec`](skills/rail-spec/SKILL.md)   | 从 `align.md` / 已清完的 map 写 `spec.md`；写完停下待你确认再切片 |
| [`rail-slice`](skills/rail-slice/SKILL.md) | 将 `spec.md` 拆成带 blockers 的 `tasks/NN-*.md`                   |
| [`rail-build`](skills/rail-build/SKILL.md) | 同会话串行实现 tasks（并发须 worktree）                           |

### 旁路与辅助

| Skill                                        | 作用                                         |
| -------------------------------------------- | -------------------------------------------- |
| [`rail`](skills/rail/SKILL.md)               | 路由 — 选哪个 skill/流程                     |
| [`rail-grill`](skills/rail-grill/SKILL.md)   | 无状态拷问                                   |
| [`rail-pass`](skills/rail-pass/SKILL.md)     | 跨会话接力文档（`pass-*.md`）                |
| [`rail-debug`](skills/rail-debug/SKILL.md)   | 疑难 bug 诊断循环                            |
| [`rail-review`](skills/rail-review/SKILL.md) | Standards + Spec 审查（按需；不在 build 内） |

### 底层能力

| Skill                                  | 作用                                   |
| -------------------------------------- | -------------------------------------- |
| [`rail-tdd`](skills/rail-tdd/SKILL.md) | Red-green-refactor（build 内也会用到） |

## 致谢

灵感与参考来自 [mattpocock/skills](https://github.com/mattpocock/skills)。
