#!/usr/bin/env bash
# init_state.sh - Initialize spec interview state file
# Usage: ./init_state.sh <spec_id> [language]
#
# Examples:
#   ./init_state.sh "dashboard-export"
#   ./init_state.sh "user-auth" "tr"

set -euo pipefail

# Platform detection - need GNU date for -Iseconds flag
if date --version &>/dev/null; then
  DATE_CMD="date"
elif command -v gdate &>/dev/null; then
  DATE_CMD="gdate"
else
  echo "ERROR: GNU date required. On macOS: brew install coreutils" >&2
  echo "Windows users: Use WSL" >&2
  exit 1
fi

SPEC_ID="${1:?Usage: $0 <spec_id> [language]}"
LANGUAGE="${2:-en}"

# Sanitize spec_id for filename (remove spaces, special chars)
SAFE_ID=$(echo "$SPEC_ID" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')

# Create directory if needed
STATE_DIR=".claude/spec-interviews"
mkdir -p "$STATE_DIR"

STATE_FILE="${STATE_DIR}/${SAFE_ID}.md"

# Check if file already exists
if [[ -f "$STATE_FILE" ]]; then
  echo "State file already exists: $STATE_FILE"
  echo "Use --force to overwrite or choose a different spec_id"
  exit 1
fi

TIMESTAMP=$($DATE_CMD -Iseconds)

# Create state file
cat > "$STATE_FILE" << EOF
---
spec_id: "${SPEC_ID}"
current_phase: 0
status: initialized
tech_level: ""
language: "${LANGUAGE}"
created: "${TIMESTAMP}"
last_updated: "${TIMESTAMP}"
---

# Spec Interview: ${SPEC_ID}

## Progress

| Phase | Status | Summary |
|-------|--------|---------|
| 0. Init | ✅ | Session created |
| 0.5 Calibration | ⏳ | Pending |
| 1. Problem & Vision | ⬜ | - |
| 2. Users & Stakeholders | ⬜ | - |
| 3. Functional | ⬜ | - |
| 4. UI/UX | ⬜ | - |
| 5. Edge Cases | ⬜ | - |
| 6. Non-Functional | ⬜ | - |
| 7. Technical | ⬜ | - |
| 8. Prioritization | ⬜ | - |
| 9. Validation | ⬜ | - |
| 10. Output | ⬜ | - |

---

## Phase 0.5: Calibration

(Pending tech level assessment)

---

## Phase 1: Problem & Vision

(Not started)

---

## Phase 2: Users & Stakeholders

(Not started)

---

## Phase 3: Functional Requirements

(Not started)

---

## Phase 4: UI/UX Design

(Not started)

---

## Phase 5: Edge Cases & Error Handling

(Not started)

---

## Phase 6: Non-Functional Requirements

(Not started)

---

## Phase 7: Technical Architecture

(Not started)

---

## Phase 8: Prioritization & Phasing

(Not started)

---

## Validation Results

(Pending - runs after all phases complete)

---

## Output

- **Spec file:** (not yet generated)
- **Complexity:** (not yet calculated)
EOF

echo "Created: $STATE_FILE"
echo "Spec ID: $SPEC_ID"
echo "Language: $LANGUAGE"
