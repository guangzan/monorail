---
'monorail': patch
---

`/rail-setup` 不再询问创建 `AGENTS.md` 还是 `CLAUDE.md`：两个文件都不存在时直接创建 `AGENTS.md`；两者同时存在时优先写入 `AGENTS.md`；仅存在 `CLAUDE.md` 时继续编辑它；任一文件已有 `## Agent skills` 块时不再重复写入。
