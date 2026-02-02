# severity_detection.jq - Detect severity levels from bot comment content
#
# Usage: cat comments.json | jq -f severity_detection.jq
#
# Input: JSON with .comments array containing {bot, body} objects
# Output: Same JSON with severity added to each comment + severity_counts summary
#
# Bot-specific severity markers:
#   CodeRabbit: [critical]/🔴, [major]/🟠, [minor]/🟡, 🧹 Nitpick
#   Greptile: P0/Critical, P1/High, P2/Medium, P3/Low
#   Codex: 🔴 Critical, 🟠 Moderate, 🟡 Minor, 💭 Nitpick
#   Sentry: CRITICAL, HIGH, MEDIUM, LOW
#   Copilot: no markers (defaults to medium)

# Severity detection function
def detect_severity:
  (.body // "") as $body | (.bot // "") as $bot |
  if $bot == "coderabbitai" or $bot == "coderabbitai[bot]" or $bot == "CodeRabbit" then
    if ($body | test("\\[critical\\]|🔴"; "i")) then "critical"
    elif ($body | test("\\[major\\]|🟠"; "i")) then "high"
    elif ($body | test("\\[minor\\]|🟡"; "i")) then "medium"
    elif ($body | test("_🧹 Nitpick_|nitpick"; "i")) then "low"
    else "medium" end
  elif $bot == "greptile" or $bot == "greptile[bot]" or $bot == "greptile-apps[bot]" then
    if ($body | test("\\bP0\\b|\\bCritical\\b"; "i")) then "critical"
    elif ($body | test("\\bP1\\b|\\bHigh\\b"; "i")) then "high"
    elif ($body | test("\\bP2\\b|\\bMedium\\b"; "i")) then "medium"
    elif ($body | test("\\bP3\\b|\\bLow\\b"; "i")) then "low"
    else "medium" end
  elif $bot == "codex" or $bot == "codex-ai[bot]" or $bot == "chatgpt-codex-connector[bot]" then
    if ($body | test("🔴\\s*Critical"; "i")) then "critical"
    elif ($body | test("🟠\\s*Moderate"; "i")) then "high"
    elif ($body | test("🟡\\s*Minor"; "i")) then "medium"
    elif ($body | test("💭\\s*Nitpick"; "i")) then "low"
    else "medium" end
  elif $bot == "sentry" or $bot == "sentry[bot]" then
    if ($body | test("\\bCRITICAL\\b")) then "critical"
    elif ($body | test("\\bHIGH\\b")) then "high"
    elif ($body | test("\\bMEDIUM\\b")) then "medium"
    elif ($body | test("\\bLOW\\b")) then "low"
    else "medium" end
  elif $bot == "Copilot" or $bot == "copilot" then
    "medium"  # Copilot has no severity markers
  else
    "medium"  # Default for unknown bots
  end;

# Ensure .comments exists, then apply severity and add counts
(.comments //= []) |
.comments |= map(. + {severity: detect_severity}) |
.severity_counts = {
  critical: [.comments[] | select(.severity == "critical")] | length,
  high: [.comments[] | select(.severity == "high")] | length,
  medium: [.comments[] | select(.severity == "medium")] | length,
  low: [.comments[] | select(.severity == "low")] | length
}
