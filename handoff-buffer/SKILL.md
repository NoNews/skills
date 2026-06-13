---
name: handoff-buffer
description: Compact the current conversation into a handoff document for another agent to pick up, and copy it to the macOS clipboard. Writes no files.
argument-hint: What will the next session be used for?
---

# Handoff Buffer

Condense the conversation into a handoff doc for a fresh agent with zero context, then copy it to the clipboard. **Write no files** — `pbcopy` is the only output.

```bash
pbcopy <<'HANDOFF'
...document...
HANDOFF
```

Include, dense and scannable:

1. **Problem** — what we're solving and the done-condition (from arguments, else inferred).
2. **Key decisions & state** — choices made, dead ends ruled out, what's done vs in-progress, with critical links/paths inline. Link PRDs/plans/PRs/commits/files by path or URL — never restate them.
3. **Next steps** — ordered, actionable; flag any blocking unknown on the step it threatens.
4. **Suggested skills** — which to invoke and why; name only skills that plausibly exist, else describe the capability.

Summarise only what's not written down: live reasoning, dead ends, in-chat decisions. Redact secrets and PII as `[REDACTED]`. Confirm it's on the clipboard; don't reprint unless asked.
