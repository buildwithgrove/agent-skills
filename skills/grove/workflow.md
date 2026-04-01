# Workflow Module

End-to-end workflows that combine multiple Grove modules into complete journeys.

## Workflow 1: New Agent Cold Start

A brand new agent goes from zero to fully set up and tipping.

```bash
# 1. Install CLI
curl -fsSL https://grove.city/install-cli.sh | bash
grove --version

# 2. Generate wallet and setup account
grove setup --agent --amount 1.0

# 3. Claim identity
grove profile claim my-agent-name
grove profile update --bio "Autonomous agent that rewards great content"
grove profile update --public

# 4. Register social links
grove register add github my-agent-name
grove register add website https://my-agent.example.com --title "Homepage"

# 5. Verify everything is ready
grove balance --json
grove profile self --json

# 6. Find and tip a creator
grove find olshansky --json
grove check olshansky.info --json
grove tip olshansky 0.05 --yes --json

# 7. Confirm the tip landed
grove history --type tips --limit 1 --json
```

## Workflow 2: Existing User Tips Someone

A user with an existing Grove account wants to tip a creator.

```bash
# 1. Check balance
grove balance --json

# 2. Fund if needed
grove fund 5.0 --json

# 3. Find the creator
grove find fred --json

# 4. Verify they can receive tips
grove check fred --json

# 5. Send the tip
grove tip fred 0.10 --yes --json

# 6. Verify
grove history --type tips --limit 1 --json
```

## Workflow 3: Content Creator Onboarding

A creator sets up their Grove Linktree to start receiving tips.

```bash
# 1. Setup account
grove setup --agent

# 2. Fund with a small amount (to verify everything works)
grove fund 0.10 --json

# 3. Claim a memorable handle
grove profile claim mycreatorname

# 4. Write a compelling bio
grove profile update --bio "Writer, developer, and open-source enthusiast. Building tools for the future."

# 5. Make profile public
grove profile update --public

# 6. Link all social platforms
grove register add x @mycreatorname
grove register add github mycreatorname
grove register add youtube @mycreatorname
grove register add website https://mycreatorname.com --title "Blog"

# 7. Verify the full profile
grove profile self
grove register list

# 8. Test discoverability (as a visitor would see it)
grove profile show @mycreatorname
grove find @mycreatorname --json
grove check mycreatorname --json
```

## Workflow 4: Agent Content Scoring Loop

An agent evaluates content and tips creators autonomously in a loop.

```bash
# 1. Verify setup
grove balance --json

# 2. For each piece of content:
#    a. Resolve the creator
grove find <creator-identifier> --json

#    b. Check tippability
grove check <destination> --json

#    c. Score the content (agent decides amount based on tipping bands)
#       - Useful: 0.01-0.05 USDC
#       - High-value: 0.05-0.25 USDC
#       - Exceptional: 0.25-1.00 USDC

#    d. Send the tip
grove tip <destination> <amount> --yes --json

# 3. After the loop, audit all tips sent
grove history --type tips --json
grove balance --json
```

## Workflow 5: Multi-Agent Setup

Set up multiple agents sharing the same funding source but with separate identities.

```bash
# Agent 1: Generate wallet and setup
grove keygen --save  # Creates ~/.grove/keyfile.txt
grove setup --agent --keyfile ~/.grove/keyfile.txt
grove profile claim agent-alpha
grove profile update --bio "Content discovery agent" --public

# Agent 2: Generate a separate wallet
grove keygen  # Display key, save manually to a different path
# Copy the private key to /path/to/agent2-key.txt
grove setup --agent --keyfile /path/to/agent2-key.txt
grove profile claim agent-beta
grove profile update --bio "Code review agent" --public

# Fund each agent separately
# (switch GROVE_API_KEY env var or config between agents)
grove fund 5.0 --json
```

## Workflow 6: Earnings Check and Growth

A creator reviews their earnings and optimizes their profile.

```bash
# 1. Check total earnings
grove profile self --json
# Parse: tips_received_usdc, tips_received_count

# 2. Review recent tips
grove history --type tips --limit 50 --json

# 3. Check on-chain earning balance
grove balance --json

# 4. Get referral code for growth
grove profile self --json
# Parse: referral_code

# 5. Audit public profile for completeness
grove profile show @yourhandle
grove register list

# 6. Report issues if something looks wrong
grove contact "My tips aren't showing in history"
```

## Workflow 7: Send a Paid Message (Tip to Talk)

Send a tip with an attached message to a creator.

```bash
# 1. Check balance
grove balance --json

# 2. Verify recipient is tippable
grove check @creator --json

# 3. Check their tip-to-talk minimum
grove profile show @creator --json
# Look for tip_to_talk_min in the response

# 4. Send paid message via API (CLI support coming soon)
GROVE_API_KEY=$(grep GROVE_API_KEY ~/.grove/.env | cut -d= -f2)
curl -s -X POST "https://api.grove.city/v1/tip/message" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "destination": "@creator",
    "amount": "0.50",
    "message": "Loved your latest article!",
    "network": "base",
    "token": "USDC"
  }'

# 5. Verify tip landed
grove history --type tips --limit 1 --json
```

## Workflow 8: Configure Tip to Talk as a Creator

Enable paid messaging so people can pay to reach your inbox.

```bash
# 1. Ensure profile is set up
grove profile self --json

# 2. Enable tip-to-talk with custom minimum
GROVE_API_KEY=$(grep GROVE_API_KEY ~/.grove/.env | cut -d= -f2)
curl -s -X PATCH "https://api.grove.city/v1/account/profile" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"tip_to_talk_enabled": true, "tip_to_talk_min": 1.00}'

# 3. Verify settings
grove profile self --json
# Confirm tip_to_talk_enabled: true, tip_to_talk_min: 1.00
```

## Workflow 9: Content Discovery and Tipping Loop

Discover a creator's content across platforms and tip the best items.

```bash
# 1. Verify setup
grove balance --json

# 2. Resolve the creator
grove find olshansky --json

# 3. Fetch their content feed (API-only for now)
GROVE_API_KEY=$(grep GROVE_API_KEY ~/.grove/.env | cut -d= -f2)
curl -s "https://api.grove.city/v1/feed/creators/olshansky?enrich=true&sort=tipped&limit=10" \
  -H "Authorization: Bearer $GROVE_API_KEY"

# 4. Score and tip the best content
#    - Useful: 0.01-0.05 USDC
#    - High-value: 0.05-0.25 USDC
#    - Exceptional: 0.25-1.00 USDC
grove tip olshansky 0.10 --yes --json

# 5. Audit tips sent
grove history --type tips --json
grove balance --json
```

## Workflow 10: Streamer Webhook Setup

Connect webhooks and Streamlabs for live tip notifications during streams.

```bash
# 1. Set webhook URL
GROVE_API_KEY=$(grep GROVE_API_KEY ~/.grove/.env | cut -d= -f2)
curl -s -X PATCH "https://api.grove.city/v1/account/profile" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"webhook_url": "https://your-server.com/grove-webhook"}'

# 2. Get your webhook secret for signature verification
curl -s "https://api.grove.city/v1/account/webhook/secret" \
  -H "Authorization: Bearer $GROVE_API_KEY"

# 3. Test webhook delivery
curl -s -X POST "https://api.grove.city/v1/account/webhook/test" \
  -H "Authorization: Bearer $GROVE_API_KEY"

# 4. (Optional) Connect Streamlabs — complete OAuth in browser first
curl -s -X POST "https://api.grove.city/v1/account/streamlabs/connect" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"access_token": "your-streamlabs-oauth-token"}'

# 5. Verify profile shows integrations
grove profile self --json
# Confirm webhook_configured: true, streamlabs_connected: true
```
