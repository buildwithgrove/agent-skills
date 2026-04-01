# Tip Module

The tip module sends value to creators with attribution and scoring.

## Scope

- `grove tip`
- `grove check`
- `grove balance`
- `grove history`

## Required Execution Loop

1. **Verify Balance**: Check `grove balance --json`. If zero, run `grove fund <amount>`.
2. **Verify Destination**: Run `grove check <destination> --json` to confirm it's tippable.
3. **Score Content**: Evaluate the target content and produce a 1-2 sentence rationale.
4. **Execute Tip**: `grove tip <destination> <amount> --yes --json`.
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

## Supported Destinations

The `grove tip` command accepts many destination formats:

- **Grove handle**: `fred`, `@olshansky`
- **Domain**: `olshansky.info`, `fredt.io`
- **Twitter/X**: `x.com/olshansky`, `@olshansky` (on X)
- **YouTube**: `youtube.com/@handle`
- **ENS**: `username.eth`
- **Wallet address**: `0x...`

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
- **Destination not tippable**: Try alternative formats (domain, handle, twitter URL). Run `grove check <destination> --json` to debug.
- **Network error**: Check connectivity with `grove config show`. Retry after a few seconds.
- **Transaction failed**: Check `grove history --json` to see if the tip went through despite the error. Do not retry without checking — avoid double-tipping.

## Success Criteria

- `grove tip --json` returns a `tx_hash` and `new_balance`.
- Transaction appears in `grove history`.
