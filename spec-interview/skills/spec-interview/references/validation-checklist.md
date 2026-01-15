# Validation Checklist

Comprehensive checklist for validating spec completeness against best practices.
Run this after interview is 100% complete, before writing the final spec.

---

## How to Use

1. For each category, check if the topic was covered during interview
2. Mark status: ✅ COVERED | ⚠️ PARTIAL | ❌ MISSING
3. For missing items, determine severity:
   - **CRITICAL**: Must have for production features
   - **RECOMMENDED**: Best practice, should consider
   - **OPTIONAL**: Nice to have, context-dependent
4. Present gaps to user and let them decide what to add

---

## Categories

### 1. Problem & Vision

| Item | Question | Severity |
|------|----------|----------|
| problem_statement | Is the problem clearly defined? | CRITICAL |
| root_cause | Is the root cause identified? | RECOMMENDED |
| success_metrics | Are success metrics measurable (SMART)? | CRITICAL |
| business_value | Is business value articulated? | RECOMMENDED |
| cost_of_inaction | Is "what if we don't build this" defined? | RECOMMENDED |

### 2. Users & Stakeholders

| Item | Question | Severity |
|------|----------|----------|
| primary_users | Are primary users identified? | CRITICAL |
| secondary_users | Are secondary/affected users considered? | RECOMMENDED |
| user_personas | Are persona details sufficient? | RECOMMENDED |
| tech_level | Is user technical level defined? | RECOMMENDED |
| stakeholder_approval | Is approval process defined? | OPTIONAL |

### 3. Functional Requirements

| Item | Question | Severity |
|------|----------|----------|
| crud_operations | Are Create/Read/Update/Delete defined? | CRITICAL |
| input_validation | Are data validation rules specified? | CRITICAL |
| business_logic | Are business rules documented? | CRITICAL |
| workflows | Are workflows/state machines described? | RECOMMENDED |
| calculations | Are calculations/formulas defined? | RECOMMENDED |
| automations | Are automations/triggers specified? | OPTIONAL |

### 4. Data

| Item | Question | Severity |
|------|----------|----------|
| data_model | Is data model/schema defined? | CRITICAL |
| required_fields | Are required vs optional fields clear? | CRITICAL |
| data_sources | Are data sources identified? | RECOMMENDED |
| data_relationships | Are data relationships defined? | RECOMMENDED |
| data_migration | Is existing data migration addressed? | RECOMMENDED |
| data_retention | Is data retention/deletion policy defined? | RECOMMENDED |

### 5. Integrations

| Item | Question | Severity |
|------|----------|----------|
| third_party_services | Are 3rd party services identified? | CRITICAL |
| api_endpoints | Are API endpoints defined? | CRITICAL |
| webhooks | Are webhook requirements specified? | OPTIONAL |
| import_export | Are import/export formats defined? | RECOMMENDED |
| notifications | Are notifications (email, SMS, push) specified? | RECOMMENDED |

### 6. UI/UX

| Item | Question | Severity |
|------|----------|----------|
| navigation | Is navigation/IA defined? | CRITICAL |
| key_screens | Are main screens/layouts described? | CRITICAL |
| component_behavior | Are component behaviors specified? | RECOMMENDED |
| interaction_patterns | Are interactions (drag, inline edit) defined? | RECOMMENDED |
| responsive_design | Is mobile/tablet behavior specified? | RECOMMENDED |

### 7. UI States (Often Missed!)

| Item | Question | Severity |
|------|----------|----------|
| loading_state | What do users see while loading? | CRITICAL |
| empty_state | What if there's no data? | CRITICAL |
| error_state | How are errors displayed? | CRITICAL |
| success_state | How is success confirmed? | CRITICAL |
| partial_state | What if only some data available? | RECOMMENDED |
| disabled_state | What about disabled/locked states? | RECOMMENDED |
| offline_state | What if network unavailable? | RECOMMENDED |

### 8. Edge Cases

| Item | Question | Severity |
|------|----------|----------|
| permission_denied | What if user lacks permission? | CRITICAL |
| concurrent_editing | What if two users edit same thing? | CRITICAL |
| network_failure | What if network fails? | RECOMMENDED |
| timeout_handling | What if request times out? | RECOMMENDED |
| large_data | What if 1000+ records? | RECOMMENDED |
| duplicate_handling | How are duplicates handled? | RECOMMENDED |
| invalid_input | How is invalid input handled? | CRITICAL |

### 9. Error Handling

| Item | Question | Severity |
|------|----------|----------|
| error_messages | Are user-facing error messages defined? | CRITICAL |
| retry_logic | Is retry behavior specified? | RECOMMENDED |
| graceful_degradation | Is fallback behavior defined? | RECOMMENDED |
| error_logging | Is error logging specified? | RECOMMENDED |
| user_recovery | Can users recover from errors? | CRITICAL |

### 10. User Actions

| Item | Question | Severity |
|------|----------|----------|
| undo_redo | Is undo/redo needed? | OPTIONAL |
| confirmation_dialogs | Are destructive actions confirmed? | CRITICAL |
| bulk_actions | Are bulk operations needed? | OPTIONAL |
| keyboard_shortcuts | Are keyboard shortcuts needed? | OPTIONAL |
| auto_save | Is auto-save vs manual save defined? | RECOMMENDED |

### 11. Non-Functional: Performance

| Item | Question | Severity |
|------|----------|----------|
| page_load_time | Is acceptable load time defined? | RECOMMENDED |
| api_response_time | Is acceptable API response time defined? | RECOMMENDED |
| concurrent_users | How many concurrent users expected? | RECOMMENDED |

### 12. Non-Functional: Security

| Item | Question | Severity |
|------|----------|----------|
| authentication | Is authentication required? | CRITICAL |
| authorization | Is role-based access defined? | CRITICAL |
| data_sensitivity | Is data sensitivity classified? | CRITICAL |
| audit_trail | Is audit logging needed? | RECOMMENDED |
| encryption | Are encryption requirements defined? | RECOMMENDED |

### 13. Non-Functional: Accessibility & Compliance

| Item | Question | Severity |
|------|----------|----------|
| wcag_level | Is WCAG compliance level defined? | RECOMMENDED |
| keyboard_nav | Is keyboard navigation required? | RECOMMENDED |
| screen_reader | Is screen reader support required? | RECOMMENDED |
| gdpr | Are GDPR requirements addressed? | CRITICAL (if EU) |
| local_regulations | Are local regulations addressed (KVKK, etc.)? | CRITICAL (if applicable) |

### 14. Often Missed (Critical Review!)

| Item | Question | Severity |
|------|----------|----------|
| internationalization | Is multi-language support needed? | RECOMMENDED |
| localization | Is date/currency localization needed? | RECOMMENDED |
| time_zones | Is timezone handling defined? | RECOMMENDED |
| search | Is search functionality needed? | RECOMMENDED |
| filtering_sorting | Are filtering/sorting requirements defined? | RECOMMENDED |
| pagination | Is pagination strategy defined? | RECOMMENDED |
| export_formats | What export formats needed (CSV, PDF, Excel)? | OPTIONAL |
| print_view | Is print view needed? | OPTIONAL |
| email_templates | Are email templates needed? | OPTIONAL |
| help_documentation | Is in-app help needed? | OPTIONAL |
| onboarding_flow | Is user onboarding needed? | RECOMMENDED |
| analytics_tracking | Is analytics/tracking needed? | RECOMMENDED |
| ab_testing | Is A/B testing needed? | OPTIONAL |
| backup_recovery | Is backup/recovery defined? | RECOMMENDED |
| migration_path | Is version migration path defined? | OPTIONAL |

---

## Presenting Results

After checking all categories, present to user:

```
Validation Complete

Coverage by category:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Problem & Vision (5/5)
✅ Users & Stakeholders (4/4)
⚠️ Functional Requirements (5/6) - 1 gap
   └─ Missing: automations
✅ Data (6/6)
...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

{N} items not covered. How to proceed?

[1] Add them now (ask about each gap)
[2] Mark as out-of-scope (document in spec)
[3] Pick which ones to add
[4] Skip validation (write spec as-is)
```

---

## Severity Guidelines

**CRITICAL items** should always be addressed:
- If missing, strongly recommend asking about them
- If user skips, document as "Not Addressed" in spec

**RECOMMENDED items** depend on context:
- For MVP/simple features: Can skip
- For production features: Should address
- Ask user preference if unclear

**OPTIONAL items** are truly optional:
- Only mention if relevant to the specific feature
- Don't overwhelm user with questions about optional items
