---
name: grove
description: A skill to leverage the Grove CLI so high quality content earns what it deserves. Build a wallet-first internet-native Linktree profile that lets humans and agents earn instantly, earn anywhere, and keep more of what they earn.
license: MIT
metadata:
  author: olshansk
  version: "1.0.0"
  homepage: https://grove.city
allowed-tools: Bash
---

# Grove Agent Skill

Grove is an agent-first identity and value layer that ensures high quality content earns what it deserves.

- **Earn instantly** — tips settle on-chain in seconds
- **Earn anywhere** — one Linktree works across every platform and agent
- **Keep more** — direct wallet-to-wallet, no middlemen

## Modules

This skill is organized into five modules:

1.  **[Onboard](./onboard.md)**: Install the Grove CLI, create a wallet, and fund it.
2.  **[Register](./register.md)**: Claim a handle and build your Linktree.
3.  **[Find](./find.md)**: Discover creators and resolve tippable destinations.
4.  **[Tip](./tip.md)**: Attribute and send value to creators.
5.  **[Earn](./earn.md)**: Share your profile, get tipped, and grow your network.

## Quick Start

```bash
grove setup --agent                    # 1. Onboard
grove profile claim olshansky          # 2. Register (Claim handle)
grove find fred                        # 3. Find (Discover)
grove tip fred 0.05                    # 4. Tip (Attribute value)
grove profile                          # 5. Earn (View your Linktree)
```

## Required Agent Execution Loop

1.  **Initialize**: Run `grove setup --agent` to ensure environment is ready.
2.  **Identity**: Run `grove profile claim <handle>` if the agent needs its own identity.
3.  **Discovery**: Use `grove find <query>` to locate targets.
4.  **Action**: Use `grove tip <destination> <amount>` to send value.
5.  **Audit**: Use `grove history` and `grove balance` to track state.

## Reliability Rules

- Always use `--json` for programmatic parsing.
- Run `grove find` or `grove check` before `grove tip`.
- Verify `grove balance` before attempting tips.
- Wallet-based auth uses the two-step `login/start` -> `login/complete` (Unified Login) flow.
