# Gate 3: Fix Plan & Apply

**Previous status:** `validated`
**Status to set:** `fixes_planned` → `fixes_applied` → `checks_passed`

---

## What This Phase Does

1. Design fix plan using `pr-fix-architect` agent
2. Get user approval for fixes
3. Apply fixes using `pr-implementer` agent
4. Run mandatory checks (typecheck, lint)
5. **ASK about pr-review-toolkit agents** (Gate 3.5)

---

## Step 1: Design Fix Plan

Use `pr-fix-architect` agent for complex fixes:

```xml
<Task>
  <subagent_type>pr-fix-architect</subagent_type>
  <description>Design fix for comment #123456</description>
  <prompt>
Design a fix for this validated issue:

File: src/components/customers/customer-list.tsx
Line: 246
Issue: getRegionLabel is called with customer.region (text code) but expects UUID
Suggested fix: Use customer.regionId ?? customer.region

Create a detailed fix specification with:
- Exact code changes needed
- Any related files that might need updates
- Trade-off analysis if multiple approaches exist
  </prompt>
</Task>
```

---

## MANDATORY AskUserQuestion (Fix Plan)

```
Header: "Fix Plan"
Question: "Fix plan ready for {count} issues across {files} files. Apply?"
Options:
├── "Yes, apply all fixes"
├── "Show detailed plan"
├── "Exclude high-risk changes"
├── "Modify plan"
├── "Cancel fixes"
```

---

## Step 2: Apply Fixes

Use `pr-implementer` agent or apply directly:

```xml
<Task>
  <subagent_type>pr-implementer</subagent_type>
  <description>Apply fix for comment #123456</description>
  <prompt>
Apply this approved fix:

File: src/components/customers/customer-list.tsx
Line: 246
Change: Replace `getRegionLabel(customer.region)` with `getRegionLabel(customer.regionId ?? customer.region)`

Apply the exact code change and verify correctness.
  </prompt>
</Task>
```

Update status: `fixes_applied`

---

## Step 3: Run Mandatory Checks

These checks are **MANDATORY** - block on failure:

Detect the project's toolchain from `package.json` scripts, then run:

1. **Typecheck** — e.g., `pnpm typecheck`, `npm run typecheck`, `npx tsc --noEmit`
2. **Lint with auto-fix** — e.g., `pnpm lint --fix`, `npx biome check --write src/`, `npx eslint --fix .`

If either fails: **BLOCK** — fix the errors before proceeding. Do NOT continue to Gate 4 with failing checks.

---

## Step 4: Gate 3.5 - PR Review Agents (MANDATORY QUESTION!)

**CRITICAL: You MUST ask this question after checks pass!**

```
Header: "Quality Checks"
Question: "Checks passed. Run additional review?"
Options:
├── "Quick checks only (done)" [Recommended]
├── "Run code-reviewer agent"
├── "Run silent-failure-hunter agent"
├── "Run both"
```

### If User Selects Review Agents

```xml
<!-- code-reviewer -->
<Task>
  <subagent_type>pr-review-toolkit:code-reviewer</subagent_type>
  <description>Review recent changes</description>
  <prompt>Review the unstaged changes in git for adherence to project guidelines.</prompt>
</Task>

<!-- silent-failure-hunter -->
<Task>
  <subagent_type>pr-review-toolkit:silent-failure-hunter</subagent_type>
  <description>Check error handling</description>
  <prompt>Review the recent changes for silent failures and inadequate error handling.</prompt>
</Task>
```

Update status: `checks_passed`

---

## Edge Cases

| Case | Detection | Action |
|------|-----------|--------|
| Schema change detected | File is `schema.ts` or `migrations/` | **BLOCK**: Manual required |
| Fix outside PR scope | Path not in PR files | Warning + confirm |
| Circular dependency | Fix A needs B, B needs A | Single transaction |
| No fixes possible | All "won't fix" | Skip to Gate 5 |
| Fix apply failed | Edit tool error | Retry/Skip/Abort |
| Typecheck fails | Exit code != 0 | **BLOCK**: Must fix |
| Lint auto-fix fails | Still errors after `--write` | **BLOCK**: Manual fix |
| Pre-existing errors | Errors in untouched files | Warning, continue |
| New errors from fixes | Errors in modified lines | **BLOCK**: Must fix |

---

## State File Update

Update status progression and billboard:

```bash
SCRIPTS="${CLAUDE_PLUGIN_ROOT}/skills/pr-patrol/scripts"
STATE_FILE=".claude/bot-reviews/PR-${PR}.md"

# After plan approval
"$SCRIPTS/update_state.sh" "$STATE_FILE" status fixes_planned

# After fixes applied
"$SCRIPTS/update_state.sh" "$STATE_FILE" status fixes_applied

# After checks pass - update billboard for Gate 4
"$SCRIPTS/update_billboard.sh" "$STATE_FILE" "checks_passed" "4" "Review changes and create commit"
```

---

## After This Phase

1. ✅ Billboard updated: `status: checks_passed`, `next_gate: 4`
2. **IMMEDIATELY** read: `phases/gate-4-commit.md`
3. Do NOT stop or wait - continue to Gate 4!
