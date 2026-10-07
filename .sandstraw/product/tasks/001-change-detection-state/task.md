# Task: Persist setup metadata and define change detection boundaries

## Summary
This task establishes the minimum Sandstraw state contract needed to keep onboarding answers and repository-change monitoring aligned with the product workflow. It addresses two requirements:

- Save the initial project name and project description in the Sandstraw state file instead of discarding them after setup.
- Define the boundary for change detection so Sandstraw ignores changes that are already owned by initiatives, stories, or task bundles.

## Acceptance criteria
- The state schema contains persisted project metadata fields for name and description.
- The project metadata remains separate from sequence counters and memory metadata.
- The monitoring config explicitly excludes Sandstraw-generated work from unmapped-change detection.
- The task bundle documents how an existing repo can be indexed without double-counting Sandstraw-owned changes.
- No assumptions are made about the project name or description; empty values remain valid until the user provides them.
