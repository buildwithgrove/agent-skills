# Onboard Module

The onboard module ensures the agent's environment is correctly configured with Grove CLI and an authenticated account.

## Scope

- `grove setup`
- `grove fund`
- `grove keygen`
- `grove config`
- `grove contact`

## Required Execution Loop

1. **Verify CLI Installation**: If `grove --version` fails, run `curl -fsSL https://grove.city/install-cli.sh | bash`.
2. **Setup Account**: Choose the right path based on the agent's context (see Setup Paths below).
3. **Verify Balance**: Run `grove balance --json`. If tipping balance is zero, run `grove fund <amount>`.
4. **Verify Identity**: Run `grove profile self --json` to confirm the account is active.

## Setup Paths

### Path 1: New agent (fresh start)

Generate a wallet and set up a new account:

```bash
grove setup --agent
```

### Path 2: New agent with immediate funding

Generate wallet, create account, and fund in one step:

```bash
grove setup --agent --amount 5.0
```

### Path 3: Agent with existing wallet

Import an existing private key file:

```bash
grove setup --agent --keyfile /path/to/private-key.txt
```

### Path 4: Agent with existing Grove API key

Skip wallet setup entirely — use a key from grove.city or a teammate:

```bash
grove setup --agent --api-key "eyJ..."
```

### Path 5: Generate a wallet first, then setup

Create a wallet separately (useful for multi-agent setups):

```bash
grove keygen --save
grove setup --agent --keyfile ~/.grove/keyfile.txt
```

## Key Commands

**Install the CLI:**

```bash
curl -fsSL https://grove.city/install-cli.sh | bash
```

**Non-interactive agent setup:**

```bash
grove setup --agent
```

**Generate a new Ethereum wallet:**

```bash
grove keygen              # Display only (does not save)
grove keygen --save       # Save to ~/.grove/keyfile.txt
```

**Fund the account:**

```bash
grove fund 5.0 --json
grove fund 0.1 --network base-sepolia --token USDC --json
```

**Inspect current environment:**

```bash
grove config show
grove config set network base-sepolia
grove config set token USDC
```

**Send feedback or report an issue:**

```bash
grove contact "Having trouble with setup on macOS"
```

## Wallet and Key Management

- **Keyfile location**: `~/.grove/keyfile.txt` (EVM private key)
- **Automatic backups**: Grove creates timestamped backups in `~/.grove/` when importing or generating keys
- **Config location**: `~/.grove/.env` (API key, network, token defaults)
- **Environment override**: Set `GROVE_API_KEY` env var to override the config file

## Funding Details

- **Protocol**: x402 (on-chain USDC payment)
- **Minimum**: 0.01 USDC
- **Maximum**: 1,000 USDC
- **Requirements**: Private key in `~/.grove/keyfile.txt` with USDC and ETH (for gas) on the configured network
- **Default network**: base-sepolia

## Error Handling

- **CLI not found after install**: Restart your shell or run `source ~/.bashrc` / `source ~/.zshrc`.
- **Setup fails with network error**: Check connectivity with `grove config show`. Verify the API URL is reachable.
- **Fund fails "insufficient balance"**: The funding wallet needs USDC and ETH for gas on the configured network. Check `grove balance --json` for the funding wallet balances.
- **Fund fails "account not found"**: Run `grove setup --agent` first to create the account before funding.
- **Keyfile already exists**: Grove will prompt to overwrite or back up. Use `grove keygen --save` to force a new key (existing key is backed up automatically).
- **Invalid API key**: Re-run `grove setup --agent --api-key "..."` with a valid JWT from grove.city.

## Success Criteria

- `grove --version` returns a version string.
- `grove balance --json` returns a non-empty `balances` list.
- `~/.grove/keyfile.txt` exists and contains a valid EVM private key.
- `GROVE_API_KEY` is set in `~/.grove/.env`.
- `grove profile self --json` returns account info (includes `tip_to_talk_min`, `tip_to_talk_enabled`, `webhook_configured`, `streamlabs_connected`).
