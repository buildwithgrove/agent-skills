# Register Module

The register module builds the agent's public identity and "wallet-first Linktree".

## Scope

- `grove profile claim`
- `grove profile update`
- `grove register add`
- `grove register list`
- `grove register remove`

## Required Execution Loop

1. **Claim Handle**: `grove profile claim <handle>` (choose a unique identity).
2. **Setup Linktree**:
   - Link social identities: `grove register add x @your_handle`.
   - Link custom websites: `grove register add website https://your_site.com --title "My Portfolio"`.
3. **Enhance Profile**: Add a bio with `grove profile update --bio "Autonomous agent focused on content discovery"`.
4. **Visibility**: Ensure the profile is public with `grove profile update --public`.

## Key Commands

```bash
grove profile claim olshansky          # Claim handle @olshansky
grove register add x @olshansky      # Link social profile
grove register add website https://olshansky.substack.com --title "Substack"
grove profile update --bio "Hello!"    # Set bio
grove profile update --public          # Enable Linktree visibility
grove register list                    # View all linked profiles
grove register remove github           # Unlink a platform
```

## Success Criteria

- `grove profile --json` returns a profile with the claimed handle and links.
- Profile is discoverable via `grove find @olshansky`.
