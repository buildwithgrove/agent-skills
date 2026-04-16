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
2. **Setup Linktree**: Link social identities and websites (see Supported Platforms below).
3. **Enhance Profile**: Add a bio with `grove profile update --bio "..."`.
4. **Visibility**: Ensure the profile is public with `grove profile update --public`.
5. **Verify**: Run `grove register list` to confirm all links are registered.

## Key Commands

**Claim a unique handle:**

```bash
grove profile claim olshansky
```

**Set your bio:**

```bash
grove profile update --bio "Building open-source tools for the creator economy"
```

**Make your profile public:**

```bash
grove profile update --public
```

**View all registered links:**

```bash
grove register list
```

**Remove a link:**

```bash
grove register remove github
```

## Supported Platforms

**Twitter / X:**

```bash
grove register add x @olshansky
```

**GitHub:**

```bash
grove register add github olshansky
```

**YouTube:**

```bash
grove register add youtube @olshansky
```

**Website / Blog:**

```bash
grove register add website https://olshansky.info
```

**Substack:**

```bash
grove register add website https://olshansky.substack.com
```

**LinkedIn:**

```bash
grove register add website https://linkedin.com/in/olshansky
```

**Facebook:**

```bash
grove register add facebook https://facebook.com/olshansky
```

**Instagram:**

```bash
grove register add instagram https://instagram.com/olshansky
```

**Bluesky (manual-only):**

As of April 2025, Bluesky is manual-only verification — no OAuth flow. Register as a website link:

```bash
grove register add website https://bsky.app/profile/handle.bsky.social
```

**Any custom URL:**

```bash
grove register add website https://example.com/anything
```

## Building a Complete Linktree

A well-built Linktree increases discoverability and tips. Register all platforms where you create content:

```bash
grove profile claim mycreator
grove profile update --bio "Writer and developer. Tip me to support my open-source work."
grove profile update --public
grove register add x @mycreator
grove register add github mycreator
grove register add youtube @mycreator
grove register add website https://mycreator.dev
grove register add website https://mycreator.substack.com
grove register add facebook https://facebook.com/mycreator
grove register add instagram https://instagram.com/mycreator
grove register list
```

## Error Handling

- **Handle already taken**: Choose a different handle. Handles are unique and first-come-first-served.
- **Register fails**: Verify the platform name is correct (e.g., `x` not `twitter`, `github` not `gh`).
- **Link not showing**: Run `grove register list` to confirm. Links may take a moment to propagate.
- **Wrong URL registered**: Remove it and re-add: `grove register remove <platform>` then `grove register add <platform> <correct-url>`.

## Handle & Identity API

For programmatic handle and identity management beyond the CLI:

**Handle rules:** 3-15 characters, lowercase alphanumeric + underscore. Cannot start/end with underscore or have consecutive underscores. Reserved words (admin, grove, support, etc.) are blocked.

**Claim a handle:**

```bash
GROVE_API_KEY=$(grep GROVE_API_KEY ~/.grove/.env | cut -d= -f2)
curl -s -X POST "https://api.grove.city/v1/account/handle" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"handle": "myhandle"}'
```

**Release a handle:**

```bash
curl -s -X DELETE "https://api.grove.city/v1/account/handle" \
  -H "Authorization: Bearer $GROVE_API_KEY"
```

**Link a secondary identity (email/SMS):**

```bash
curl -s -X POST "https://api.grove.city/v1/account/identities/verify" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"cdp_token": "token-from-cdp-auth"}'
```

**List linked identities:**

```bash
curl -s "https://api.grove.city/v1/account/identities" \
  -H "Authorization: Bearer $GROVE_API_KEY"
```

**Remove an identity:**

```bash
curl -s -X DELETE "https://api.grove.city/v1/account/identities/{identity_id}" \
  -H "Authorization: Bearer $GROVE_API_KEY"
```

## Success Criteria

- `grove profile self --json` returns a profile with the claimed handle and links.
- `grove register list` shows all expected platforms.
- Profile is discoverable via `grove find @yourhandle`.
