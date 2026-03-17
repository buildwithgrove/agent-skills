# Find Module

The find module resolves search queries into tippable destinations and reveals creator Linktrees.

## Scope

- `grove find`
- `grove profile <handle>`

## Required Execution Loop

1. **Discovery**: Search for a creator using a handle, name, or URL: `grove find <query>`. Examples: _"can I tip fred?"_, _"does arthur have a tippable address?"_
2. **Resolution**: Extract the canonical destination (URL) and tippable status from the response.
3. **Inspection**: To see more links and stats for a creator, use `grove profile <handle>`.

## Key Commands

```bash
grove find fred                        # Find creator by handle
grove find @ArtSabintsev               # Find creator by Twitter handle
grove find fredt.io                    # Find creator by domain
grove profile olshansky                # View olshansky's full Linktree
```

## Success Criteria

- `grove find --json` returns `tippable: true`.
- Resolved `destination` is ready for the `tip` module.
