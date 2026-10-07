---
spdx-license: AGPL-3.0-or-later
user-invocable: true
description: "Creates a condensed executive summary from the Sandstraw global memory file for quick project review and handoff."
---

# Sandstraw Memory Summary Skill

## Purpose

Create a short, readable executive summary from the project memory file in `.sandstraw/project-memory.md` and save it to `.sandstraw/project-memory-summary.md`.

This command exists to reduce the global memory into a concise snapshot that is easier to review during planning, initiative creation, or stakeholder updates.

## Inputs

- `.sandstraw/project-memory.md`
- `.sandstraw/state.json`

## Summary output

The summary should be compact, specific, and suitable for quick scanning. It should contain:

```markdown
# Sandstraw Project Memory Summary

## Executive Summary
- Current focus:
- Business value:
- Current constraints:
- Key themes:

## Active Initiatives
- Initiative names and business outcomes

## Active Story Themes
- Story themes or recurring user goals

## Tech and Architecture Snapshot
- Stack summary
- System integrations
- Important decisions

## Open Questions and Risks
- Risks
- Open questions
- Assumptions that require validation

## Recommended Next Action
- What the team should do next based on the memory
```

## Refresh process

1. Read `.sandstraw/project-memory.md`.
2. Extract the most relevant business, product, and technical facts.
3. Condense them into the executive summary format above.
4. Save the result to `.sandstraw/project-memory-summary.md`.
5. Update `.sandstraw/state.json` memory metadata to reflect the summary refresh.

## Completion rule

The summary is complete when:

- the output is concise but still captures the project’s true state
- the business domain, active work, and technical context are visible
- the summary is saved to `.sandstraw/project-memory-summary.md`
- the main memory file remains the source of truth and the summary remains a distilled version of it

## Final behavior

Use this skill for quick reviews and handoffs. It should never replace the full project memory file; it should serve as a compact snapshot of it.
