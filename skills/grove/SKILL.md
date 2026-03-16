---
name: grove
description: Agent-first Grove CLI skill for identity, discovery, and value exchange.
license: MIT
metadata:
  author: olshansk
  version: "4.0.0"
  homepage: https://grove.city
allowed-tools: Bash
---

# Grove Agent Skill

Grove is an agent-first identity and value layer. Use this skill to onboard agents, build public profiles (Linktree), discover creators, and exchange value (tipping/earning).

## Modules

This skill is organized into five high-signal modules:

1.  **[Onboard](./onboard.md)**: Setup the Grove CLI and environment.
2.  **[Register](./register.md)**: Claim a handle and build a wallet-first Linktree.
3.  **[Find](./find.md)**: Discover creators and resolve destinations.
4.  **[Tip](./tip.md)**: Attribute and send value to others.
5.  **[Earn](./earn.md)**: Share your profile and get tipped by others.

## Quick Start

```bash
grove setup --agent                    # 1. Onboard
grove profile claim alice              # 2. Register (Claim handle)
grove find bob.eth                     # 3. Find (Discover)
grove tip bob.eth 0.05                 # 4. Tip (Attribute value)
grove profile                          # 5. Earn (View your Linktree)
```

## Required Agent Execution Loop

1.  **Initialize**: Run `grove setup --agent` to ensure environment is ready.
2.  **Identity**: Run `grove profile claim <handle>` if the agent needs its own identity.
3.  **Discovery**: Use `grove find <query>` to locate targets.
4.  **Action**: Use `grove tip <destination> <amount>` to send value.
5.  **Audit**: Use `grove history` and `grove balance` to track state.

## Reliability Rules

-   Always use `--json` for programmatic parsing.
-   Run `grove find` or `grove check` before `grove tip`.
-   Verify `grove balance` before attempting tips.
