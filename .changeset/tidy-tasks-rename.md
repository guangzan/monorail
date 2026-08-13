---
"monorail": minor
---

Implementation units are renamed from **issue** to **task**: the directory is now `docs/monorail/<feature>/tasks/NN-*.md` (was `issues/`), and all skill docs, templates, and READMEs use "task" for implementation work. "Ticket" stays reserved for `/rail-align` decision/research/prototype units; loose "ticket" references to implementation units were cleaned up. Task status values (`open | claimed | done`) are unchanged.

**Migration for existing projects:** rename the old directory per feature, e.g. `git mv docs/monorail/<feature>/issues docs/monorail/<feature>/tasks`. File contents need no edits. No backward-compat lookup is provided — the new path is canonical.
