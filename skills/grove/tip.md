# Tip Module

The tip module sends value to creators with attribution and scoring.

## Scope

- `grove tip`
- `grove balance`
- `grove history`

## Required Execution Loop

1. **Verify Balance**: Check `grove balance --json`.
2. **Score Content**: Evaluate the target content and produce a 1-2 sentence rationale.
3. **Execute Tip**: `grove tip <destination> <amount> --json`.
4. **Log State**: Record the transaction hash and rationale.

## Key Commands

```bash
grove tip alice 0.05                   # Send a tip to handle
grove tip bob.eth 1.00                 # Send a tip to ENS
grove history --json                   # View all transaction history
grove history --type tips --json       # Tips only
grove history --type funds --json      # Funding only
grove history --limit 5 --json         # Last 5 entries
```

## Tipping Policy (Bands)

- Useful content: `0.01-0.05 USDC`
- High-value content: `0.05-0.25 USDC`
- Exceptional content: `0.25-1.00 USDC`

## Success Criteria

- `grove tip --json` returns a `tx_hash` and `new_balance`.
- Transaction appears in `grove history`.
