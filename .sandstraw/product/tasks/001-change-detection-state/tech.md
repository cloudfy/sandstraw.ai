# Technical approach

## Data model
The Sandstraw state schema should be extended as follows:

```json
{
  "sequence": {
    "task": 0,
    "initiative": 0,
    "userstory": 0
  },
  "project": {
    "name": null,
    "description": null,
    "initialized": false,
    "created_at": null
  },
  "monitor": {
    "enabled": false,
    "mode": "warn_and_review",
    "exclude_generated_changes": true,
    "exclude_task_linked_code": true,
    "initial_index_scan": false,
    "reindex_enabled": true
  },
  "memory": {
    "project_file": ".sandstraw/project-memory.md",
    "summary_file": ".sandstraw/project-memory-summary.md",
    "last_refresh": null,
    "version": 1
  }
}
```

## Change ownership logic
A change is considered Sandstraw-owned when at least one of the following is true:

- the file path or content is directly linked to an initiative artifact,
- the file path or content is linked to a story artifact,
- the file path or content is linked to a task bundle or task execution record,
- the change was created by the Sandstraw generation workflow and has metadata showing the originating task or story.

Any remaining diff is treated as unmapped and sent to a review path rather than being automatically converted into a product artifact.

## Initial indexing
Initial indexing works by performing a repository-wide scan against the current file state and comparing that scan to the state ledger. The scan should:

- identify changed file paths,
- compare them to Sandstraw-owned records,
- classify the remainder as unresolved,
- store a lightweight inventory so a later reindex can de-duplicate existing findings.

## Design guardrails
- Keep `project.name` and `project.description` nullable until the user supplies values.
- Maintain `warn_and_review` behavior until a stronger approval policy is added.
- Do not infer ownership from file names alone when a task or story artifact is not explicitly linked.
