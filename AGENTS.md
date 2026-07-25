# Rail skills pack

- Skills live flat under `skills/<name>/` with `SKILL.md` + `agents/openai.yaml`
- Adding/renaming/removing a user-reachable skill **requires** updating `skills/rail/SKILL.md` and `README.md` in the same change
- User-visible changes (skill add/rename/remove or flow change) **require** a changeset (`.changeset/*.md`) in the same change
- Run `scripts/validate-skills.sh` before committing skill changes
- Upstream reference clone: `.repos/skills` (gitignored) — copy ideas only
