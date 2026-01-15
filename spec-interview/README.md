# Spec Interview

Structured requirements interviews for error-free specification documents.

## Features

- **Smart Analysis** — Analyzes existing files, skips clearly defined sections
- **8-Stage Interview** — Comprehensive coverage from problem to prioritization
- **Validation Checklist** — 14-category best practices check before writing
- **Complexity Analysis** — Warns if scope too large, suggests splitting
- **Multi-Language** — Auto-detects 12+ languages

## Installation

```bash
/plugin marketplace add SmartOzzehir/smart-plugins
/plugin install spec-interview
```

## Usage

```bash
/spec-interview "Add dark mode"           # From idea
/spec-interview docs/spec.md              # From existing file
```

## Interview Stages

| Stage | Focus |
|-------|-------|
| 0. Calibration | Technical level, confirm understanding |
| 1. Problem | Pain points, success metrics |
| 2. Users | Personas, stakeholders |
| 3. Functional | CRUD, data, business logic |
| 4. UI/UX | Layout, states |
| 5. Edge Cases | Errors, permissions |
| 6. Non-Functional | Performance, security |
| 7. Technical | Architecture, APIs |
| 8. Prioritization | MVP, phasing |

## Output

Generates a 14-section PRD including:
- Problem statement & success metrics
- User personas & stories
- Functional requirements
- UI/UX specifications
- Edge cases & error handling
- Technical notes
- Dependencies & phasing

## License

MIT
