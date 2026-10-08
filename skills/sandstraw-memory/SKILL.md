---
spdx-license: AGPL-3.0-or-later
user-invocable: true
description: "Collects initiative, story, and task knowledge into a global Sandstraw project-memory file and refreshes it whenever project context changes."
---

# Sandstraw Memory Skill

## Purpose

Create and maintain a single global memory file for the project in `.sandstraw/project-memory.md`.

This skill is the project’s compact knowledge layer: it aggregates the business domain, business requirements, prior initiative outcomes, technical decisions, and architecture context from all source artifacts so future work can start from shared understanding instead of re-discovering the same facts.

## Default behavior

Whenever a new initiative or story is created, this skill should be triggered immediately after the artifact is saved to refresh the project memory. The refresh must happen after the source artifact is written, not before, so the memory reflects the latest confirmed project context.

## Sources to read

- `.sandstraw/project-memory.md`
- `.sandstraw/project-memory-summary.md`
- `.sandstraw/product/initiatives/**/initiative.md`
- `.sandstraw/product/initiatives/**/story.md`
- `.sandstraw/product/initiatives/**/task.md`
- `.sandstraw/product/initiatives/**/spec.md`
- `.sandstraw/product/initiatives/**/plan.md`
- `.sandstraw/product/initiatives/**/tech.md`
- `.sandstraw/plans/*.md`
- `.sandstraw/state.json`

## Memory refresh workflow

1. Read the current `.sandstraw/project-memory.md` and the latest relevant initiative/story/task artifacts.
2. Identify new business facts, requirements, users, architecture changes, or decisions.
3. Merge the new information into the memory schema without losing earlier confirmed context.
4. Add or update initiative summaries, story themes, and architecture decision notes.
5. Persist the updated memory file.
6. Update the summary snapshot in `.sandstraw/project-memory-summary.md`.
7. Update `.sandstraw/state.json` with the latest memory metadata, including a refresh timestamp and version.

## Operating rules

1. Keep the memory concise and useful, not a raw dump of every artifact.
2. Preserve confirmed business facts, requirements, and decisions.
3. Distinguish between current truths, historical notes, and unresolved questions.
4. Capture both business context and technical context, including architecture decisions and solution items.
5. Keep the memory grounded in source artifacts rather than assumptions.
6. When the same fact is found in multiple places, record the agreed version and preserve the context.
7. Flag conflicts, outdated assumptions, or contradictory requirements as open risks.

## Project memory schema

Use this structure for the global file:

```markdown
# Sandstraw Project Memory

## 1. Executive Summary
## 2. Business Domain
## 3. Business Requirements and Constraints
## 4. Stakeholders and Users
## 5. Initiative History
## 6. Story and Backlog Context
## 7. Solution & Technical Context
## 8. Technology Stack
## 9. Architecture Decisions and Standards
## 10. Risks, Assumptions, and Open Questions
## 11. Source References
## 12. Memory Refresh Notes
```

For each initiative or story addition, record at minimum:
- what changed
- why it matters
- which requirement or decision it affects
- whether it impacts architecture, product goals, or constraints

## Summary command path

Use the companion skill `sandstraw-memory-summary` to generate a compact project snapshot from the current memory file. This command is intended to create a short executive overview for daily review, leadership updates, or handoff between initiative phases.

## Completion rule

The memory refresh is complete only when:

- the global memory file has been updated
- the latest initiative or story has been incorporated into the history and context
- architecture decisions and technical context are reflected
- unresolved questions or contradictions are still visible
- the compact summary snapshot has been refreshed
- `.sandstraw/state.json` has the updated memory metadata

## Final behavior

After each initiative or story write, Sandstraw should treat memory as a project asset that must be refreshed. The memory remains a reusable project context file, not a replacement for source artifacts.
