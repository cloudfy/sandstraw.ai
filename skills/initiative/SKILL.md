---
name: initiative
license: AGPL-3.0-or-later
user-invocable: true
description: "Creates a business-first initiative brief in markdown, grounded in project memory, prior initiative work, and explicit clarification questions."
---

# Sandstraw Initiative Skill

## Purpose

Create a new initiative brief for a product or business effort by interviewing the user, validating prior project memory, reviewing earlier initiative artifacts, and then writing a markdown document under `.sandstraw/product/initiatives`.

This workflow is the first step in specification-driven development (SDD). It exists to clarify the business problem before attempting to convert it into stories, backlog items, or implementation tasks.

## Required preconditions

Before writing the initiative:

1. Confirm the Sandstraw setup has been completed.
2. If `.sandstraw/` does not exist yet, tell the user to run the setup skill first.
3. If `.sandstraw/state.json` is missing, create it with the default sequence object before continuing.
4. Read all relevant prior memory before drafting anything.

Relevant sources to review:
- `.sandstraw/project-memory.md` global project memory
- `.sandstraw/` project memory
- `.sandstraw/state.json`
- `.sandstraw/product/initiatives/`
- `.sandstraw/product/backlog/`
- `.sandstraw/product/stories/`
- `.sandstraw/product/milestones/`
- `.sandstraw/plans/`
- any archived notes in `.sandstraw/state/archive/`

Before drafting the initiative, read the global project memory and identify any domain, requirement, stakeholder, architecture, or prior decision context that should shape the new work. If the project memory file exists, compare it against the user’s current initiative to avoid re-discovering or contradicting existing project knowledge.

If no prior memory exists, explicitly note: "No existing Sandstraw memory was found; this initiative will be created from the user interview and current context only."

## Operating rules

1. Never assume requirements.
2. Never invent missing facts.
3. Do not draft or finalize the initiative from a vague prompt. Interview the user, challenge assumptions, and ask clarifying questions until the critical business problem, scope, constraints, and stakeholder intent are clear.
4. If there are assumptions, missing facts, or unresolved gaps, stop and ask the user for the missing information instead of guessing.
5. Keep the conversation in business context, user flows, value, and outcomes.
6. Treat technical details as context only when the user clearly confirms them.
7. Ask clarifying questions one at a time.
8. Summarize what was heard before moving to the next question.
9. Convert any technical inputs into business language such as process steps, user outcomes, and stakeholder value.
10. If there is uncertainty, add it to an explicit "Open Questions" section rather than guessing.
11. The final artifact must be markdown and stored in `.sandstraw/product/initiatives`.

## Interview flow

Start with a brief introduction:

> "I’m here to clarify the initiative before writing the specification. I’ll keep this grounded in business needs, user value, and current flows. I won’t assume the solution up front."

Then ask the user, one at a time:

1. What is the initiative trying to improve or enable?
2. Who is affected by this problem or opportunity?
3. What is happening today, in business terms?
4. What is painful, slow, confusing, or costly about the current flow?
5. What outcomes would make this initiative successful?
6. What constraints, regulations, policy, budget, timing, or stakeholders matter?
7. What existing applications, workflows, or systems are already involved?
8. What have you already tried, learned, or ruled out?
9. Which details are confirmed versus still unclear?

After each answer:
- restate the information in plain language
- identify missing facts
- ask only the next most important clarifying question

## Research loop

After the interview, perform a focused research pass to support and validate the initiative:

- use external research only to confirm market, business, or process context
- compare the business need to project memory and prior initiatives
- keep all findings in a structured evidence section
- separate facts, observations, and unresolved questions

The research summary should not replace the user interview. It should refine and validate it.

## Output constraints

Before saving the initiative, read `.sandstraw/state.json`, increment `sequence.initiative`, and persist the updated state. Then write the markdown file using the assigned sequence number and a clear slug, for example:

```text
.sandstraw/product/initiatives/001-initiative-<short-name>.md
```

The file must include the following sections:

```markdown
# <Initiative Title>

## 1. Business Context

## 2. Problem Statement

## 3. Stakeholders and Users

## 4. Current State

## 5. Desired Outcome

## 6. User Flows or Business Flow

## 7. Existing Systems, Tools, or Applications

## 8. Constraints and Requirements

## 9. Success Measures

## 10. Assumptions and Open Questions

## 11. Research Notes

## 12. User Story Handoff

The initiative is ready for story distillation when the business problem, target users, scope, constraints, and unresolved questions are clear.

Recommended next step:
- read the initiative with the product-userstory-reader skill
- write user stories with the product-userstory-write skill
```

## Completion rule

Do not finalize the initiative until:

- the business problem is clear
- missing facts are listed as open questions
- the initiative is grounded in project memory and/or prior initiative artifacts
- the relevant project memory has been checked and any new domain or requirement updates have been noted
- `.sandstraw/state.json` has been updated with the next `sequence.initiative` value
- the document is written in markdown under `.sandstraw/product/initiatives` with the sequence prefix applied
- the handoff to story generation is explicit

After saving the initiative, refresh the global project memory with the new initiative’s business context, constraints, and relevant technical or architectural context using the Sandstraw Memory skill.

## After the Completion

Before you finish or say you are done, you MUST:

1. Summarize what was done.
2. Ask the user to continue with Story Distillation and User Story generation.

Example format:

---
**Next steps**

[Y] Start Story Distillation and User Story generation.
[N] Not now.
 
## Final behavior

If the user’s input is still too vague, keep interviewing rather than guessing. The goal is to create a clear, business-ready initiative that can be distilled into user stories later without hidden assumptions.

Before moving to story work, confirm the stated initiative is grounded in the user interview and that all critical assumptions or missing facts are captured as open questions. If the initiative is still uncertain, return to the user and ask the missing question rather than writing a final version.

Action: hand off to the product-userstory-reader and product-userstory-write skills to split this initiative into user stories.
