---
spdx-license: AGPL-3.0-or-later
user-invocable: true
description: "Reads initiative briefs and extracts business-ready user story candidates without inventing missing requirements."
---

# Sandstraw Product User Story Reader Skill

## Purpose

Read one or more initiative files in `.sandstraw/product/initiatives` and turn them into a clear, story-ready summary that can be used to generate user stories.

This skill does not write implementation detail. It extracts the business intent, the user value, the surrounding flows, and the constraints so that the writer skill can create accurate user stories without guesswork.

## Input sources

- `.sandstraw/project-memory.md`
- `.sandstraw/product/initiatives/*.md`
- `.sandstraw/product/backlog/*.md`
- `.sandstraw/product/stories/*.md`
- project memory in `.sandstraw/`

## Supported story formats

This skill accepts either of the following user-story representations and normalizes them into the same business summary model:

1. Generic format

```text
As a <user or actor>,
I want <goal or capability>,
so that <business value or outcome>.
```

2. Gherkin format

```text
Given <context>
When <event or action>
Then <expected outcome>
```

The reader should detect which format is present before extracting information. If the source contains both patterns, prefer the version with the clearest actor, goal, and outcome, and capture any mismatches as open questions instead of guessing.

## Rules

1. Never assume missing requirements.
2. Read prior initiative and story documents before making deductions.
3. Keep the analysis in business language.
4. Separate facts, observations, and unresolved questions.
5. Identify candidate user stories, but do not force a story if the initiative is still ambiguous.
6. Preserve the initiative’s intent instead of rewriting it into a technical design.
7. Normalize both formats into the same canonical fields: actor, goal, value, acceptance criteria, scenario steps, and unresolved questions.

## Process

1. Read the initiative and identify:
   - the business problem
   - target users or stakeholders
   - workflows or value streams
   - constraints and success criteria
   - open questions
2. Read `.sandstraw/project-memory.md` and compare the initiative to the current project memory for domain, requirement, stakeholder, and technical context.
3. Check any existing stories or backlog items for overlap or conflict.
4. Summarize the initiative into one or more candidate story themes.
4. For each candidate story, capture:
   - user or actor
   - desired outcome
   - business value
   - assumptions
   - unresolved questions
5. Return a markdown summary suitable for the writer skill.

## Format detection and normalization

Before summarizing, inspect the input for either format:

- Generic story detection: look for `As a`, `I want`, and `so that` or equivalent sentence structure.
- Gherkin detection: look for `Given`, `When`, and `Then` lines or a single scenario block.

Once detected, convert the input into a canonical model with these fields:

- Actor / user
- Goal / capability
- Business value / outcome
- Preconditions or context
- Triggering action
- Expected result
- Acceptance criteria
- Open questions

## Output format

```markdown
# Story Read Summary

## Initiative
- Title:
- Source file:

## Story Format Detected
- Generic / Gherkin / Mixed

## Business Problem

## Users and Stakeholders

## Core Flows or Value Streams

## Candidate Story Themes

### Story Theme 1
- User / Actor:
- Goal:
- Business value:
- Preconditions / Given:
- Trigger / When:
- Expected result / Then:
- Constraints:
- Open questions:

### Story Theme 2
- User / Actor:
- Goal:
- Business value:
- Preconditions / Given:
- Trigger / When:
- Expected result / Then:
- Constraints:
- Open questions:

## Unresolved Questions

## Recommended Next Step
Use the product-userstory-write skill to turn the accepted story themes into concrete markdown user stories in the required output style.
```

## Completion rule

Only proceed to story writing when the business goal, user value, and boundaries are clear enough to write a credible user story. If not, return the unresolved questions instead of generating weak or invented stories.
