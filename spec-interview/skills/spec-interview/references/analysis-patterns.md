# Analysis Patterns

How to analyze existing files and project context for smart interviewing.

---

## Pre-Interview File Analysis

When user provides a file path, analyze its content before starting interview.

### Stage Mapping

Map file content to the 8 interview stages:

| Stage | Look For |
|-------|----------|
| 1. Problem & Vision | "problem", "goal", "why", "pain point", "objective", "success", "metric" |
| 2. Stakeholders | "user", "persona", "role", "audience", "who", "stakeholder" |
| 3. Functional Reqs | "feature", "must", "should", "requirement", "action", "CRUD", "workflow" |
| 4. UI/UX | "screen", "page", "layout", "component", "design", "navigation", "UI" |
| 5. Edge Cases | "error", "edge", "what if", "fail", "exception", "invalid" |
| 6. Non-Functional | "performance", "security", "scale", "compliance", "accessibility" |
| 7. Technical | "stack", "database", "API", "architecture", "integration", "tech" |
| 8. Prioritization | "MVP", "phase", "priority", "P0", "P1", "scope", "timeline" |

### Classification Criteria

For each stage, classify as:

**CLEAR** (skip this stage):
- Specific, concrete details provided
- No ambiguous language ("maybe", "probably", "might")
- Measurable criteria where applicable
- Complete sentences/descriptions

Example of CLEAR:
```
Users: Internal finance team (5 people), daily usage, desktop only
```

**UNCLEAR** (ask targeted questions):
- Topic mentioned but vague
- Missing specific details
- Ambiguous language present
- Partial information

Example of UNCLEAR:
```
Users: Finance team
```
→ Missing: How many? How often? What devices?

**MISSING** (full stage questions):
- Topic not mentioned at all
- No relevant keywords found
- Entire section absent

### Analysis Output Format

```
FILE ANALYSIS: {file_path}

Content Summary:
- Total lines: {N}
- Sections found: {list}
- Overall completeness: {percentage}

Stage Coverage:
| Stage | Status | Details |
|-------|--------|---------|
| 1. Problem & Vision | ✅ CLEAR | Problem defined, metrics specified |
| 2. Stakeholders | ⚠️ UNCLEAR | Users mentioned, no details |
| 3. Functional Reqs | ⚠️ UNCLEAR | Some features listed, no acceptance criteria |
| 4. UI/UX | ❌ MISSING | No UI information |
| 5. Edge Cases | ❌ MISSING | No error handling discussed |
| 6. Non-Functional | ✅ CLEAR | Performance targets defined |
| 7. Technical | ✅ CLEAR | Stack specified, API design present |
| 8. Prioritization | ✅ CLEAR | MVP scope defined, phases listed |

Recommendation:
- Skip: Stages 1, 6, 7, 8 (already clear)
- Targeted questions: Stages 2, 3 (need clarification)
- Full interview: Stages 4, 5 (not covered)
```

---

## Project Context Scanning

Scan project to understand context without bloating.

### Files to Scan (Priority Order)

1. **Package manifest** (stack detection):
   - `package.json` → Node.js/JavaScript project
   - `requirements.txt` / `pyproject.toml` → Python project
   - `Cargo.toml` → Rust project
   - `go.mod` → Go project

2. **Similar spec/phase files** (pattern detection):
   - `docs/*.md`, `specs/*.md`, `phases/*.md`
   - Look for naming patterns, structure templates

3. **Config files** (tech stack details):
   - `tsconfig.json` → TypeScript
   - `.eslintrc` → Linting setup
   - `docker-compose.yml` → Containerized
   - `prisma/schema.prisma` → Prisma ORM

4. **README.md** (project overview):
   - First 50 lines only
   - Extract project purpose

5. **Current branch** (feature context):
   - `git branch --show-current`
   - Parse branch name for feature hints

### Scan Limits

- **Max files**: 5
- **Max lines per file**: 50 (first 50 only)
- **Timeout**: 5 seconds total
- **Skip**: node_modules, .git, build directories

### Context Output Format

```
PROJECT CONTEXT:

Stack Detected:
- Runtime: Node.js 18+
- Framework: Next.js 14
- Language: TypeScript
- Database: PostgreSQL (Prisma)
- Styling: Tailwind CSS

Similar Files Found:
- docs/phase-1-auth.md (completed)
- docs/phase-2-dashboard.md (completed)
- Pattern: {feature-name}.md with standard sections

Current Branch: feat/user-export
- Likely feature: User data export functionality

Project Purpose (from README):
"Internal tool for managing customer support tickets"

Context-Based Inferences:
- Skip stack questions (already known)
- Suggest similar structure to existing phases
- Feature likely relates to exporting user data
```

---

## Smart Skipping Logic

### Decision Tree

```
For each interview stage:
│
├─ Is stage CLEAR in file?
│  ├─ YES → Add to "accepted" list, skip questions
│  └─ NO → Continue
│
├─ Is stage UNCLEAR in file?
│  ├─ YES → Ask ONLY about unclear parts
│  └─ NO → Continue
│
└─ Stage is MISSING
   └─ Ask full stage questions
```

### User Notification

Before skipping, always inform user:

```
"Based on your file, I've accepted these as already defined:

✅ Problem: Reduce manual data entry time by 50%
✅ Users: Finance team (5 people), desktop, daily use
✅ Tech Stack: Next.js, TypeScript, Prisma
✅ Priority: MVP in 2 weeks, v2 adds reporting

If you want to refine any of these, let me know.

[1] Proceed - focus on gaps only
[2] Refine some accepted items
[3] Start fresh - full interview
```

### Handling "Refine" Request

If user selects "Refine some accepted items":

```
"Which items would you like to revisit?"

[ ] Problem & Vision
[ ] Users & Stakeholders
[x] Tech Stack (selected)
[ ] Prioritization

→ Ask questions only for selected items
```

---

## Complexity Analysis

### Metrics to Calculate

After interview complete, analyze complexity:

| Metric | Low | Medium | High |
|--------|-----|--------|------|
| Requirements count | 1-5 | 6-10 | 11+ |
| Screens/components | 1-2 | 3-4 | 5+ |
| External integrations | 0-1 | 2 | 3+ |
| Business logic rules | 1-3 | 4-6 | 7+ |
| User roles | 1 | 2 | 3+ |
| Estimated LOC | <300 | 300-600 | 600+ |

### Complexity Score

```
Score = (requirements × 1) + (screens × 2) + (integrations × 3) + (logic_rules × 1.5)

Low: Score < 15
Medium: Score 15-30
High: Score > 30
```

### Split Recommendations

If complexity is HIGH, suggest split:

```
"⚠️ Complexity Analysis

This feature scores HIGH on complexity:
- 12 requirements
- 4 screens
- 3 integrations
- Score: 34/30 threshold

Single-phase implementation risks:
- Difficult code review
- Hard to test thoroughly
- Debugging challenges

Recommended split:

Option A - By Priority:
├── Phase 3a: MVP (core CRUD, basic UI)
├── Phase 3b: Integrations (API connections)
└── Phase 3c: Polish (edge cases, UX improvements)

Option B - By Component:
├── Phase 3a: Backend (API, database, logic)
├── Phase 3b: Frontend (UI, components, states)
└── Phase 3c: Integration (connect frontend to backend)

[1] Split by priority
[2] Split by component
[3] Custom split
[4] Keep as single phase
```

---

## Output Options Logic

### Decision Flow

```
Interview complete
│
├─ Was original file provided?
│  ├─ YES → Offer: Update original OR create new
│  └─ NO → Ask for save location
│
├─ Is complexity HIGH?
│  ├─ YES → Suggest split, then ask location
│  └─ NO → Continue
│
└─ Get final save location from user
```

### File Naming for Splits

If user chooses to split:

```
Original: docs/phase-3.md

Split options:
- Suffix: phase-3a.md, phase-3b.md, phase-3c.md
- Descriptive: phase-3-mvp.md, phase-3-integrations.md
- Numbered: phase-3.1.md, phase-3.2.md, phase-3.3.md

Ask user preference or use default (suffix)
```
