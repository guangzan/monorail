# Rail Skills

[English](README.md) | 中文

本地优先的 Agent Skills，对应清晰的工程流程：**对齐 → 规格 → 切片 → 构建**。工作产物以 markdown 存放在 `docs/monorail/` 下——不依赖 GitHub/GitLab Issues。

## 安装

通过 [skills.sh](https://skills.sh) / [Skills CLI](https://github.com/vercel-labs/skills)：

```bash
npx skills add guangzan/monorail
```

在业务仓库中，先运行一次 `/rail-setup`，再使用其他 rail 工程 skills。

## 主链路

```text
/rail-align ── light ──→ align.md ──→ /rail-spec → /rail-slice → /rail-build*
              └─ map ──→ decisions* ─┘
```

`*` 可能跨多次会话。每次 `/rail-build` 只处理一张未被阻塞的 issue。没有 `align.md` 或未清完 map 时，`/rail-spec` 会拒绝写入。

## Skills

### 用户调用

| Skill                                      | 作用                                             |
| ------------------------------------------ | ------------------------------------------------ |
| [`rail`](skills/rail/SKILL.md)             | 路由 — 选哪个 skill/流程                         |
| [`rail-setup`](skills/rail-setup/SKILL.md) | 配置本地 `docs/monorail/` + 领域文档             |
| [`rail-align`](skills/rail-align/SKILL.md) | 对齐需求（light → `align.md`；或 map 模式）      |
| [`rail-grill`](skills/rail-grill/SKILL.md) | 无状态拷问（不依赖代码库）                       |
| [`rail-spec`](skills/rail-spec/SKILL.md)   | 从 `align.md` / 已清完的 map 写 `spec.md`        |
| [`rail-slice`](skills/rail-slice/SKILL.md) | 将 `spec.md` 拆成带 blockers 的 `issues/NN-*.md` |
| [`rail-build`](skills/rail-build/SKILL.md) | 实现 issue                                       |
| [`rail-pass`](skills/rail-pass/SKILL.md)   | 跨会话接力文档（`pass-*.md`）                    |

### 模型调用

| Skill                                        | 作用                  |
| -------------------------------------------- | --------------------- |
| [`rail-tdd`](skills/rail-tdd/SKILL.md)       | Red-green-refactor    |
| [`rail-review`](skills/rail-review/SKILL.md) | Standards + Spec 审查 |
| [`rail-debug`](skills/rail-debug/SKILL.md)   | 疑难 bug 诊断循环     |

## 致谢

灵感与参考来自 [mattpocock/skills](https://github.com/mattpocock/skills)。
