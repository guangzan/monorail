---
"monorail": minor
---

`/rail-spec` now treats the test-seam decision as an explicit blocking gate before writing `spec.md`: it asks with the standard A/B question format, waits for confirmation, and only then writes `## Testing Decisions`. The post-spec slice go/no-go restates the confirmed seam and never asks it again.
