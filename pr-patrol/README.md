# PR Patrol

Handle PR bot comments (CodeRabbit, Greptile, Copilot, Codex, Sentry) with batch validation and a 7-gate workflow.

## Features

- **Batch Validation** — Validate multiple bot comments in parallel
- **7-Gate Workflow** — Structured process with user approval at each step
- **State Persistence** — Track progress across review cycles
- **Bot-Specific Protocols** — Correct reply format per bot

## Supported Bots

| Bot | Reply | Reaction |
|-----|-------|----------|
| CodeRabbit | ✅ | ❌ |
| Greptile | ✅ | ✅ |
| Copilot | ❌ | ❌ |
| Codex | ✅ | ✅ |
| Sentry | ✅ | ✅ |

## Prerequisites

- [GitHub CLI](https://cli.github.com/) (`gh`) — authenticated
- [jq](https://jqlang.github.io/jq/) 1.6+
- GNU coreutils (macOS: `brew install coreutils`)

## Installation

```bash
/plugin marketplace add SmartOzzehir/smart-plugins
/plugin install pr-patrol
```

## Usage

```bash
/pr-patrol           # Auto-detect PR from branch
/pr-patrol 123       # Specific PR number
```

## Workflow

```
Gate 0: Init      → Detect PR, load state
Gate 1: Collect   → Fetch bot comments
Gate 2: Validate  → Check which are real issues
Gate 3: Fix       → Design and apply fixes
Gate 4: Commit    → Create commit
Gate 5: Reply     → Post replies to bots
Gate 6: Push      → Push and check for new comments
```

## License

MIT
