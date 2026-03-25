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
grove register add website https://olshansky.info --title "Personal Site"
```

**Substack:**

```bash
grove register add website https://olshansky.substack.com --title "Substack"
```

**LinkedIn:**

```bash
grove register add website https://linkedin.com/in/olshansky --title "LinkedIn"
```

**Any custom URL:**

```bash
grove register add website https://example.com/anything --title "My Project"
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
grove register add website https://mycreator.dev --title "Portfolio"
grove register add website https://mycreator.substack.com --title "Newsletter"
grove register list
```

## Error Handling

- **Handle already taken**: Choose a different handle. Handles are unique and first-come-first-served.
- **Register fails**: Verify the platform name is correct (e.g., `x` not `twitter`, `github` not `gh`).
- **Link not showing**: Run `grove register list` to confirm. Links may take a moment to propagate.
- **Wrong URL registered**: Remove it and re-add: `grove register remove <platform>` then `grove register add <platform> <correct-url>`.

## Success Criteria

- `grove profile self --json` returns a profile with the claimed handle and links.
- `grove register list` shows all expected platforms.
- Profile is discoverable via `grove find @yourhandle`.
