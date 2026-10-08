---
spdx-license: AGPL-3.0-or-later
user-invocable: true
description: "Splits an approved user story into minimal, testable implementation tasks with clear scope and dependencies."
---

# Sandstraw Product Task Split Skill

## Purpose

Take an approved user story and decompose it into the smallest meaningful set of implementation tasks. This is not a 1:1 conversion. One story may require several tasks, and those tasks must be ordered so the work is buildable from foundation to integration.

Each task must be autonomous enough to stand on its own as a commit-sized unit of work. It should be implementation-ready, testable, and validatable without hidden dependencies on sibling tasks or unstated context.

This skill does not redesign the product. It turns a validated story into an ordered, dependency-aware execution plan that can be handed to GitHub Copilot or an engineer for implementation.

## Input sources

- approved story files under `.sandstraw/product/initiatives/<initiative>/...`
- related initiative context in `.sandstraw/`
- project memory and technical constraints in `.sandstraw/`
- any relevant requirements, backlog notes, or validation notes that clarify the story

## Core rules

1. One story may produce multiple tasks; do not force a 1:1 mapping.
2. Each task must have a single primary objective.
3. Each task must be autonomous and reviewable as an isolated commit in a git history.
4. Each task must have explicit scope boundaries and a clear definition of done.
5. Prioritize tasks by dependency, not just by story order.
6. Do not combine unrelated work into one task.
7. Do not create large, multi-purpose tasks that mix data model work, API logic, validation, and UI concerns unless the work is truly one atomic implementation step.
8. If a story is too large or ambiguous, split it into logical task groups before implementation.
9. If a task depends on a data model, schema, migration, or contract, that prerequisite task must appear earlier in the ordered sequence.

## Task design principles

A task is a minimal unit of work when:

- it is small enough to be completed in one focused implementation cycle
- it has a singular outcome
- its acceptance criteria are easy to verify
- it can be implemented and validated without hidden assumptions
- its dependencies and blockers are obvious
- it is independent enough to be committed as a standalone unit of change

## Dependency-first ordering

Task ordering is part of the output, not an afterthought.

Use this sequence when relevant:

- schema or data model changes before consumers of that model
- migrations or seed data before reads and writes that depend on them
- API contracts before client or UI implementation
- validation rules before final user-facing integration
- persistence work before reporting or rendering logic that depends on the stored data

If a task requires another task to exist first, state that clearly in the task metadata and list the tasks in the correct order.

## Output format

Before saving a task, read `.sandstraw/state.json`, increment `sequence.task`, and persist the updated state. Then write each task as its own task bundle under the canonical initiative/story/task structure, for example:

```text
.sandstraw/product/initiatives/001-initiative-name/
  001-story-name/
    001-task-<short-name>/
      task.md
      spec.md
      plan.md
      tech.md
```

This layout keeps implementation context close to the relevant story while preserving the required separation between product intent and engineering detail.

Use this structure for the main task summary:

```markdown
# <Task Title>

## Related Story
- Story title:
- Story file:

## Priority
- Priority: P0 / P1 / P2
- Depends on:
- Blocks:

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
- [ ] The task can be implemented and validated independently.
- [ ] Any required prerequisite work is explicitly identified.

## Dependencies
- Requires:
- Blocks:

## Task Bundle
The task bundle *must* include the following files. No exceptions:

- `task.md` — summary of the task, priority, and acceptance criteria
- `spec.md` — exact behavior, constraints, edge cases, accepted inputs/outputs, and scope boundaries
- `plan.md` — implementation sequence, validation steps, and handoff checkpoints
- `tech.md` — technical stack, architecture, framework choices, integration contracts, and key trade-offs

## Notes
Include any assumptions, constraints, or implementation hints.

## Definition of Done
This task is complete when the acceptance criteria are met, the dependency order is respected, and the work remains within the defined scope.
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

1. Read the approved user story and related initiative context.
2. Identify the core behaviors or outcomes the story requires.
3. Break the story into the smallest meaningful units of work.
4. Order the tasks according to dependency and foundation-first sequencing.
5. For each task, define:
   - objective
   - clear scope
   - priority
   - dependencies
   - acceptance criteria
   - validation method
   - definition of done
6. Ensure each task is autonomous enough to be implemented as an isolated commit.
7. Save each task as its own bundle in the canonical initiative/story/task structure.

## Completion rule

A task is ready only when it is:

- minimal
- clearly scoped
- testable
- independent enough to execute without hidden assumptions
- ordered correctly in the dependency chain
- `.sandstraw/state.json` has been updated with the next `sequence.task` value
- saved as a task bundle under the initiative/story/task structure with the sequence prefix applied
- includes `spec.md`, `plan.md`, and `tech.md` in the same task bundle

## Final behavior

Do not create vague tasks like “implement feature X” or “complete user flow”; prefer concrete tasks such as “add validation for required field,” “persist approval record,” “create data model for approval state,” or “render status badge for in-progress state.”

A valid output should show a story decomposed into multiple tasks, with each task representing one clear implementation milestone and the task list ordered from prerequisite work to final validation.
