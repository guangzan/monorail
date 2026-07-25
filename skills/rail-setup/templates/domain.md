# Domain docs (rail)

## Layout

Default: single-context

- Glossary: `CONTEXT.md` at the repo root
- ADRs: `docs/adr/`

If `CONTEXT-MAP.md` exists at the root, this repo is multi-context — follow the map for per-context `CONTEXT.md` and ADR paths.

## Consumer rules

- Prefer glossary terms from `CONTEXT.md` in specs, tickets, and code names
- Respect ADRs in the area you touch
- Creating/updating glossary terms and ADRs is an active discipline during `/rail-align` — do not invent conflicting terms silently
