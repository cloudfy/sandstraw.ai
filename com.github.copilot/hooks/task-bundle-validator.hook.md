---
name: sandstraw-task-bundle-validator
description: "Validates that task artifacts include the required implementation package before code changes begin."
trigger: "onSave"
---

# Sandstraw Task Bundle Validator

When a task is created or updated under `.sandstraw/product/initiatives/<initiative-slug>/<story-slug>/<task-slug>/`, verify the task has the required implementation bundle.

## Required files

For each task, check that the task directory or task artifact set contains all of the following:

- `task.md` or equivalent task summary file
- `spec.md`
- `plan.md`
- `tech.md`

The preferred pattern is a task folder with these exact files. Flat-file variants are allowed only when required for compatibility, but they must still provide equivalent content and the same missing-file check.

## Validation rules

- If the task bundle is missing any of the required files, raise a warning.
- If a task is being treated as implementation-ready but lacks the bundle, block the handoff to implementation until the bundle is created.
- If a task summary references a story or initiative but does not contain the implementation files, warn that the handoff is incomplete.
- If a story has multiple generated tasks, ensure they are ordered by dependency and not treated as a single flat task.
- Flag tasks that are too broad, mix multiple concerns, or skip prerequisite model/schema work when that work is required.
- Keep initiative and story files separate from task implementation context.

## Suggested warning

> Task bundle incomplete: add `spec.md`, `plan.md`, and `tech.md` before starting implementation.

## Purpose

This hook is intentionally narrow: it helps enforce the implementation contract without replacing the orchestrator agent or the specialized skills, and it protects the plugin from starting code work with incomplete implementation context.
