# Onboard Module

The onboard module ensures the agent's environment is correctly configured with Grove CLI and an authenticated account.

## Scope

- `grove setup`
- `grove fund`
- `grove config`

## Required Execution Loop

1. **Verify CLI Installation**: If `grove --version` fails, run `curl -fsSL https://app.grove.city/install-cli.sh | bash`.
2. **Setup Account**:
   - For agents with an existing key: `grove setup --agent --keyfile /path/to/private-key.txt`.
   - For new agents: `grove setup --agent`.
3. **Verify Balance**: Run `grove balance --json`. If zero, run `grove fund <amount>`.

## Key Commands

```bash
grove setup --agent                    # Non-interactive wallet setup
grove fund 10.0                        # Autonomous funding via x402
grove config show                      # Inspect current environment
```

## Success Criteria

- `grove balance --json` returns a non-empty `balances` list.
- `~/.grove/keyfile.txt` exists and contains a valid EVM private key.
- `GROVE_API_KEY` is set in `~/.grove/.env`.
