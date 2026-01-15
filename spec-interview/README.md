# Spec Interview

A Claude Code plugin that conducts structured requirements interviews to create error-free specification documents.

## What It Does

Interviews you about your feature idea or existing spec, asking as many questions as needed until there's 100% clarity. Then generates a comprehensive PRD (Product Requirements Document).

**Core Philosophy:** No question limit. No skipped ambiguity. Loop until fully understood.

## What's New in v3.0

- **Smart Skipping**: Analyzes your file and skips clearly defined sections
- **Pre-Interview Analysis**: Shows what's CLEAR, UNCLEAR, or MISSING before asking questions
- **Context Awareness**: Scans your project for tech stack and patterns
- **Complexity Analysis**: Warns if scope is too large, suggests splitting into phases
- **Enhanced Validation**: 14-category best practices checklist before writing spec
- **Output Options**: Choose where to save, with intelligent split recommendations

## Installation

```bash
# Add the marketplace
/plugin marketplace add SmartOzzehir/smart-plugins

# Install the plugin
/plugin install spec-interview
```

## Usage

```bash
# From an idea
/spec-interview "Add dark mode to the app"

# From existing spec file
/spec-interview docs/phases/phase-10.md

# With language preference
/spec-interview "Add export feature" german
/spec-interview "Yeni özellik ekle" turkish
```

**Supported languages:** English (default), Turkish, German, Spanish, French, Italian, Portuguese, Dutch, Russian, Japanese, Chinese, Korean, Arabic

## How It Works

### 1. Pre-Interview Analysis (File Mode)

When you provide a file, the agent analyzes it first:

```
✅ AUTO-ACCEPTED (clearly defined):
• Problem: Reduce manual data entry time by 50%
• Users: Finance team (5 people), desktop, daily use

⚠️ NEEDS CLARIFICATION:
• Functional: Features listed but missing acceptance criteria

❌ NOT COVERED:
• Edge Cases: No error scenarios discussed

[1] Proceed - focus on gaps only (Recommended)
[2] Refine some accepted items
[3] Start fresh - full interview
```

### 2. Context Scanning

Automatically detects your tech stack from `package.json`, config files, and existing specs. Skips redundant questions.

### 3. Interview Stages (1-8)

| Stage | Focus | What You'll Discuss |
|-------|-------|---------------------|
| 0. Calibration | Your background | Technical level, confirm understanding |
| 1. Problem & Vision | Why build this? | Pain points, success metrics, business context |
| 2. Stakeholders | Who's involved? | Primary users, secondary stakeholders, personas |
| 3. Functional | What should it do? | CRUD actions, data fields, business logic |
| 4. UI/UX | How should it look? | Layout, states (loading/empty/error) |
| 5. Edge Cases | What could go wrong? | Permissions, concurrency, user errors |
| 6. Non-Functional | Quality attributes | Performance, security, accessibility |
| 7. Technical | How to build it? | Data storage, APIs, architecture |
| 8. Prioritization | What comes first? | MVP scope, phasing, dependencies |

### 4. Validation Phase

After 100% understanding, runs a 14-category checklist:

```
VALIDATION COMPLETE

✅ Problem & Vision (5/5)
⚠️ Functional Requirements (5/6)
   └─ Missing: automations/triggers
❌ UI States (2/7)
   └─ Missing: empty state, error state

[1] Add them now
[2] Mark as out-of-scope
[3] Pick which ones to add
```

### 5. Complexity Analysis

For large features, suggests splitting:

```
⚠️ COMPLEXITY: HIGH (Score: 34/30)

Recommended split:
├── Phase 3a: MVP (core CRUD, basic UI)
├── Phase 3b: Integrations (API connections)
└── Phase 3c: Polish (edge cases, UX)
```

## Key Features

- **Smart Skipping**: Doesn't ask about clearly defined items
- **Adaptive Depth**: Adjusts explanations based on your technical level
- **Expert Recommendations**: Suggests optimal choices on every question
- **Ambiguity Handling**: Clarifies immediately, never assumes
- **Validation**: 14-category best practices checklist
- **Complexity Awareness**: Warns about large scopes, suggests splits
- **Output Options**: Update original file, create new, or split into phases

## Output

Generates a complete spec document with 14 sections:

1. Executive Summary & Success Metrics
2. Problem Statement (Current vs Desired State)
3. User Personas
4. User Stories (MoSCoW prioritization)
5. Functional Requirements Table
6. UI/UX Specifications with State Design
7. Edge Cases & Error Handling
8. Non-Functional Requirements
9. Assumptions & Constraints
10. Technical Notes
11. Dependencies
12. Phasing (MVP → Future)
13. Open Questions
14. Appendix

## License

MIT
