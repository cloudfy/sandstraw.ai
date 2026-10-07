# Specification

## Goal
Sandstraw must capture project identity and must not confuse manual repository edits with work that is already represented by initiative, story, and task artifacts.

## Functional requirements
1. Setup data capture
   - The initial setup interview asks for the project name and a short description of what the project is about.
   - Those answers are stored under `.sandstraw/state.json` in a `project` block.
   - If the user has not provided a value yet, the value remains `null` and the setup flow remains valid.

2. Change ownership detection
   - Sandstraw must detect changes that are not associated with any initiative, story, or task artifact.
   - The monitor must ignore code or content changes that are already attributed to a generated Sandstraw artifact.
   - A generated task can be treated as the strongest ownership boundary, because tasks map directly to implementation work.

3. Explicit review model
   - Unmapped changes should produce a warning and a review prompt rather than a silent auto-creation of project artifacts.
   - A developer or product owner can decide whether the unresolved change should become a memory note, a story candidate, or an initiative candidate.

4. Existing project indexing
   - Sandstraw must support an initial indexing pass for repositories that are already in active use.
   - The same indexing mechanism should be reusable for a later manual reindex without duplicating the same results.

## Non-goals
- Auto-creating initiatives or stories without explicit approval.
- Counting Sandstraw-generated code changes as undocumented work.
- Treating setup metadata as a hidden ephemeral value.
