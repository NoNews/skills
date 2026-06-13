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

Include, dense and scannable: **Goal** (from arguments, else inferred), **Context**, **Current state**, **Key decisions**, **Artifacts** (link PRDs/plans/PRs/commits/files by path or URL — never restate them), **Next steps**, **Open questions/risks**, **Suggested skills** (which to invoke and why; name only skills that plausibly exist, else describe the capability). Drop empty sections.

Summarise only what's not written down: live reasoning, dead ends, in-chat decisions. Redact secrets and PII as `[REDACTED]`. Confirm it's on the clipboard; don't reprint unless asked.
