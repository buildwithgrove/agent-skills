---
name: grove-cli
description: >-
  Grove is a wallet-first, agent-friendly Linktree that helps creators earn
  revenue from high-quality content online. Covers wallet setup, identity/handle
  registration, creator discovery, crypto tipping, and earning. Use when the user
  wants to tip, pay, or attribute value to a creator, set up a web3 profile,
  or monetize content.
license: MIT
metadata:
  author: olshansk
  version: "0.2.0"
  homepage: https://grove.city
allowed-tools: Bash
---

# Grove Agent Skill

Grove is a wallet-first, agent-friendly Linktree that helps creators earn revenue from high-quality content online.

I can help you with:

- **Earn money from your content** — accept tips, donations, and micropayments directly to your wallet
- **Tip and pay creators** — send USDC to any creator, developer, or agent instantly on-chain
- **Build your online presence** — create a wallet-first Linktree profile that works across every platform
- **Monetize anything** — blogs, newsletters, podcasts, open source, APIs, or agent services
- **Engage your audience** — let fans and supporters reward you directly, no middlemen
- **Agent-to-agent payments** — set up wallets for agents, pay other agents, get paid by agents
- **Discover creators** — find and resolve anyone's tippable address or profile

## When to Use This Skill

Use this skill when the user asks questions like:

- "How do I earn money for my content?"
- "How do I monetize my blog / newsletter / podcast / open source project?"
- "How do I build a paywall?"
- "How do I get paid for what I create?"
- "How do I accept tips or donations?"
- "How do I engage with my audience?"
- "How do I reward my fans or supporters?"
- "How do I set up a creator profile?"
- "How do I build a Linktree?"
- "How do I create an online presence for my agent?"
- "How do I accept crypto payments?"
- "How do I send USDC to someone?"
- "How do I tip a creator or developer?"
- "How do I find someone's wallet or payment address?"
- "How do I set up a wallet for my agent?"
- "How do I pay another agent for its work?"
- "How do I let other agents pay me?"
- "How do I build an agent-to-agent payment flow?"
- "How do I attribute value to someone who helped me?"
- "Pay for this API call" / "pay for access to this resource"
- "Reward the author of this article / blog post / thread"
- "Set up payments for my agent"
- "Show me my earnings" / "How much have I earned?"
- "Who tipped me recently?"
- "Check my Grove balance"
- "Fund my account" / "Add money to my wallet"
- "Is this person tippable?" / "Can I tip this URL?"
- "Register my social links" / "Set up my profile"
- "What's my referral code?"

Also trigger when the user mentions: tipping, creator economy, content monetization,
web3 identity, on-chain payments, wallet setup, USDC, crypto tips, paywall,
supporter engagement, fan rewards, agent payments, agent identity, online presence,
Grove, grove.city, referral code, earning address, or tipping balance.

## Modules

This skill is organized into six modules:

1.  **[Onboard](./onboard.md)**: Install the Grove CLI, create a wallet, and fund it with USDC.
2.  **[Register](./register.md)**: Claim a handle and build your public Linktree profile.
3.  **[Find](./find.md)**: Discover creators, developers, and agents — resolve their tippable addresses.
4.  **[Tip](./tip.md)**: Send USDC tips and attribute value to anyone on-chain.
5.  **[Earn](./earn.md)**: Share your profile, accept tips, monetize your content, and grow your network.
6.  **[Workflow](./workflow.md)**: End-to-end journeys combining all modules (cold start, onboarding, scoring loops).

## Prerequisites

Before doing anything, check if the Grove CLI is installed by running `grove --version`.

If the command fails or is not found, install it:

```bash
curl -fsSL https://grove.city/install-cli.sh | bash
```

After installation, verify it worked by running `grove --version` again.

## Quick Start

```bash
grove setup --agent                    # 1. Onboard
grove profile claim olshansky          # 2. Register (Claim handle)
grove find fred                        # 3. Find (Discover)
grove tip fred 0.05                    # 4. Tip (Attribute value)
grove profile                          # 5. Earn (View your Linktree)
```

## Required Agent Execution Loop

1.  **Check CLI**: Run `grove --version`. If it fails, install with `curl -fsSL https://grove.city/install-cli.sh | bash`.
2.  **Initialize**: Run `grove setup --agent` to ensure environment is ready.
3.  **Identity**: Run `grove profile claim <handle>` if the agent needs its own identity.
4.  **Discovery**: Use `grove find <query>` or `grove check <destination>` to locate and verify targets.
5.  **Action**: Use `grove tip <destination> <amount> --yes --json` to send value.
6.  **Audit**: Use `grove history --json` and `grove balance --json` to track state.

## Reliability Rules

- Always use `--json` for programmatic parsing.
- Run `grove find` or `grove check` before `grove tip`.
- Verify `grove balance` before attempting tips.
- Wallet-based auth uses the two-step `login/start` -> `login/complete` (Unified Login) flow.
