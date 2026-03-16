# Find Module

The find module resolves search queries into tippable destinations and reveals creator Linktrees.

## Scope

- `grove find`
- `grove profile <handle>`

## Required Execution Loop

1. **Discovery**: Search for a creator using a handle, name, or URL: `grove find <query>`.
2. **Resolution**: Extract the canonical destination (URL) and tippable status from the response.
3. **Inspection**: To see more links and stats for a creator, use `grove profile <handle>`.

## Key Commands

```bash
grove find alice                       # Find creator by handle
grove find @olshansky                  # Find creator by Twitter handle
grove find olshansky.info              # Find creator by domain
grove profile alice                    # View alice's full Linktree
```

## Success Criteria

- `grove find --json` returns `tippable: true`.
- Resolved `destination` is ready for the `tip` module.
