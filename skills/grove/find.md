# Find Module

The find module resolves search queries into tippable destinations and reveals creator Linktrees.

## Scope

- `grove find`
- `grove check`
- `grove profile <handle>`

## Required Execution Loop

1. **Discovery**: Search for a creator using a handle, name, or URL: `grove find <query>`.
2. **Resolution**: Extract the canonical destination and tippable status from the response.
3. **Verification**: Run `grove check <destination> --json` to confirm payment options (token + chain combinations).
4. **Inspection**: To see more links and stats for a creator, use `grove profile show @<handle>`.

## Key Commands

**Find a creator by various identifiers:**

```bash
grove find fred --json
grove find @ArtSabintsev --json
grove find fredt.io --json
grove find youtube.com/@handle --json
```

**Verify a destination can receive tips (lighter than find):**

```bash
grove check olshansky.info --json
grove check @fred --json
grove check 0x1234...abcd --json
```

**View a creator's full public profile:**

```bash
grove profile show @olshansky
grove profile show @olshansky --json
```

## Find vs Check

- **`grove find`**: Discovery — search by name, handle, URL. Returns profile info and tippable status.
- **`grove check`**: Verification — confirm a specific destination can receive tips. Returns available payment options (token + chain combinations) and wallet addresses.

Use `grove find` when you don't know the exact destination.
Use `grove check` when you have a destination and want to verify it before tipping.

## Error Handling

- **Creator not found**: Try alternative formats — domain (`fredt.io`), handle (`@fred`), Twitter URL (`x.com/fred`), full URL.
- **Not tippable**: The destination exists but has no payment address configured. Try a different identifier for the same creator.
- **API error**: Check connectivity with `grove config show`. The `grove check` endpoint does not require authentication.

## Content Discovery

The find module discovers **people**. To discover a creator's **content** across platforms (YouTube, Bluesky, Reddit, Medium, Substack, GitHub), see the **[Feed module](./feed.md)**.

## Success Criteria

- `grove find --json` or `grove check --json` returns `tippable: true`.
- Resolved `destination` is ready for the `tip` module.
