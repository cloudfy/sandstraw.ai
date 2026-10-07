# <Task Title>

## Related Story
- Story reference:

## Objective

## Scope

## Acceptance Criteria
- [ ] Task deliverable 1
- [ ] Task deliverable 2

## Dependencies

## Task Bundle
This task should be saved as a task bundle under `.sandstraw/product/tasks/<task-slug>/` with these files:
- `task.md` — brief summary of the task and its acceptance criteria
- `spec.md` — the agreed specification, behaviors, and edge cases for the change
- `plan.md` — execution plan, sequencing, validation steps, and implementation checkpoints
- `tech.md` — technology, architecture, library, integration, and decision context

If the project requires a flat-file layout for compatibility, keep the task summary markdown and add sibling files named `<task-slug>-spec.md`, `<task-slug>-plan.md`, and `<task-slug>-tech.md` alongside it.

## Notes

This task is a downstream breakdown of a user story for code implementation. The task bundle is the implementation context that GitHub Copilot should use when writing or changing code.
