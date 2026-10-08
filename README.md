# Sandstraw

Sandstraw is a lightweight product-to-implementation workflow for turning business intent into implementation-ready task bundles for GitHub Copilot.

## Workflow overview

The system is intentionally layered so each artifact has a clear job and a stable ownership path:

1. Initiative layer
   - Captures business context, stakeholders, constraints, and desired outcomes.
   - Stored under `.sandstraw/product/initiatives/<initiative-slug>/`.
   - Purpose: define the problem and business value before implementation begins.

2. Story layer
   - Captures user value, acceptance criteria, and product-level outcomes.
   - Stored under `.sandstraw/product/initiatives/<initiative-slug>/<story-slug>/`.
   - Purpose: describe what the user needs, not how to build it.
   - Supports both the standard generic story format (`As a / I want / so that`) and Gherkin scenario format (`Given / When / Then`) without changing the product-first workflow.

3. Task layer
   - Breaks a story into concrete, scoping-focused implementation units.
   - Stored under `.sandstraw/product/initiatives/<initiative-slug>/<story-slug>/<task-slug>/`.
   - Purpose: provide the execution context GitHub Copilot needs to write code safely.

## Task bundle requirement

Each task is expected to have a small implementation bundle before it is treated as ready for coding. The preferred structure is:

```text
.sandstraw/product/initiatives/001-initiative-name/
  initiative.md
  001-story-name/
    story.md
    001-task-name/
      task.md
      spec.md
      plan.md
      tech.md
```

The bundle should include:
- `task.md` — brief summary of the task, priority, dependencies, and acceptance criteria
- `spec.md` — agreed behavior, constraints, edge cases, and scope boundaries
- `plan.md` — implementation sequence, validation steps, and checkpoints
- `tech.md` — architecture, stack, integrations, libraries, and key technical decisions

The task bundle remains grouped in one task folder so the implementation context stays together and no task is split across sibling files. A single story may produce several ordered task bundles, and the dependency order must reflect foundation-before-consumer sequencing.

## End-to-end flow

```text
Initiative
  -> Story
    -> Task decomposition
      -> Task bundle
        -> Implementation
          -> Validation
            -> Memory refresh
```

## Project memory and state

The project stores shared context under:
- `.sandstraw/project-memory.md`
- `.sandstraw/project-memory-summary.md`
- `.sandstraw/state.json`

These files stay at the root of `.sandstraw/`, while initiative, story, and task artifacts live under the nested initiative folders. This keeps memory and state stable across all initiative work and avoids duplicating project-level context inside each task or story folder.

## Implementation gate

Before code changes begin, a task should satisfy the following:

- single objective
- clear scope boundaries
- explicit acceptance criteria
- known dependencies
- implementation bundle present
- references to the relevant story or initiative

If the task bundle is incomplete, the task is not implementation-ready.

## Core plugin structure

- `.sandstraw/product/initiatives` — initiative folders containing all related story and task artifacts
- `.sandstraw/project-memory.md` — project context
- `.sandstraw/project-memory-summary.md` — compact memory snapshot
- `.sandstraw/state.json` — sequence tracking and setup metadata
- `skills/` — specialized domain skills
- `com.github.copilot/agents/` — workflow orchestration
- `com.github.copilot/hooks/` — validation guardrails

## Recommended operating model

Use specialized skills for generation and a single orchestrator agent for sequencing. Keep initiative and story files business-facing, and keep task artifacts implementation-facing.

This keeps Sandstraw structured, reusable, and ready for GitHub Copilot to execute within a clear delivery workflow.

## Tools and implementation constraints

- Do not use Python, and do not add any Python (.py) scripts.
- If scripts are needed, implement them as PowerShell (.ps1) scripts.
- Prefer PowerShell for automation, repository maintenance, and scripting tasks unless the project explicitly requires another runtime.