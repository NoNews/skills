---
name: handoff-buffer
description: Compact the current conversation into a handoff document for another agent to pick up. Saves to the OS temp dir and copies to the clipboard.
argument-hint: What will the next session be used for?
---

# Handoff Buffer

Write a handoff document summarising the current conversation so a fresh agent can continue the work with zero prior context. Save it to the OS temporary directory and copy it to the clipboard.

## What to produce

A single Markdown document. Dense, factual, scannable. The reader is a capable agent with no memory of this conversation. Give it exactly what it needs to resume, and nothing it can get elsewhere.

If the user passed arguments, treat them as a description of what the next session will focus on. Tailor the whole document to that goal: lead with what matters for it, demote or drop the rest.

## Where to save it

1. Resolve the temp dir: use `$TMPDIR` if set, else `/tmp`.
2. Write to `${TMPDIR:-/tmp}/handoff-<slug>-<timestamp>.md`, where `<slug>` is a short kebab-case label for the task and `<timestamp>` is `date +%Y%m%d-%H%M%S`.
3. **Never** write into the current workspace or repo.
4. Copy the file contents to the macOS clipboard with `pbcopy`:

```bash
# write, then copy to the macOS clipboard
FILE="${TMPDIR:-/tmp}/handoff-$(date +%Y%m%d-%H%M%S).md"
# ... write the document to "$FILE" ...
pbcopy < "$FILE"        # load file into the clipboard buffer
```

After saving, tell the user the full path and confirm it's on the clipboard.

## Don't duplicate other artifacts

If a fact already lives in a durable artifact, reference it by path or URL instead of restating it:

- PRDs, design docs, plans, ADRs
- Issue trackers, tickets, PRs
- Git commits and diffs (cite SHAs / `git diff` ranges)
- Existing READMEs or code comments

Summarise only what's *not* written down anywhere: the live reasoning, dead ends, decisions made in-chat, and the current mental state of the work.

## Redact sensitive information

Strip before writing:

- API keys, tokens, passwords, secrets, connection strings
- Personally identifiable information
- Anything that would be unsafe in a file on disk or on a clipboard

Replace with `[REDACTED]` and note what kind of value it was if the next agent needs to know one exists.

## Document structure

Use this skeleton. Drop sections that are empty rather than padding them.

```markdown
# Handoff: <task title>

**Goal of next session:** <from the user's arguments, or inferred>
**Date:** <date>

## Context
What we're doing and why. 2-4 sentences.

## Current state
What's done, what works, what's in progress right now.

## Key decisions
Decisions made in this conversation and the reasoning. Bullet form.

## Artifacts
Links/paths to PRDs, plans, PRs, commits, files touched. Don't restate their contents.

## Next steps
Ordered list of what to do next. Specific and actionable.

## Open questions / risks
Unknowns, blockers, things to watch out for.

## Suggested skills
Skills the next agent should invoke, with a one-line why for each.
```

## Suggested skills section

Always include it. List the skills most relevant to the next session's goal, each with a short reason. Only suggest skills that plausibly exist in the target environment; if unsure, describe the capability instead of naming a skill.

## Output

After the file is written and copied:

- State the saved path.
- Confirm it's on the clipboard.
- Don't paste the whole document back into chat unless the user asks.
