# Sandstraw Copilot Instructions

## Purpose

Use this repository as a structured product-to-implementation workflow for Sandstraw. The plugin should keep business discovery, product value, and code implementation separated but connected.

## Workflow model

1. Initiative layer captures business context, stakeholders, and desired outcomes.
2. Story layer captures user value and acceptance criteria.
3. Task layer is the implementation boundary.
4. Each task should be treated as a self-contained execution bundle for GitHub Copilot.

## Task bundle requirement

Every task under the initiative/story/task structure must include the implementation bundle before it is considered ready for code work.

Required files:
- `task.md` or equivalent task summary
- `spec.md`
- `plan.md`
- `tech.md`

Preferred layout:
- `.sandstraw/product/initiatives/<initiative-slug>/<story-slug>/<task-slug>/task.md`
- `.sandstraw/product/initiatives/<initiative-slug>/<story-slug>/<task-slug>/spec.md`
- `.sandstraw/product/initiatives/<initiative-slug>/<story-slug>/<task-slug>/plan.md`
- `.sandstraw/product/initiatives/<initiative-slug>/<story-slug>/<task-slug>/tech.md`

If a flat-file pattern is needed for compatibility, name the companion files as:
- `<task-name>-spec.md`
- `<task-name>-plan.md`
- `<task-name>-tech.md`

## Guardrails

- Keep initiative artifacts focused on business intent.
- Keep story artifacts focused on user value.
- Keep task artifacts focused on implementation detail.
- Do not start code work when a task bundle is incomplete.
- Refresh project memory after major initiative, story, or task updates.
- Prefer small, testable tasks over broad implementation work.

## Recommended orchestration

Use a single orchestrator agent for workflow sequencing and validation, and keep specialized skills as the content-generation layer.

## Preferred layout

```text
.sandstraw/product/tasks/001-task-name/
  task.md
  spec.md
  plan.md
  tech.md
```
