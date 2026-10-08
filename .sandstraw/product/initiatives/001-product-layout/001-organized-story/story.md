# Organized Story

## User story

As a maintainer of Sandstraw, I want initiative artifacts to be grouped by initiative and story so that I can understand ownership quickly and keep task work close to its product context.

## Acceptance criteria

- The initiative root contains the initiative artifact and all related story folders.
- Each story folder contains its own story artifact and any child task folders.
- Each task folder contains the task bundle with task.md, spec.md, plan.md, and tech.md.
- Shared state and memory remain in `.sandstraw/` rather than inside initiative folders.
