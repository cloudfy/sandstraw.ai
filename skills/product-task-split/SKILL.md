---
spdx-license: AGPL-3.0-or-later
user-invocable: true
description: "Splits an approved user story into minimal, testable implementation tasks with clear scope and dependencies."
---

# Sandstraw Product Task Split Skill

## Purpose

Take an approved user story from `.sandstraw/product/stories` and break it into one or more minimal implementation tasks. Each task must be a small unit of work with clear scope, explicit acceptance criteria, and dependencies that are obvious to the implementation team.

This skill does not redesign the product. It breaks a validated story into manageable execution units for code implementation.

## Input sources

- `.sandstraw/product/stories/*.md`
- `.sandstraw/product/backlog/*.md`
- project memory in `.sandstraw/`
- any relevant initiative or story notes

## Rules

1. Keep tasks minimal and implementation-ready.
2. Each task must have a single primary objective.
3. Each task must have clear scope boundaries.
4. Each task must define what done looks like.
5. Do not combine unrelated work into one task.
6. Do not create large, multi-purpose tasks that mix validation, refactoring, and new functionality.
7. Treat dependencies explicitly.
8. If a story is too large or unclear, split it into task groups before implementation.

## Task design principles

A task is a minimal unit of work when:

- it is small enough to be completed in one focused implementation cycle
- it has a singular outcome
- its acceptance criteria are easy to verify
- it can be handed to one engineer or pair without hidden assumptions
- its dependencies and blockers are obvious

## Output format

Before saving a task, read `.sandstraw/state.json`, increment `sequence.task`, and persist the updated state. Then write each task as a task bundle in `.sandstraw/product/tasks` using the assigned sequence number and a clear slug, for example:

```text
.sandstraw/product/tasks/001-task-<short-name>/
  task.md
  spec.md
  plan.md
  tech.md
```

This is the preferred implementation pattern because GitHub Copilot can read the task summary and the supporting implementation context together without mixing product intent with engineering detail.

Use this structure for the main task summary:

```markdown
# <Task Title>

## Related Story
- Story title:
- Story file:

## Objective
State the single purpose of this task in one sentence.

## Scope
In scope:
- 

Out of scope:
- 

## Acceptance Criteria
- [ ] A minimal, testable outcome is delivered.
- [ ] The work is limited to the defined scope.
- [ ] Any needed validation is explicit.

## Dependencies
- Requires:
- Blocks:

## Task Bundle
- `task.md` — summary of the task and acceptance criteria
- `spec.md` — exact behavior, edge cases, accepted inputs/outputs, and scope boundaries
- `plan.md` — execution sequence, validation steps, and handoff checkpoints
- `tech.md` — technical stack, architecture, frameworks, integration details, and design decisions

## Notes
Include any assumptions, constraints, or implementation hints.

## Definition of Done
This task is complete when the acceptance criteria are met and the work remains within the defined scope.
```

The companion files must also be created and kept in sync with the task:

```markdown
# spec.md
State the agreed behavior, constraints, and edge cases. This file exists to anchor implementation to a specific specification rather than interpretation.

# plan.md
Describe the implementation sequence, validation steps, and any checkpoints or rollback concerns.

# tech.md
Document architecture, framework decisions, library choices, integration contracts, and any important trade-offs.
```

## Process

1. Read the approved user story.
2. Identify the core behaviors or outcomes the story requires.
3. Break the story into the smallest meaningful units of work.
4. For each task, define:
   - objective
   - clear scope
   - dependencies
   - acceptance criteria
   - definition of done
5. Ensure no task is broad enough to hide multiple concerns.
6. Save the result to `.sandstraw/product/tasks/`.

## Completion rule

A task is ready only when it is:

- minimal
- clearly scoped
- testable
- independent enough to execute without hidden assumptions
- `.sandstraw/state.json` has been updated with the next `sequence.task` value
- saved as a task bundle in `.sandstraw/product/tasks` with the sequence prefix applied
- includes `spec.md`, `plan.md`, and `tech.md` in the same task bundle or adjacent task artifact set

## Final behavior

Do not create vague tasks like “implement feature X” or “complete user flow”; prefer concrete tasks such as “add validation for required field,” “persist approval record,” or “render status badge for in-progress state.”
