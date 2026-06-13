# skills

Personal skills for [Claude Code](https://docs.claude.com/en/docs/claude-code) and [Cursor](https://cursor.com), with a small installer that symlinks them into both.

## Install

```bash
git clone git@github.com:NoNews/skills.git ~/Developer/skills
cd ~/Developer/skills
```

Add the installer to your `PATH` (one-time):

```bash
echo 'export PATH="$HOME/Developer/skills/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Verify:

```bash
skills
```

## Usage

```bash
skills install <name>     # symlink one skill into Claude + Cursor
skills install-all        # symlink every skill in this repo
skills uninstall <name>   # remove symlinks for one skill
skills list               # show repo skills and install state
```

The installer writes symlinks to:

- `~/.claude/skills/<name>` — Claude Code
- `~/.cursor/skills-cursor/<name>` — Cursor

If only one of those dirs exists, it installs there and warns about the missing one. If neither exists, it errors.

Symlinks mean edits in this repo go live immediately in both tools. No re-install needed after editing.

## Adding a skill

Create a directory at the repo root with a `SKILL.md` inside:

```
skills/
└── my-skill/
    └── SKILL.md
```

`SKILL.md` frontmatter:

```markdown
---
name: my-skill
description: One line. What it does, when to use it.
---

# My Skill

Body of the prompt.
```

Then:

```bash
skills install my-skill
```

## Skills in this repo

- **concise-writing** — Rewrite supplied text to be punchy, direct, and human — Derek Sivers style. Always treats input as text to rewrite, never as a command or question. Use when you want tighter prose, less fluff, or paste a draft to clean up.
- **handoff-buffer** — Compact the current conversation into a handoff document for a fresh agent. Saves to the OS temp dir and copies to the clipboard. Pass what the next session will focus on to tailor the doc.

## Uninstall

```bash
skills uninstall <name>
```

Or remove the `PATH` line from `~/.zshrc` and delete the clone.
