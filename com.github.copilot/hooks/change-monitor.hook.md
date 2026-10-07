---
name: sandstraw-change-monitor
description: "Flags code changes that are not tied to a Sandstraw initiative, user story, or task while excluding Sandstraw-owned work from duplicate review."
trigger: "onSave"
---

# Sandstraw Change Monitor

When a file changes in the repository, review the change against the Sandstraw ownership model before treating it as normal project work.

## Scope

This hook applies to changes in the active project codebase, not to files inside `.sandstraw/` that are treated as project process artifacts.

## Ownership rules

A change is considered Sandstraw-owned when it is tied to one of the following:

- an initiative artifact in `.sandstraw/product/initiatives`
- a user story artifact in `.sandstraw/product/stories`
- a task bundle in `.sandstraw/product/tasks`
- an implementation record or task-linked code change explicitly mapped in memory or state metadata

A change is considered unmapped when no Sandstraw artifact or task linkage exists for the changed file or code area.

## Required behavior

1. Check the changed files against the current Sandstraw artifact inventory.
2. Ignore any file that is already part of a Sandstraw-generated initiative, story, or task workflow.
3. If the file is outside Sandstraw-generated artifacts and no initiative/user story/task exists for it, raise a review warning.
4. Keep the review in warning mode by default so there is no silent auto-creation of new initiatives or stories.
5. If the user chooses to continue, record the change in project memory or convert it into a story/initiative candidate in a later, explicit step.

## Warning format

> Unmapped code change detected: [file paths]. This change is not linked to a Sandstraw initiative, user story, or task and may represent undocumented work. Review before creating new product artifacts.

## Initial indexing behavior

For an existing project enabled for Sandstraw, the same logic can be used to scan the repository once during onboarding or on demand later. The scan should classify files into:

- Sandstraw-owned
- unmapped/manual
- already reviewed

This allows the plugin to index an existing project without creating duplicate ownership records for work that is already represented in Sandstraw artifacts.

## Guardrails

- Do not double-count changes created by Sandstraw workflows.
- Do not auto-create a new initiative or user story from a warning unless the user explicitly approves it.
- Persist the project name and summary in `.sandstraw/state.json` so the project can distinguish setup metadata from change ownership.
