# bot-detection.jq - Shared bot detection functions for pr-patrol
# Usage: include "bot-detection"; (requires jq -L $SCRIPT_DIR)

# Bots to IGNORE (deployment/CI bots, not code reviewers)
def is_ignored_bot:
  if . == null then false
  else
    . as $login |
    ($login | ascii_downcase) as $lower |
    ["vercel[bot]", "dependabot[bot]", "renovate[bot]", "github-actions[bot]"] |
    any(. == $lower)
  end;

# Review bot detection (bots that provide code review feedback)
def is_review_bot:
  if . == null then false
  else
    . as $login |
    ($login | test("coderabbit|greptile|codex|sentry"; "i")) or
    ($login == "Copilot") or
    ($login == "chatgpt-codex-connector[bot]")
  end;
