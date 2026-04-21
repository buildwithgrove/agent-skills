# grove-agent-skills <!-- omit in toc -->

[![Claude Code](https://img.shields.io/badge/Claude%20Code-D27656)](#)
[![Codex CLI](https://img.shields.io/badge/Codex%20CLI-00A67E)](#)
[![Gemini CLI](https://img.shields.io/badge/Gemini%20CLI-678AE3)](#)
[![OpenCode](https://img.shields.io/badge/OpenCode-3B82F6)](#)
[![License: MIT-0](https://img.shields.io/badge/License-MIT--0-red.svg)](https://opensource.org/licenses/MIT-0)

> Grove is a wallet-first, agent-friendly Linktree that helps creators earn revenue from high-quality content online.

## What is this? <!-- omit in toc -->

- Agent skills for [Grove](https://grove.city) — a wallet-first, agent-friendly Linktree with payments
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

The grove skill is organized into eight modules:

1. **[Onboard](skills/grove/onboard.md)** - Setup the Grove CLI and environment
2. **[Register](skills/grove/register.md)** - Claim a handle and build a wallet-first Linktree
3. **[Find](skills/grove/find.md)** - Discover creators and resolve destinations
4. **[Tip](skills/grove/tip.md)** - Attribute and send value to others
5. **[Earn](skills/grove/earn.md)** - Share your profile and get tipped by others
6. **[Message](skills/grove/message.md)** - Send paid messages (Tip to Talk)
7. **[Feed](skills/grove/feed.md)** - Discover content across platforms
8. **[Workflow](skills/grove/workflow.md)** - End-to-end journeys (cold start, onboarding, scoring loops)

## API Coverage Gaps

Features the API supports but skills don't yet cover:

| Feature | API Scope | Priority | Status |
|---------|-----------|----------|--------|
| Giveaways | Full CRUD, entries, drawing winners | High | TODO |
| Leaderboard | Tippers, tippees, funders, ranks, timeseries | High | TODO |
| Creator Search | `GET /v1/creators/search` (added 4/14) | Medium | TODO |
| Onramp/Offramp | Coinbase hosted URL, Apple Pay, crypto withdrawal | Medium | TODO |
| Referrals API | `/v1/referrals`, `/v1/referrals/earnings` | Medium | TODO |
| Earnings API | `/v1/account/earnings/daily,summary,tips` + public endpoints | Medium | TODO |
| Feed Items API | `/v1/feed/items` with tags, sorting, filtering | Medium | TODO |
| Rich Profiles | `/full`, `/supporters`, `/top-content`, `/avatars` | Low-medium | TODO |
| Social OAuth | Full OAuth flows for 6 platforms | Low | TODO |

### Recent API Changes Not Yet Reflected

- Bluesky demoted to manual-only verification (4/15)
- Leaderboard defaults to aggregate-by-account (4/14)
- Feed items now include `creator_avatar_url` + `creator_handle` (4/14)
- Tip context now returns sender/recipient Grove handles (4/16)
- Creator search with featured fallback (4/14)
