# Sandstraw

Sandstraw is a lightweight product-to-implementation workflow for turning business intent into implementation-ready task bundles for GitHub Copilot.

## Workflow overview

The system is intentionally layered so each artifact has a clear job:

1. Initiative layer
   - Captures business context, stakeholders, constraints, and desired outcomes.
   - Stored under `.sandstraw/product/initiatives`.
   - Purpose: define the problem and business value before implementation begins.

2. Story layer
   - Captures user value, acceptance criteria, and product-level outcomes.
   - Stored under `.sandstraw/product/stories`.
   - Purpose: describe what the user needs, not how to build it.
   - Supports both the standard generic story format (`As a / I want / so that`) and Gherkin scenario format (`Given / When / Then`) without changing the product-first workflow.

3. Task layer
   - Breaks a story into concrete, scoping-focused implementation units.
   - Stored under `.sandstraw/product/tasks`.
   - Purpose: provide the execution context GitHub Copilot needs to write code safely.

## Task bundle requirement

Each task is expected to have a small implementation bundle before it is treated as ready for coding. The preferred structure is:

```text
.sandstraw/product/tasks/001-task-name/
  task.md
  spec.md
  plan.md
  tech.md
```

The bundle should include:
- `task.md` — brief summary of the task and the acceptance criteria
- `spec.md` — agreed behavior, constraints, edge cases, and scope boundaries
- `plan.md` — implementation sequence, validation steps, and checkpoints
- `tech.md` — architecture, stack, integrations, libraries, and key technical decisions

If a flat-file layout is required for compatibility, use sibling files such as:
- `001-task-name-spec.md`
- `001-task-name-plan.md`
- `001-task-name-tech.md`

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
- `.sandstraw/state.json`

This memory file keeps business context, architecture context, decisions, and relevant references so future initiatives do not re-discover the same facts.

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

- `.sandstraw/product/initiatives` — initiative documents
- `.sandstraw/product/stories` — user story documents
- `.sandstraw/product/tasks` — task summaries and task bundles
- `.sandstraw/project-memory.md` — project context
- `.sandstraw/state.json` — sequence tracking
- `skills/` — specialized domain skills
- `com.github.copilot/agents/` — workflow orchestration
- `com.github.copilot/hooks/` — validation guardrails

## Recommended operating model

Use specialized skills for generation and a single orchestrator agent for sequencing. Keep initiative and story files business-facing, and keep task artifacts implementation-facing.

This keeps Sandstraw structured, reusable, and ready for GitHub Copilot to execute within a clear delivery workflow.
