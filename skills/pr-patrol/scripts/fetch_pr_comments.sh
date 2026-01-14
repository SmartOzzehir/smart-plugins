#!/bin/bash
# fetch_pr_comments.sh - Comment fetcher for pr-patrol skill
# Usage: ./fetch_pr_comments.sh <owner> <repo> <pr_number>
#
# Returns JSON with:
#   - bot_comments: Original bot comments (in_reply_to_id == null)
#   - user_replies: User replies to bot comments
#   - bot_responses: Bot responses to user replies
#
# Uses external jq file to avoid shell escaping issues
#
# NOTE: Uses sequential fetch to avoid stdout interleaving that corrupts JSON
# when parallel processes write simultaneously. The ~0.8s overhead is acceptable
# for correctness.

set -euo pipefail

OWNER="${1:?Usage: $0 <owner> <repo> <pr_number>}"
REPO="${2:?Usage: $0 <owner> <repo> <pr_number>}"
PR="${3:?Usage: $0 <owner> <repo> <pr_number>}"

# Get script directory for relative jq file path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JQ_FILE="$SCRIPT_DIR/normalize_comments.jq"

# Verify jq file exists
if [[ ! -f "$JQ_FILE" ]]; then
  echo "Error: jq file not found at $JQ_FILE" >&2
  exit 1
fi

# Sequential fetch from both endpoints
# IMPORTANT: Do NOT use parallel { cmd & cmd & wait } pattern here!
# Background processes can interleave stdout bytes, corrupting JSON.

# Fetch PR review comments (line-level)
PR_COMMENTS=$(gh api "repos/$OWNER/$REPO/pulls/$PR/comments" --paginate 2>&1) || {
  echo "Error fetching PR comments: $PR_COMMENTS" >&2
  exit 1
}

# Fetch issue comments (conversation-level)
ISSUE_COMMENTS=$(gh api "repos/$OWNER/$REPO/issues/$PR/comments" --paginate 2>&1) || {
  echo "Error fetching issue comments: $ISSUE_COMMENTS" >&2
  exit 1
}

# Combine and normalize
{
  echo "$PR_COMMENTS"
  echo "$ISSUE_COMMENTS"
} | jq -s -L "$SCRIPT_DIR" -f "$JQ_FILE"
