# Tip Module

The tip module sends value to creators with attribution and scoring.

## Scope

- `grove tip`, `grove check`, `grove balance`, `grove history`
- `GET /v1/tip/resolve` — check tippability, detect platform (no auth required)
- `POST /v1/tip` — JSON body tip with context metadata (recommended for programmatic use)

## Required Execution Loop

1. **Verify Balance**: Check `grove balance --json`. If zero, run `grove fund <amount>`.
2. **Resolve Destination**: Run `grove check <destination> --json` (CLI) or `GET /v1/tip/resolve?destination=<URL>` (API) to confirm tippability and detect platform.
3. **Score Content**: Evaluate the target content and produce a 1-2 sentence rationale.
4. **Execute Tip**: Use `grove tip` for simple tips, or `POST /v1/tip` with `context` for URL-based tips with attribution.
5. **Log State**: Record the transaction hash and rationale from the JSON response.

## Key Commands

**Check balance before tipping:**

```bash
grove balance --json
```

**Verify destination is tippable:**

```bash
grove check olshansky.info --json
```

**Send a tip (interactive, human mode):**

```bash
grove tip fred 0.05
```

**Send a tip (non-interactive, agent mode):**

```bash
grove tip fred 0.05 --yes --json
```

**Specify network and token:**

```bash
grove tip fred 0.05 --network base-sepolia --token USDC --yes --json
```

**View transaction history:**

```bash
grove history --json
grove history --type tips --json
grove history --type funds --json
grove history --limit 5 --json
```

## Tip from URL

The primary workflow for "Tip user @x $0.02 for this URL". The agent parses the URL, detects the platform, resolves the destination, and tips with full attribution context.

### Platform Detection

| URL Pattern | Platform | Example |
|-------------|----------|---------|
| `x.com/handle/status/ID` | `x` | `x.com/olshansky/status/1234` |
| `substack.com/@handle` | `substack` | `substack.com/@olshansky` |
| `handle.substack.com` | `substack` | `olshansky.substack.com` |
| `youtube.com/@handle` | `youtube` | `youtube.com/@olshansky` |
| `youtube.com/watch?v=ID` | `youtube` | `youtube.com/watch?v=abc123` |
| `*.eth` | ENS | `vitalik.eth` |
| `*.base.eth` | Base name | `alice.base.eth` |
| `domain.tld` | domain (llms.txt) | `olshansky.info` |

### Step 1: Resolve the URL

The resolve endpoint is public (no auth required) and auto-detects platform from the URL:

```bash
curl -s "https://api.grove.city/v1/tip/resolve?destination=x.com/olshansky/status/1234"
```

Returns `tippable` (boolean), `destination_kind` (platform detected), and `addresses[]` (resolved payment addresses).

### Step 2: Send tip with context

Use `POST /v1/tip` with the `context` field for full attribution:

```bash
GROVE_API_KEY=$(grep GROVE_API_KEY ~/.grove/.env | cut -d= -f2)
curl -s -X POST "https://api.grove.city/v1/tip" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "destination": "x.com/olshansky",
    "amount": "0.02",
    "context": {
      "source_post_url": "https://x.com/olshansky/status/1234",
      "recipient_username": "olshansky",
      "sender_platform": "x"
    }
  }'
```

### When to use CLI vs API

- **CLI** (`grove tip`): Simple tips by handle/domain. No context metadata attached.
- **API** (`POST /v1/tip`): URL-based tips, tips with attribution context, programmatic tipping with metadata.

## TipContext Fields

The `context` object in `POST /v1/tip` supports these attribution fields:

| Field | Description |
|-------|-------------|
| `source_post_url` | URL of the post/tweet that triggered the tip |
| `sender_username` | Tipper's username on the source platform |
| `sender_platform` | Platform enum: `x`, `discord`, `telegram`, `reddit`, `github`, `tiktok`, `substack`, `youtube`, `farcaster`, `lens`, `other` |
| `sender_profile_url` | Tipper's profile URL |
| `recipient_username` | Recipient's username |
| `recipient_profile_url` | Recipient's profile URL |
| `campaign` | Campaign or bot identifier |
| `referrer` | Referrer identifier |
| `custom_metadata` | Free-form string (max 250 chars) |

## API Tip Response

`POST /v1/tip` returns: `tip_id`, `status`, `tx_hash`, `destination`, `from_address`, `receiver_address`, `amount_sent`, `amount_received`, `fee_amount`, `new_balance`, `network`.

## Supported Destinations

The `grove tip` command and `POST /v1/tip` accept many destination formats:

- **Grove handle**: `fred`, `@olshansky`
- **Domain**: `olshansky.info`, `fredt.io`
- **Twitter/X**: `x.com/olshansky`, `x.com/olshansky/status/1234`
- **YouTube**: `youtube.com/@handle`, `youtube.com/watch?v=ID`
- **Substack**: `substack.com/@handle`, `handle.substack.com`
- **ENS**: `vitalik.eth`, `alice.base.eth`
- **EVM wallet**: `0x...`
- **Solana wallet**: base58 address

## Amount Formats

- Decimal: `0.01`, `0.05`, `1.00`
- Dollar sign: `$1`, `$0.50`
- With token: `100USDC`

## Tipping Policy (Bands)

- Useful content: `0.01-0.05 USDC`
- High-value content: `0.05-0.25 USDC`
- Exceptional content: `0.25-1.00 USDC`

## Tip with Message (Tip to Talk)

You can attach a message (1-420 characters) to a tip, delivered via email to the recipient. This requires the recipient to have tip-to-talk enabled.

Some recipients set a minimum tip amount for messages. Check their `tip_to_talk_min` via `grove profile show @handle --json` before sending.

See the **[Message module](./message.md)** for full details, API commands, and configuration.

## Error Handling

- **Insufficient balance**: Run `grove fund <amount>` to add funds, then retry.
- **Destination not tippable**: Try alternative formats (domain, handle, twitter URL). Run `grove check <destination> --json` or `GET /v1/tip/resolve?destination=<URL>` to debug.
- **Network error**: Check connectivity with `grove config show`. Retry after a few seconds.
- **Transaction failed**: Check `grove history --json` to see if the tip went through despite the error. Do not retry without checking — avoid double-tipping.

## Success Criteria

- `grove tip --json` or `POST /v1/tip` returns a `tx_hash` and `new_balance`.
- Transaction appears in `grove history`.
