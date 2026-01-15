# Changelog

## [1.1.0] - 2026-01-15

### Added

- **Workflow Enforcement Hooks** — 5 hooks to ensure correct workflow execution:
  - `PreToolUse` on Edit/Write: Verify gate file read + AskUserQuestion approval
  - `PreToolUse` on Bash: Block Copilot replies, enforce @mention, short format
  - `PreToolUse` on Task: Enforce bot-comment-validator for validation
  - `PostToolUse`: Verify state file updates
  - `Stop`: Check workflow completion
- **14 Critical Rules** in SKILL.md (expanded from 6)
- **Workflow Reference Archive** — `docs/workflow-reference.md`

### Changed

- **Command file refactored** — Converted to thin loader (560 → 83 lines)
- Gate files now primary source of workflow instructions
- Hooks enforce reading gate files before actions

### Fixed

- Claude skipping gate files and following inline workflow
- Missing AskUserQuestion checkpoints
- Verbose essay-style replies instead of short format
- Copilot receiving replies (should be silent fix only)
- Embedded CodeRabbit comments being missed

## [1.0.0] - 2026-01-15

Initial release.

### Features

- **7-Gate Workflow** — Structured process: Init → Collect → Validate → Fix → Commit → Reply → Push
- **Batch Validation** — Validate multiple bot comments in parallel using specialized agents
- **5 Bot Support** — CodeRabbit, Greptile, Copilot, Codex, Sentry with bot-specific protocols
- **State Persistence** — Track progress in `.claude/bot-reviews/PR-{number}.md`
- **False Positive Detection** — Identify and dismiss incorrect suggestions
- **Cross-Platform** — Linux, macOS (with coreutils), Windows (WSL)
