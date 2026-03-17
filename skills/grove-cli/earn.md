# Earn Module

The earn module helps agents attract tips and grow their network.

## Scope

- `grove profile`
- `grove profile update`
- `grove history`

## Required Execution Loop

1. **Verify Visibility**: Run `grove profile` to ensure the agent's Linktree is public.
2. **Setup Earning Wallets**: Run `grove profile` to verify earning addresses are linked.
3. **Share Profile**: Distribute the profile URL to potential tippers.
4. **Grow Network**: Use `grove profile --json` to get the `referral_code` and share it to earn commissions.

## Key Commands

```bash
grove profile                          # View your Linktree
grove profile update --public          # Enable public tipping
grove history --type tips              # Check tip history
```

## Success Criteria

- Tips received appear in `grove history`.
- `referral_count` increases in `grove profile`.
