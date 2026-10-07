# Implementation plan

## Phase 1 - State contract
1. Extend `.sandstraw/state.json` with a `project` object containing `name`, `description`, `initialized`, and `created_at`.
2. Preserve the existing `sequence` and `memory` objects and keep the top-level schema backward compatible.
3. Keep the fields nullable until the user completes onboarding.

## Phase 2 - Monitor configuration
1. Add a `monitor` object containing the mode and exclusions needed to skip Sandstraw-owned work.
2. Set `exclude_generated_changes` and `exclude_task_linked_code` to `true` by default.
3. Keep `warn_and_review` as the default operation mode, which matches the reviewed requirement to avoid silent artifact creation.

## Phase 3 - Repository reconciliation
1. Define a comparator between the working tree and any stored Sandstraw artifact metadata.
2. Treat initiative, story, and task files as authoritative ownership records for generated work.
3. Flag any remaining changes as unmapped and ask for human confirmation before further action.

## Phase 4 - Existing project index
1. Support an initial scan during setup for an already active repo.
2. Reuse the same logic for manual reindex actions later.
3. Deduplicate prior results using saved state metadata so the same change does not reappear repeatedly.
