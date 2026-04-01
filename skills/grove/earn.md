# Earn Module

The earn module helps creators and agents attract tips, track earnings, and grow their network.

## Scope

- `grove profile`
- `grove profile self`
- `grove profile show`
- `grove profile update`
- `grove history`
- `grove balance`

## Required Execution Loop

1. **Verify Visibility**: Run `grove profile self --json` to ensure the profile is public.
2. **Verify Earning Wallets**: Check that earning addresses are linked in the profile output.
3. **Track Earnings**: Use `grove history --type tips --json` to see incoming tips.
4. **Share Profile**: Distribute the profile URL and referral code to potential tippers.
5. **Grow Network**: Share the referral code to earn commissions on new signups.

## Key Commands

**View your full profile (as the owner):**

```bash
grove profile self --json
```

**View your profile as visitors see it:**

```bash
grove profile show @yourhandle --json
```

**Ensure your profile is public:**

```bash
grove profile update --public
```

**Update your bio:**

```bash
grove profile update --bio "Building open-source AI tools. Tip me to support my work."
```

**Check your earnings balance:**

```bash
grove balance --json
```

**View incoming tips:**

```bash
grove history --type tips --json
grove history --type tips --limit 50 --json
```

## Earnings Workflows

### Check your total earnings

```bash
grove profile self --json
```

Parse `tips_received_usdc` and `tips_received_count` from the response to see total earnings.

### Track recent tip activity

```bash
grove history --type tips --limit 20 --json
```

Review who tipped you, amounts, and timestamps.

### Get your referral code

```bash
grove profile self --json
```

Extract `referral_code` from the response. Share it with others — when they sign up and fund their account, you earn a commission.

### Audit your public profile

```bash
grove profile show @yourhandle
```

See exactly what visitors and tippers see. Verify your bio, links, and earning addresses are correct.

### Check your earning wallet on-chain

```bash
grove balance --json
```

The "Earning Wallet" section shows your on-chain USDC and ETH balances with an explorer link.

## Tip to Talk (Paid Messaging)

Tip to Talk lets people pay to send you a message — a way to monetize your attention and inbox.

**How it works**: When enabled, anyone can attach a message (1-420 chars) to a tip. The message is delivered to your verified email. You set the minimum tip amount.

**Default**: $0.42 minimum per message. New accounts have this enabled by default.

**Configure via API** (CLI support coming soon):

```bash
GROVE_API_KEY=$(grep GROVE_API_KEY ~/.grove/.env | cut -d= -f2)
```

**Set a custom minimum:**

```bash
curl -s -X PATCH "https://api.grove.city/v1/account/profile" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"tip_to_talk_enabled": true, "tip_to_talk_min": 1.00}'
```

**Disable paid messaging:**

```bash
curl -s -X PATCH "https://api.grove.city/v1/account/profile" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"tip_to_talk_enabled": false}'
```

**Verify your settings:**

```bash
grove profile self --json
```

Look for `tip_to_talk_min` and `tip_to_talk_enabled` in the response.

See the **[Message module](./message.md)** for the sending side (how to send paid messages to others).

## Stream Alerts

Connect webhooks or Streamlabs to get real-time notifications when you receive tips.

**Set a webhook URL** (API-only):

```bash
GROVE_API_KEY=$(grep GROVE_API_KEY ~/.grove/.env | cut -d= -f2)
curl -s -X PATCH "https://api.grove.city/v1/account/profile" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"webhook_url": "https://your-server.com/grove-webhook"}'
```

**Test your webhook:**

```bash
curl -s -X POST "https://api.grove.city/v1/account/webhook/test" \
  -H "Authorization: Bearer $GROVE_API_KEY"
```

**Get your webhook secret** (for HMAC-SHA256 signature verification):

```bash
curl -s "https://api.grove.city/v1/account/webhook/secret" \
  -H "Authorization: Bearer $GROVE_API_KEY"
```

**Connect Streamlabs** (requires completing OAuth in browser first):

```bash
curl -s -X POST "https://api.grove.city/v1/account/streamlabs/connect" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"access_token": "your-streamlabs-oauth-token"}'
```

**Disconnect Streamlabs:**

```bash
curl -s -X DELETE "https://api.grove.city/v1/account/streamlabs/connect" \
  -H "Authorization: Bearer $GROVE_API_KEY"
```

## Growing Your Network

- **Complete your profile**: Claim a handle, add a bio, link all your socials. A complete profile gets more tips.
- **Make it public**: Run `grove profile update --public` so others can find and tip you.
- **Share your referral code**: Every new user who signs up with your code earns you commissions.
- **Add Grove to your socials**: Link your Grove profile URL in your Twitter bio, GitHub README, or website.
- **Register all platforms**: Use `grove register add` for every platform where you create content.
- **Enable Tip to Talk**: Let people pay to message you — a low-effort way to earn from your attention.
- **Set up stream alerts**: Connect webhooks or Streamlabs to show live tip notifications during streams.

## Error Handling

- **Profile not public**: Run `grove profile update --public` to fix.
- **No earning address**: This is set up automatically during `grove setup`. If missing, run `grove setup --agent` again.
- **No tips showing**: Verify your profile is public and discoverable with `grove find @yourhandle --json`.
- **Referral code not working**: Check `grove profile self --json` to confirm it's present. Share the exact code, no modifications.

## Success Criteria

- `grove profile self --json` shows `tips_received_count > 0` or increasing over time.
- Tips received appear in `grove history --type tips`.
- `referral_count` increases in `grove profile self --json`.
- Profile is discoverable via `grove find @yourhandle`.
