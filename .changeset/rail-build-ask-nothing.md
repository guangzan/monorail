---
"monorail": patch
---

`/rail-build` never asks about run length or commit policy — defaults are a queue-clear serial run with **one commit per task**; user deviations ("review pause", "don't commit", narrower run) are honored from the command, never prompted. Seam/contradiction divergences now stop and report (§4) instead of raising a question.