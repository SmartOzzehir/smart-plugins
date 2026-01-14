# Spec Interview

A Claude Code plugin that conducts structured requirements interviews to create error-free specification documents.

## What It Does

Interviews you about your feature idea or existing spec, asking as many questions as needed until there's 100% clarity. Then generates a comprehensive PRD (Product Requirements Document).

**Core Philosophy:** No question limit. No skipped ambiguity. Loop until fully understood.

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

## Interview Stages

| Stage | Focus | What You'll Discuss |
|-------|-------|---------------------|
| 0. Calibration | Your background | Technical level, confirm understanding |
| 1. Problem & Vision | Why build this? | Pain points, success metrics, business context |
| 2. Stakeholders | Who's involved? | Primary users, secondary stakeholders, personas |
| 3. Functional | What should it do? | CRUD actions, data fields, business logic, integrations |
| 4. UI/UX | How should it look? | Layout, states (loading/empty/error), responsive design |
| 5. Edge Cases | What could go wrong? | Permissions, concurrency, network issues, user errors |
| 6. Non-Functional | Quality attributes | Performance, security, accessibility, compliance |
| 7. Technical | How to build it? | Data storage, APIs, architecture (ELI5 for non-technical) |
| 8. Prioritization | What comes first? | MVP scope, phasing, dependencies, timeline |

## Key Features

- **Adaptive Depth**: Adjusts explanations based on your technical level
- **Expert Recommendations**: Agent suggests optimal choices on every question
- **Ambiguity Handling**: Clarifies immediately, never assumes
- **Comprehensive Output**: 13-section PRD with everything developers need

## Output

Generates a complete spec document with:

- Executive Summary & Success Metrics
- Problem Statement (Current vs Desired State)
- User Personas
- User Stories (MoSCoW prioritization)
- Functional Requirements Table
- Data Requirements with Validation Rules
- UI/UX Specifications with State Design
- Edge Cases & Error Handling
- Non-Functional Requirements (Performance, Security, Accessibility)
- Technical Notes
- Dependencies
- Phasing (MVP → Future)
- Open Questions

## License

MIT
