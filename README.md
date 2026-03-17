# grove-agent-skills <!-- omit in toc -->

[![Claude Code](https://img.shields.io/badge/Claude%20Code-D27656)](#)
[![Codex CLI](https://img.shields.io/badge/Codex%20CLI-00A67E)](#)
[![Gemini CLI](https://img.shields.io/badge/Gemini%20CLI-678AE3)](#)
[![OpenCode](https://img.shields.io/badge/OpenCode-3B82F6)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

> Agent skills for the [Grove](https://grove.city) identity and value layer.

## What is this? <!-- omit in toc -->

- Agent skills for the [Grove](https://grove.city) identity and value layer
- Follows the [Agent Skills](https://agentskills.io/home) pattern for cross-tool skill distribution
- Inspired by [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills)
- Published on [skills.sh](https://skills.sh)

## Table of Contents <!-- omit in toc -->

- [Quickstart](#quickstart)
- [Available Skills](#available-skills)
- [Skill Modules](#skill-modules)

## Quickstart

```bash
npx skills add buildwithgrove/agent-skills
```

Then ask your agent:

- _"setup grove"_
- _"can I tip fred?"_
- _"I love olshansky's content, tip him"_

## Available Skills

| Skill | What it does | Trigger examples |
| ----- | ------------ | ---------------- |
| [`grove`](skills/grove/SKILL.md) | Agent-first identity, discovery, and value exchange via Grove CLI | "setup grove", "does arthur have a tippable address?", "tip olshansky" |

## Skill Modules

The grove skill is organized into five modules:

1. **[Onboard](skills/grove/onboard.md)** - Setup the Grove CLI and environment
2. **[Register](skills/grove/register.md)** - Claim a handle and build a wallet-first Linktree
3. **[Find](skills/grove/find.md)** - Discover creators and resolve destinations
4. **[Tip](skills/grove/tip.md)** - Attribute and send value to others
5. **[Earn](skills/grove/earn.md)** - Share your profile and get tipped by others
