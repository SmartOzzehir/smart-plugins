---
description: "Interview user to gather detailed requirements for a spec document or feature idea"
argument-hint: "[file-path-or-idea]"
allowed-tools: Read, Write, Edit, AskUserQuestion, Glob, Grep, Bash
---

# Spec Interview Command

Load and execute the spec-interview skill with the provided arguments.

## Usage

```
/spec-interview docs/phases/phase-10.md
/spec-interview "Add export button to dashboard"
/spec-interview "Nueva función de exportación"
```

## Execution

Invoke the spec-interview skill to conduct a structured requirements interview.

**Arguments passed to skill:**
- `$1` = File path to existing spec OR idea description in quotes

**Language:** Auto-detected from input text. Supports English, Turkish, German, Spanish, French, Italian, Portuguese, Dutch, Russian, Japanese, Chinese, Korean, and Arabic.

The skill will automatically:
1. Detect input mode (FILE or IDEA based on argument format)
2. Analyze existing document (smart skipping for clear sections)
3. Scan project context for tech stack and patterns
4. Conduct adaptive interview focusing on gaps
5. Validate against 14-category best practices checklist
6. Analyze complexity and suggest splits if needed
7. Write/update the spec document
