---
name: agents-md-project-bootstrap
description: Use when setting up a new Schoop Research Group project repo, or when a repo is missing an AGENTS.md/CLAUDE.md pair — copies and customizes this plugin's AGENTS.md template so the repo works consistently across Claude Code, Cursor, Windsurf, and other AGENTS.md-reading tools. Trigger on "set up a new project", "add AGENTS.md", or "this repo doesn't have lab conventions documented".
---

# AGENTS.md project bootstrap

## Why two files

AGENTS.md is the emerging open, cross-tool standard read natively by Cursor, Windsurf, Codex, Gemini CLI, Zed, and others. Claude Code specifically reads `CLAUDE.md`, not `AGENTS.md`. Rather than maintaining two divergent sets of instructions, every lab project repo should have:

- `AGENTS.md` — the actual content: machine safety notes, experiment/file-naming conventions, environment notes (MATLAB version, .NET version, Python environment). This is the file that gets edited.
- `CLAUDE.md` — a one-line import: `@AGENTS.md`. Never add real content here; if it grows content of its own, it'll drift from what other tools see.

## Bootstrapping a new project repo

1. Copy `templates/AGENTS.md` from this plugin into the new repo's root as `AGENTS.md`.
2. Fill in the project-specific sections (what this repo does, which lab systems it touches — machine control, analysis, or both).
3. Create `CLAUDE.md` in the new repo containing exactly one line: `@AGENTS.md`.
4. If the project uses the `machine-control` plugin, make sure the new repo enables it (`/plugin`) so the KMotion/camera-sync skills and the safety agent are active there.

## Keeping the template current

If a lab-wide convention changes (naming scheme, required metadata fields, a new safety note), update `templates/AGENTS.md` in this plugin — new projects bootstrapped afterward pick it up automatically. Existing projects need the change copied in manually; there's no automatic sync, so periodically diff a project's `AGENTS.md` against the current template if it's been a while.
