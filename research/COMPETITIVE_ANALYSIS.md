# Competitive Analysis: Grove vs Agent Payment Platforms <!-- omit in toc -->

- [Platforms Analyzed](#platforms-analyzed)
- [Feature Matrix: Grove vs Competitors](#feature-matrix-grove-vs-competitors)
  - [Identity and Profile](#identity-and-profile)
  - [Payment UX](#payment-ux)
  - [Agent-Native Capabilities](#agent-native-capabilities)
  - [Discovery and Network](#discovery-and-network)
  - [Security and Trust](#security-and-trust)
  - [Developer and Integration](#developer-and-integration)
- [Platform Deep Dives](#platform-deep-dives)
  - [x402](#x402)
  - [MPP (Machine Payments Protocol)](#mpp-machine-payments-protocol)
  - [mppx](#mppx)
  - [Coinbase AgentKit](#coinbase-agentkit)
  - [AgentCash](#agentcash)
  - [OpenPayment](#openpayment)
  - [Stripe CLI (reference)](#stripe-cli-reference)
  - [Skyfire](#skyfire)
- [Where Grove Leads](#where-grove-leads)
- [Where Grove Needs to Catch Up](#where-grove-needs-to-catch-up)
- [Prioritized Gap Closure](#prioritized-gap-closure)
- [Links and Resources](#links-and-resources)

## Platforms Analyzed

| Platform | What it is | Focus | Maturity |
|----------|-----------|-------|----------|
| **x402** | HTTP 402 open payment protocol | Protocol standard for paywalled APIs | Spec + reference code |
| **MPP** | Machine Payments Protocol (Stripe/Tempo) | Multi-method 402 protocol (crypto + fiat + Lightning) | Launched Mar 18, 2026 |
| **mppx** | TypeScript SDK/CLI implementing MPP | "curl that pays" + proxy/gateway builder | 73 stars, active |
| **Coinbase AgentKit** | Wallet + action provider toolkit | Onchain agent actions, MCP extension | ~1.2k stars |
| **AgentCash** | CLI + skills for x402 paid endpoints | Fund wallet → access paid APIs | Skill registries |
| **OpenPayment** | USDC payment link creation via x402 | Lightweight "request money" primitive | Early |
| **Stripe CLI** | Traditional payments developer CLI | Webhooks, events, testing (reference UX) | ~1.9k stars, industry standard |
| **Skyfire** | AI agent payment network | Agent-to-agent payment routing | TBD |

## Feature Matrix: Grove vs Competitors

Legend: ✅ shipped, ◐ partial/planned, ❌ not available, — not applicable

### Identity and Profile

| Feature | Grove | AgentCash | Coinbase | mppx | Stripe | Skyfire |
|---------|-------|-----------|----------|------|--------|---------|
| Handle/username claiming | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Social link registration | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Public profile page (web) | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Avatar/banner | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Verification badges | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| QR code generation | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| OG/social card previews | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Embeddable tip widget | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Profile analytics | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Custom domains | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |

**Takeaway**: Grove is the **only** platform with identity/profile features. No competitor is building Linktree-style profiles. This is Grove's unique wedge — but the public web page is missing.

### Payment UX

| Feature | Grove | AgentCash | Coinbase | mppx | Stripe | Skyfire |
|---------|-------|-----------|----------|------|--------|---------|
| Send tips/payments | ✅ | ◐ (API calls) | ✅ (transfers) | ✅ (402 pay) | ✅ (charges) | ◐ |
| Tip with memo/message | ❌ | ❌ | ❌ | ❌ | ✅ (metadata) | ❌ |
| Payment notifications | ❌ | ❌ | ❌ | ❌ | ✅ (webhooks) | ❌ |
| Payment links | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ |
| Fiat on-ramp | ❌ | ❌ | ✅ (Coinbase) | ❌ | ✅ (native) | ◐ |
| Fiat off-ramp | ❌ | ❌ | ✅ (Coinbase) | ❌ | ✅ (native) | ❌ |
| Batch payments | ❌ | ❌ | ◐ | ❌ | ✅ | ❌ |
| Recurring/subscriptions | ❌ | ❌ | ❌ | ◐ (sessions) | ✅ | ❌ |
| Split payments | ❌ | ❌ | ❌ | ❌ | ✅ (Connect) | ❌ |
| Transaction history | ✅ | ◐ | ✅ | ❌ | ✅ | ◐ |
| Balance display | ✅ (3 wallets) | ◐ | ✅ | ◐ | — | ◐ |

**Takeaway**: Grove has basic tip/fund/balance but lacks the social layer (memos, notifications) that makes payments feel human. Stripe is the gold standard for payment UX features.

### Agent-Native Capabilities

| Feature | Grove | AgentCash | Coinbase | mppx | Stripe | Skyfire |
|---------|-------|-----------|----------|------|--------|---------|
| Non-interactive / agent mode | ✅ | ✅ | ✅ | ✅ | ◐ | ✅ |
| MCP server integration | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ |
| JSON output (all commands) | ◐ | ◐ | ✅ | ✅ | ✅ | ◐ |
| 402 protocol client | ❌ | ✅ (x402) | ◐ | ✅ (MPP) | ❌ | ❌ |
| Spending policies/limits | ❌ | ❌ | ◐ | ❌ | ✅ (dashboard) | ◐ |
| Destination allowlists | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Webhook/event system | ❌ | ❌ | ❌ | ◐ (SSE) | ✅ | ❌ |
| Idempotent transactions | ❌ | ❌ | ✅ | ❌ | ✅ | ❌ |
| Python SDK | ❌ | ❌ | ✅ | ❌ | ✅ | ❌ |
| TypeScript SDK | ❌ | ❌ | ✅ | ✅ | ✅ | ❌ |
| API key scoping | ❌ | ❌ | ✅ (CDP) | ❌ | ✅ | ❌ |
| Receipt verification | ❌ | ◐ | ◐ | ✅ | ✅ | ❌ |
| Proxy/gateway mode | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ |
| Agent skill packaging | ✅ | ✅ | ✅ (MCP) | ❌ | ❌ | ❌ |

**Takeaway**: Coinbase leads on agent infrastructure (MCP, SDK, key scoping). mppx leads on 402 protocol handling. Grove's agent mode exists but lacks the safety primitives (policies, allowlists) needed for production autonomous agents.

### Discovery and Network

| Feature | Grove | AgentCash | Coinbase | mppx | Stripe | Skyfire |
|---------|-------|-----------|----------|------|--------|---------|
| Creator directory | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Search/find creators | ◐ (stubbed) | ❌ | ❌ | ❌ | ❌ | ❌ |
| Categories/tags | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Trending/leaderboards | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Referral system | ✅ (basic) | ❌ | ❌ | ❌ | ❌ | ❌ |
| Verification program | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |

**Takeaway**: No competitor is building creator discovery or social features. This is an open field for Grove — but currently empty on all sides.

### Security and Trust

| Feature | Grove | AgentCash | Coinbase | mppx | Stripe | Skyfire |
|---------|-------|-----------|----------|------|--------|---------|
| Wallet key storage | ◐ (plaintext file) | ◐ (JSON file) | ✅ (CDP managed) | ✅ (OS keychain) | — | ◐ |
| Spend limits | ❌ | ❌ | ◐ | ❌ | ✅ | ◐ |
| Audit log (beyond txns) | ❌ | ❌ | ◐ | ❌ | ✅ | ❌ |
| Rate limiting (client) | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ |
| Session/key expiry | ❌ | ❌ | ✅ | ❌ | ✅ | ❌ |
| Transaction signing review | ❌ | ❌ | ◐ | ❌ | — | ❌ |
| 2FA / multi-sig | ❌ | ❌ | ◐ | ❌ | ✅ | ❌ |

**Takeaway**: Grove stores private keys in plaintext (`~/.grove/keyfile.txt`). mppx uses OS keychain; Coinbase uses managed custody. This is the most urgent security gap given supply-chain attack risks on AI CLI tools.

### Developer and Integration

| Feature | Grove | AgentCash | Coinbase | mppx | Stripe | Skyfire |
|---------|-------|-----------|----------|------|--------|---------|
| API documentation | ❌ | ❌ | ✅ | ✅ | ✅ | ◐ |
| Webhook docs | ❌ | ❌ | ❌ | ◐ | ✅ | ❌ |
| GitHub Action | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Browser extension | ❌ | ❌ | ✅ (wallet) | ❌ | ❌ | ❌ |
| Embed/widget SDK | ❌ | ❌ | ✅ (OnchainKit) | ❌ | ✅ (Elements) | ❌ |
| OAuth/developer portal | ❌ | ❌ | ✅ (CDP) | ❌ | ✅ | ❌ |
| CI/CD integration | ❌ | ❌ | ◐ | ❌ | ✅ | ❌ |

**Takeaway**: Stripe and Coinbase are miles ahead on developer platform. Grove has zero public API docs. The GitHub Action for auto-tipping contributors is an unclaimed wedge no competitor offers.

## Platform Deep Dives

### x402

- **What**: Open HTTP 402 payment protocol with middleware examples
- **Strengths**: Clean protocol spec, USDC-on-Base focus, open source
- **Weaknesses**: Protocol-only — no wallet mgmt, no policy, no discovery
- **Relevance to Grove**: Grove already uses x402 for funding. Could extend to support x402 as a payment method for others paying Grove users.

### MPP (Machine Payments Protocol)

- **What**: HTTP 402 protocol by Stripe/Tempo supporting multiple payment methods
- **Strengths**: Multi-method (crypto via Tempo, fiat via Stripe SPT, Lightning), backed by Stripe
- **Weaknesses**: Early ecosystem, implementation complexity
- **Adoption**: 894 agents, 31,000+ transactions in first week (a16z report)
- **Relevance to Grove**: Should add MPP adapter alongside x402 for broader agent compatibility

### mppx

- **What**: TypeScript SDK/CLI implementing MPP client, server, and proxy patterns
- **Strengths**: Best-in-class 402 loop UX, keychain-backed keys, proxy/gateway mode, SSE streaming support
- **Weaknesses**: TypeScript-only, 73 stars, no identity layer
- **Relevance to Grove**: Reference implementation for "curl that pays" pattern. Grove should learn from mppx's UX but add identity + policy on top.

### Coinbase AgentKit

- **What**: Wallet + action provider toolkit for onchain agents
- **Strengths**: MCP extension, framework integrations (LangChain, Vercel AI SDK), managed wallet security, ~1.2k stars
- **Weaknesses**: Coinbase-ecosystem locked, no identity/profile features, complex dependency graph
- **Relevance to Grove**: Strongest agent infrastructure competitor. Grove differentiates on identity + Linktree + simpler UX.

### AgentCash

- **What**: CLI + skills for x402-based paid endpoint access
- **Strengths**: Skill packaging, "payment is authentication" model
- **Weaknesses**: Wallet stored as local JSON file, limited to x402, fragmented distribution
- **Relevance to Grove**: Direct competitor for agent payment skills. Grove has better identity features.

### OpenPayment

- **What**: CLI/SDK for creating USDC payment links via x402
- **Strengths**: Simple "request money" primitive
- **Weaknesses**: Lightweight — no full custody, no discovery, no profiles
- **Relevance to Grove**: Grove should add payment link creation (`grove pay-link`) to cover this use case natively.

### Stripe CLI (reference)

- **What**: Industry-standard payments developer CLI
- **Strengths**: Webhook listen/trigger, environment separation, log tailing, auth hygiene, massive ecosystem
- **Weaknesses**: Not agent-native, fiat-only, no crypto/wallet support
- **Relevance to Grove**: UX reference model. Grove should copy Stripe's patterns for webhooks, env separation, and event simulation.

### Skyfire

- **What**: AI agent payment network
- **Status**: Limited public documentation as of March 2026
- **Relevance to Grove**: Monitor for developments. Potential integration partner or competitor depending on direction.

## Where Grove Leads

1. **Identity + Linktree**: Only platform with handle claiming, social links, profile management. No competitor is building this.
2. **Agent skill packaging**: Published skills for Claude, Codex, Gemini with modular onboard/register/find/tip/earn modules.
3. **CLI UX for humans**: Rich terminal output, guided setup flows, multiple onboarding paths (email, wallet, API key).
4. **Referral system**: Basic but present — no competitor has any referral mechanism.
5. **Multi-wallet visibility**: Three wallet types (earning, tipping, funding) shown in one `grove balance` view.

## Where Grove Needs to Catch Up

1. **Public profile pages** — The Linktree claim requires a web presence. Nobody has this, but Grove claims it.
2. **Key security** — Plaintext keyfile vs mppx's keychain and Coinbase's managed custody.
3. **MCP server** — Coinbase AgentKit already has one. Grove requires agents to shell out to CLI.
4. **Spending policies** — No spend limits, no allowlists. Agents can drain wallets unchecked.
5. **Payment notifications** — Zero feedback when you receive a tip. Earning feels broken.
6. **Tip memos** — Tips without context are anonymous and transactional.
7. **API documentation** — The CLI wraps an API that third parties cannot access.
8. **402 protocol client** — Grove uses x402 for funding but cannot act as a universal 402 payment client.
9. **Fiat on-ramp** — Users must acquire USDC externally before they can fund Grove.
10. **Webhooks/events** — Agents must poll `grove history`; no push-based event system.

## Prioritized Gap Closure

### Phase 1: Make the product real (P0s)

1. Public profile web pages (`grove.city/<handle>`)
2. Tip with memo
3. Payment notifications
4. Spending policies + allowlists
5. MCP server
6. 100% JSON output with documented schemas
7. Audit log
8. API documentation (OpenAPI spec)
9. Creator directory
10. Payment links

### Phase 2: Make it sticky (P1s)

11. QR codes, OG cards, embeddable widgets
12. Avatar/banner, verification badges
13. Fiat on-ramp (Stripe/MoonPay)
14. Python SDK
15. 402 protocol client (x402 + MPP)
16. Batch tips, idempotency keys
17. Keyfile encryption (OS keychain)
18. GitHub Action for auto-tipping
19. Tags, trending, search filters
20. API key scoping, receipt verification

### Phase 3: Build the moat (P2-P3)

21. Subscriptions, invoices, off-ramp
22. Multi-agent wallets
23. Profile analytics, link analytics
24. Custom domains, themes
25. Referrals, recommendations, social graph

## Links and Resources

- [Skills.sh — Audits](https://skills.sh/audits)
- [Skills.sh — Official Skills](https://skills.sh/official)
- [ClawHub — Skills (filtered)](https://clawhub.ai/skills?nonSuspicious=true&q=cn)
- [OpenClaw — ClawHub Tools Docs](https://docs.openclaw.ai/tools/clawhub)
- [Coinbase — Agentic Wallet Skills](https://docs.cdp.coinbase.com/agentic-wallet/skills/overview)
- [AgentSkills.so — AgentCash / Merit Systems](https://agentskills.so/skills/merit-systems-agentcash-skills-people-property)
- [Tempo / MPP — a16z coverage](https://a16z.com) (first-week stats: 894 agents, 31k+ txns)
- [mppx — GitHub](https://github.com) (73 stars, MIT, TypeScript SDK/CLI)
- [MoonPay — Open Wallet Standard](https://moonpay.com) (encrypted vault + policy engine concept)
