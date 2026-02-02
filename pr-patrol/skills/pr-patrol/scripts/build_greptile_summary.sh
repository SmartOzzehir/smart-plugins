#!/usr/bin/env bash
#
# build_greptile_summary.sh
# Build a consolidated @greptile-apps summary comment for the current cycle
#
# Usage: build_greptile_summary.sh <state_file> <cycle_number>
#
# Reads the state file and generates a markdown summary with:
#   - @greptile-apps mention (so Greptile sees and learns from it)
#   - List of fixed issues with commit SHA
#   - List of false positives with reasoning
#   - Cycle statistics
#
# Output: Markdown string ready to post as issue comment

set -euo pipefail

STATE_FILE="${1:-}"
CYCLE="${2:-1}"

if [[ -z "$STATE_FILE" || ! -f "$STATE_FILE" ]]; then
  echo "Error: State file not found: $STATE_FILE" >&2
  exit 1
fi

# Extract frontmatter values
PR_NUMBER=$(grep "^pr_number:" "$STATE_FILE" | cut -d' ' -f2 || true)
if [[ -z "$PR_NUMBER" ]]; then
  echo "Error: pr_number not found in state file: $STATE_FILE" >&2
  exit 1
fi
COMMIT_SHA=$(grep "^last_push_commit:" "$STATE_FILE" | head -1 | cut -d' ' -f2 || true)
[[ -z "$COMMIT_SHA" ]] && COMMIT_SHA="unknown"

# Count FIXED items (lines with ✅ in Fix Applied column)
# grep returns 1 if no matches, which is not an error for us
FIXED_COUNT=$(grep -c "| ✅" "$STATE_FILE" || true)
[[ -z "$FIXED_COUNT" ]] && FIXED_COUNT=0

# Count FALSE_POSITIVE items using flag-based approach
# (awk range /START/,/END/ self-terminates when END matches START line)
FP_COUNT=$(awk '
  /^### FALSE_POSITIVE/ { in_section=1; next }
  in_section && /^###/ { in_section=0 }
  in_section && /^\| [^-]/ && !/^\| ID/ { count++ }
  END { print count+0 }
' "$STATE_FILE" || true)
[[ -z "$FP_COUNT" || "$FP_COUNT" -lt 0 ]] && FP_COUNT=0

# Extract fixed issues (file and summary from VALID/FIXED table)
# Table: | ID | Bot | File | Severity | Summary | Fix Applied |
# Split by |: cols[1]="" [2]=ID [3]=Bot [4]=File [5]=Severity [6]=Summary [7]=Fix
FIXED_LIST=$(awk '
  /^### (FIXED|VALID)/ { in_section=1; next }
  in_section && /^###/ { in_section=0 }
  in_section && /^\| [^-]/ && !/^\| ID/ {
    split($0, cols, "|")
    gsub(/^[ \t]+|[ \t]+$/, "", cols[4])  # File
    gsub(/^[ \t]+|[ \t]+$/, "", cols[6])  # Summary
    if (cols[4] != "" && cols[6] != "") {
      print "- `" cols[4] "`: " cols[6]
    }
  }
' "$STATE_FILE" || true)

# Extract false positives
# Table: | ID | Bot | File | Summary | Reason |
# Split by |: cols[1]="" [2]=ID [3]=Bot [4]=File [5]=Summary [6]=Reason
FP_LIST=$(awk '
  /^### FALSE_POSITIVE/ { in_section=1; next }
  in_section && /^###/ { in_section=0 }
  in_section && /^\| [^-]/ && !/^\| ID/ {
    split($0, cols, "|")
    gsub(/^[ \t]+|[ \t]+$/, "", cols[4])  # File
    gsub(/^[ \t]+|[ \t]+$/, "", cols[5])  # Summary
    gsub(/^[ \t]+|[ \t]+$/, "", cols[6])  # Reason
    if (cols[4] != "" && cols[5] != "") {
      print "- `" cols[4] "`: " cols[5] " — _" cols[6] "_"
    }
  }
' "$STATE_FILE" || true)

# Build the summary comment
cat << EOF
@greptile-apps

## PR #${PR_NUMBER} - Cycle ${CYCLE} Summary

Thank you for the code review! Here's a summary of how we addressed the feedback:

### ✅ Fixed Issues (${FIXED_COUNT})
${FIXED_LIST:-_No issues fixed in this cycle._}

### ❌ False Positives (${FP_COUNT})
${FP_LIST:-_No false positives identified._}

---
**Commit:** \`${COMMIT_SHA}\`
**Cycle:** ${CYCLE}
EOF
