# Your Profile Companion

> Use Grove + Claude Code to set up your creator profile in minutes.

You know that thing where you finally sit down to "set up your online presence" and then 45 minutes later you're still fiddling with bios and forgetting which platforms you linked?

What if your AI agent just... did it for you?

This post walks through using [Grove](https://grove.city) with [Claude Code](https://docs.anthropic.com/en/docs/claude-code) to get your creator profile live in under 5 minutes. No context-switching. No tab juggling. Just you, your terminal, and a helpful companion.

---

## What is Grove?

[Grove](https://grove.city) is a wallet-first Linktree for creators.

- One profile that works everywhere
- Accept tips and micropayments directly to your wallet
- Works with AI agents out of the box

Think of it as your internet-native business card — except it can also receive money.

---

## Step 1: Get Configured

First, let's get the CLI installed and your account set up.

### Install the Grove CLI

```bash
curl -fsSL https://grove.city/install-cli.sh | bash
```

### Verify it worked

```bash
grove --version
```

### Set up your account

```bash
grove setup --agent
```

This creates a wallet and registers your account in one shot. Non-interactive, agent-friendly.

### Fund your account

```bash
grove fund 1.0 --json
```

### Check your balance

```bash
grove balance --json
```

<!-- [SCREENSHOT: Terminal showing grove setup --agent → grove balance flow] -->

---

## Step 2: Build Your Profile

Now the fun part — claiming your identity and building your Linktree.

### Claim your handle

```bash
grove profile claim yourname
```

Pick something memorable. Handles are unique and first-come-first-served.

### Add a bio

```bash
grove profile update --bio "Building cool things on the internet"
```

### Make it public

```bash
grove profile update --public
```

### Link your socials

**Twitter / X:**

```bash
grove register add x @yourhandle
```

**GitHub:**

```bash
grove register add github yourhandle
```

**Your website:**

```bash
grove register add website https://yoursite.com --title "Portfolio"
```

**Newsletter:**

```bash
grove register add website https://yourname.substack.com --title "Newsletter"
```

You can link as many platforms as you want. Each one makes you more discoverable.

### Verify everything looks right

```bash
grove register list
```

```bash
grove profile self
```

<!-- [SCREENSHOT: Terminal showing the complete profile with linked socials] -->

---

## Step 3: Discover Creators

Grove isn't just about your own profile — it's a directory of creators you can explore and support.

### Search by handle

```bash
grove find fred --json
```

### Search by domain

```bash
grove find olshansky.info --json
```

### View a creator's full profile

```bash
grove profile show @olshansky
```

This shows their full Linktree — bio, linked socials, and whether they're tippable.

<!-- [SCREENSHOT: Terminal showing grove find + grove profile show output] -->

---

## Bonus: Tip a Creator

Found someone whose work you appreciate? Send them a tip:

```bash
grove tip olshansky 0.05
```

Tips settle on-chain in seconds. No middlemen, no platform fees eating into it.

---

## The "Profile Companion" Workflow

Here's the magic: you don't have to type any of this yourself.

Just tell Claude Code what you want:

> "Set up my Grove profile with handle `yourname`, link my Twitter and GitHub, and add a bio about being a developer"

The agent reads the Grove skill, runs the commands, and gets you set up. You review the output and you're done.

That's it. Your profile companion handled the boring parts so you can get back to creating.

---

## What's Next?

- Visit [grove.city](https://grove.city) to see your profile live
- Check out the [workflow module](../skills/grove/workflow.md) for advanced agent patterns (content scoring loops, multi-agent setups)
- Share your referral code to earn commissions when others join

---

*Built with [Grove](https://grove.city) and [Claude Code](https://docs.anthropic.com/en/docs/claude-code).*
