---
name: grove-agent-skills-update
description: >-
  Audit the grove_api repo for changes since the last skill update, then generate
  a plan to sync agent skills — covering missing features, breaking changes,
  deprecated endpoints, and new skill opportunities.
disable-model-invocation: true
---

# Grove Agent Skills Update <!-- omit in toc -->

Systematically compare the Grove API source code against the current agent skills to find gaps, then produce an actionable update plan.

- [Inputs](#inputs)
- [Phase 1: Determine Baseline](#phase-1-determine-baseline)
- [Phase 2: Audit API Changes](#phase-2-audit-api-changes)
- [Phase 3: Diff Against Current Skills](#phase-3-diff-against-current-skills)
- [Phase 4: Produce the Plan](#phase-4-produce-the-plan)
- [Phase 5: Execute (Optional)](#phase-5-execute-optional)
- [Output Format](#output-format)
- [Tips](#tips)

## Inputs

| Input | Default | Description |
|-------|---------|-------------|
| Skills repo | `/Users/olshansky/workspace/grove/agent-skills` | The agent-skills repo with `skills/grove/` |
| API repo | `/Users/olshansky/workspace/grove/grove_api` | The Grove API source code |
| Since date | Last commit date in skills repo | How far back to look for API changes |

## Phase 1: Determine Baseline

1. **Find the last skill update date:**

```bash
cd /Users/olshansky/workspace/grove/agent-skills
git log -1 --format="%ci" -- skills/grove/
```

2. **Read current skill version:**

```bash
head -15 skills/grove/SKILL.md
```

3. **List all current skill modules:**

```bash
ls skills/grove/*.md
```

4. **Capture current module topics** — read each module's `## Scope` or first section to understand what's already documented.

## Phase 2: Audit API Changes

1. **Get the API changelog since baseline:**

```bash
cd /Users/olshansky/workspace/grove/grove_api
git log --oneline --since="<baseline-date>" -- .
```

2. **Identify new/changed endpoints** — look at route definitions:

```bash
# FastAPI routes
rg "(@app\.|@router\.)" --type py -l
rg "(@app\.|@router\.)(get|post|put|patch|delete)" --type py -C 2
```

3. **Identify new models/schemas** — look at Pydantic models:

```bash
rg "class \w+\(.*BaseModel\)" --type py
```

4. **Check for breaking changes:**

```bash
# Removed or renamed endpoints
git diff <baseline-commit>..HEAD --stat -- "*.py" | head -30

# Deleted files
git diff <baseline-commit>..HEAD --diff-filter=D --name-only

# Changed request/response schemas
git log --oneline --since="<baseline-date>" --grep="breaking\|remove\|deprecat\|rename" --all
```

5. **Check for new features in commit messages:**

```bash
git log --oneline --since="<baseline-date>" --grep="feat\|feature\|add\|new" --all
```

6. **Review key directories for changes:**

```bash
# API routes
git diff <baseline-commit>..HEAD --stat -- app/api/ app/routes/ routes/

# Models/schemas
git diff <baseline-commit>..HEAD --stat -- app/models/ app/schemas/

# Core services
git diff <baseline-commit>..HEAD --stat -- app/services/ app/core/
```

## Phase 3: Diff Against Current Skills

For each API capability found in Phase 2, check if it's covered in the skills:

1. **Map endpoints to skill modules:**

| Endpoint pattern | Expected skill module |
|---|---|
| `/v1/tip/*` | `tip.md`, `message.md` |
| `/v1/account/*` | `register.md`, `earn.md`, `onboard.md` |
| `/v1/feed/*` | `feed.md` |
| `/v1/find/*`, `/v1/check/*` | `find.md` |
| `/v1/wallet/*`, `/v1/setup/*` | `onboard.md` |
| `/v1/account/webhook/*` | `register.md` (stream alerts) |
| `/v1/account/profile` | `register.md`, `earn.md` |

2. **For each new/changed endpoint, classify:**

- **Missing**: Endpoint exists in API but has no skill coverage → needs new content
- **Outdated**: Endpoint changed but skill still documents old behavior → needs update
- **Breaking**: Endpoint removed or request/response changed incompatibly → needs fix
- **Covered**: Endpoint is already documented accurately → no action

3. **Check CLI support:**

```bash
grove --help 2>/dev/null
grove tip --help 2>/dev/null
grove find --help 2>/dev/null
```

For features without CLI support, note that `curl` API fallbacks are needed using:

```bash
GROVE_API_KEY=$(grep GROVE_API_KEY ~/.grove/.env | cut -d= -f2)
curl -s -X <METHOD> "https://api.grove.city/v1/<path>" \
  -H "Authorization: Bearer $GROVE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '<body>'
```

## Phase 4: Produce the Plan

Generate a structured plan saved to:

```
plans/grove-skills-update_<YYYY>_<MM>_<DD>.md
```

The plan must include:

### 4a. Summary

- Date range audited
- Number of new endpoints found
- Number of breaking changes
- Number of skills affected

### 4b. New Skills/Modules

For each new module:
- **File**: `skills/grove/<name>.md`
- **Why**: What API feature it covers
- **Key endpoints**: List the routes
- **CLI support**: Yes/No (if No, document curl fallback)

### 4c. Skill Updates

For each existing module that needs changes:
- **File**: `skills/grove/<name>.md`
- **Changes**: Bullet list of what to add/modify/remove
- **Why**: What API change drives this

### 4d. Deprecations/Removals

For each skill or section to remove:
- **File**: `skills/grove/<name>.md`
- **Section**: What to remove
- **Why**: Endpoint removed or replaced

### 4e. SKILL.md Updates

- Version bump recommendation
- New modules to add to the index
- New trigger phrases/keywords
- Description updates

### 4f. Implementation Order

Ordered list of changes with dependencies noted.

### 4g. Verification Steps

```bash
make test           # Validate frontmatter
make link-skills    # Update symlinks
# Test commands against live API
# Verify cross-references
```

## Phase 5: Execute (Optional)

If the user approves the plan, execute it:

1. Create new module files
2. Edit existing modules
3. Update `SKILL.md` (version, modules, triggers)
4. Run `make test`
5. Run `make link-skills`

Ask for confirmation before executing. Present the plan first and wait for approval.

## Output Format

End the audit with a summary table:

```
| Module | Action | Reason |
|--------|--------|--------|
| message.md | CREATE | Tip to Talk API |
| feed.md | CREATE | Creator Feed API |
| register.md | UPDATE | Facebook, Instagram, stream alerts |
| tip.md | UPDATE | Tip-with-message reference |
| ... | ... | ... |
```

## Tips

- Always check `git log` in the API repo first — commit messages are the fastest signal
- Look at test files for new endpoints — they often document request/response shapes
- Check for new environment variables or config that skills should mention
- If the API repo isn't available locally, ask the user for the remote URL or check GitHub
- The Grove CLI lags behind the API — always verify CLI support before documenting CLI commands
- When in doubt about an endpoint's behavior, read the route handler and its tests
