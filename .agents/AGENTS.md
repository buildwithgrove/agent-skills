# AGENTS.md <!-- omit in toc -->

## Project Overview

Grove Agent Skills — installable skill modules that teach AI agents how to use the Grove platform (wallet setup, identity, tipping, earning, content discovery, paid messaging).

## Development

- **Skill source**: `skills/grove/` — each `.md` file is a module
- **Entry point**: `skills/grove/SKILL.md` — frontmatter + module index
- **Local API repo**: `/Users/olshansky/workspace/grove/grove_api` — check for new endpoints, breaking changes
- **Test**: `make test` to validate skill frontmatter
- **Link**: `make link-skills` to update symlinks into `~/.claude/skills/`

## Key Commands

```bash
make test          # Validate skill frontmatter
make link-skills   # Symlink skills to ~/.claude/skills/
```
