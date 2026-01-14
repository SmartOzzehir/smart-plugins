# Smart Plugins

Production-ready plugins for Claude Code.

## Available Plugins

| Plugin | Description | Version |
|--------|-------------|---------|
| [pr-patrol](./pr-patrol) | Process PR bot comments with batch validation and 7-gate workflow | v1.4.1 |
| [spec-interview](./spec-interview) | Structured requirements interviews for error-free specs | v2.0.0 |

## Installation

```bash
# Add the marketplace
/plugin marketplace add SmartOzzehir/smart-plugins

# Install plugins
/plugin install pr-patrol
/plugin install spec-interview
```

---

## pr-patrol

Processes PR review bot comments (CodeRabbit, Greptile, Copilot, Codex, Sentry) through a systematic 7-gate workflow.

```bash
/pr-patrol           # Auto-detect PR from current branch
/pr-patrol 123       # Specific PR number
```

**Gates:**
1. **Collect** - Gather bot comments from PR
2. **Analyze** - Categorize and prioritize
3. **Validate** - Check which comments are real issues
4. **Plan** - Design fixes for validated issues
5. **Implement** - Apply fixes
6. **Verify** - Confirm fixes work
7. **Complete** - Mark resolved

---

## spec-interview

Conducts structured requirements interviews to create comprehensive PRD documents.

```bash
/spec-interview "Add dark mode"              # From idea
/spec-interview docs/spec.md                 # From existing file
/spec-interview "Nueva función" spanish      # With language
```

**How it works:**
- Asks as many questions as needed (no limit)
- Never skips ambiguity - clarifies immediately
- Provides expert recommendations on every question
- Adapts explanations to your technical level
- Outputs a complete 13-section PRD

**8 Interview Stages:**
1. Problem & Vision
2. Stakeholders & Users
3. Functional Requirements
4. UI/UX Design
5. Edge Cases
6. Non-Functional Requirements
7. Technical Architecture
8. Prioritization & Phasing

**Supports:** English, Turkish, German, Spanish, French, Italian, Portuguese, Dutch, Russian, Japanese, Chinese, Korean, Arabic

---

## License

MIT - [LICENSE](./LICENSE)

## Author

[SmartOzzehir](https://github.com/SmartOzzehir)
