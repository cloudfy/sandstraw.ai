---
spdx-license: AGPL-3.0-or-later
user-invocable: true
description: "Entry point for Sandstraw. Initiates the main workflow for the plugin."
---

# Sandstraw Setup Skill

## Step 0: New project

> "Hi — I'm Sandstraw. I'll help you build this project with a structured workflow. Let me ask a couple of quick questions."

Ask one at a time:
1. "What's the project name?"
2. "What are you building? (one sentence)"

Then run:
```bash
mkdir -p .sandstraw/product/initiatives \
         .sandstraw/state/archive \
         .sandstraw/plans
cat > .sandstraw/state.json <<'JSON'
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
JSON

cat > .sandstraw/project-memory.md <<'MD'
# Sandstraw Project Memory

This is the global, distilled memory for the project. It is maintained by the Sandstraw Memory skill and should be reviewed before new initiatives or stories are created.

## 1. Business Domain
- Capture the business problem, user needs, workflows, and value here.

## 2. Business Requirements and Constraints
- Record confirmed requirements, policies, and operational constraints.

## 3. Stakeholders and Users
- Capture the users, teams, and business owners involved.

## 4. Business Documentation and Prior Initiative Context
- Keep a concise summary of prior initiatives and relevant lessons.

## 5. Solution & Technical Context
- Document architecture, integrations, and the current technical stack.

## 6. Architecture Decisions and Standards
- Record important decisions, trade-offs, and standards.

## 7. Current Initiatives, Stories, and Workstreams
- Track active work and dependencies.

## 8. Risks, Assumptions, and Open Questions
- List unresolved questions and known risks.

## 9. Source References
- Keep links or names of the source initiative and story files that informed this memory.

## 10. Memory Refresh Notes
- Last refresh: not yet recorded
MD
```

This `state.json` file is the source of truth for all sequence numbers. Every initiative, user story, and task must increment the relevant counter and save the artifact under `.sandstraw` with its sequence prefix. The project memory file in `.sandstraw/project-memory.md` is the living summary of the business domain, requirements, and technical context.

Tasks are the preferred implementation boundary. Each task should be stored as a task bundle with a summary file plus companion implementation artifacts: `spec.md` captures the agreed behavior, `plan.md` captures the execution sequence and validation steps, and `tech.md` captures architecture, stack, and decision context to guide GitHub Copilot during code changes.

Preferred layout:
```text
.sandstraw/product/initiatives/001-initiative-<short-name>/
  initiative.md
  001-story-<short-name>/
    story.md
    001-task-<short-name>/
      task.md
      spec.md
      plan.md
      tech.md
```

The project-level state and memory stay at the root of `.sandstraw/` so they remain shared across all initiative work.

> "All set. Here's where things stand: [project name] · IDEA stage."

## Step 1: Existing project

> "Hi — I'm Sandstraw. Your project is already set up."

If `.sandstraw/state.json` does not exist, create it with the default state object above before continuing. If it exists, validate that it contains:

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

If `.sandstraw/project-memory.md` does not exist, create the default global memory file before continuing.

If a project already has initiatives, stories, or tasks, read the current counters from `.sandstraw/state.json` and continue numbering from the highest value rather than resetting the sequence.