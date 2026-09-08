---
'monorail': minor
---

`/rail-spec` no longer auto-continues into `/rail-slice`. After writing `spec.md` it stops and asks once — **continue** slicing in the same session, **revise** the spec, or **pause** (`spec.md` stays durable; `/rail-slice` resumes it later). The planning chain still auto-continues `align → spec`; only the `spec → slice` boundary is now a go/no-go.
