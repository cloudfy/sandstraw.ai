---
name: product-userstory-write
license: AGPL-3.0-or-later
user-invocable: true
description: "Creates markdown user stories from a clarified initiative and writes them to the Sandstraw product stories folder."
memory: project
context: fork
---

# Sandstraw Product User Story Writer Skill

## Purpose

Take a clarified initiative or story-read summary and produce one or more markdown user stories in `.sandstraw/product/stories`.

Each user story must be written in a business-first format and remain ready for eventual decomposition into implementation tasks.

## Input sources

- `.sandstraw/project-memory.md`
- `.sandstraw/product/initiatives/*.md`
- `.sandstraw/product/backlog/*.md`
- story summaries produced by the product-userstory-reader skill

## Rules

1. Never invent missing acceptance criteria.
2. If the initiative or story summary leaves open assumptions or critical gaps, ask clarifying questions before writing the story instead of guessing.
3. Keep the story grounded in the initiative and the project memory.
4. Write the story in business terms, not technology terms.
5. If a story is still ambiguous, list the missing information as open questions.
6. Each story should be independently understandable.
7. A user story may later be split into one or more implementation tasks, but the story itself should remain at the product value level.

## Supported output formats

The writer should support both of the following story representations without changing the underlying business intent:

1. Generic format

```markdown
## User Story
As a <user or actor>,
I want <goal or capability>,
so that <business value or outcome>.
```

2. Gherkin format

```markdown
## Scenario
Given <context>
When <event or action>
Then <expected outcome>
```

If the source story was created in a specific format, preserve that style unless the request explicitly asks for a different one. If the story is being created from a business summary that is format-neutral, generate the default generic format unless a Gherkin requirement is clearly requested.

## Story format

Before saving a user story, read `.sandstraw/state.json`, increment `sequence.userstory`, and persist the updated state. Then write the markdown file using the assigned sequence number and a clear slug, for example:

```text
.sandstraw/product/stories/001-user-story-<short-name>.md
```

Use this structure for the default generic story style:

```markdown
# <Story Title>

## User Story
As a <user or actor>,
I want <goal or capability>,
so that <business value or outcome>.

## Business Context

## Problem or Opportunity

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Constraints

## Dependencies

## Open Questions

## Story Notes

## Future Task Breakdown
This story may later be split into one or more tasks for code implementation.
```

When the requested output is Gherkin, use the equivalent structure below instead:

```markdown
# <Story Title>

## Scenario
Given <context>
When <event or action>
Then <expected outcome>

## Business Context

## Problem or Opportunity

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Constraints

## Dependencies

## Open Questions

## Story Notes

## Future Task Breakdown
This story may later be split into one or more tasks for code implementation.
```

## Writing process

1. Read the initiative and/or story summary.
2. Read `.sandstraw/project-memory.md` to confirm domain knowledge, constraints, and architecture or business decisions that this story must respect.
3. Determine the required output style: generic, Gherkin, or both.
4. Select the clearest candidate story themes.
5. Expand each theme into one or more user stories.
6. Write the user story in the chosen format while preserving the same business facts.
7. Include only confirmed business constraints and explicit open questions.
8. Save the result in `.sandstraw/product/stories/`.
9. Refresh the global project memory so the new story’s business outcome, acceptance criteria, and relevant context are reflected in the memory file.

## Completion rule

A user story is ready when:

- it is grounded in the initiative
- it is understandable without technical assumptions
- it includes clear acceptance criteria
- unresolved items are explicitly called out
- it is written in the selected format (generic, Gherkin, or both) without losing business meaning
- `.sandstraw/state.json` has been updated with the next `sequence.userstory` value
- it is saved as markdown in `.sandstraw/product/stories` with the sequence prefix applied

## Downstream task guidance

A story is not the implementation plan. It is the product-level requirement. After story creation, the next step is to split it into one or more tasks for code implementation, but that decomposition should happen later and separately from the story itself.
