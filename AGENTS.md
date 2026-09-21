# AGENTS.md — coding-agent-plugins (this repo)

This file documents conventions for contributing to **this repo itself** — the plugin marketplace.

## What this repo is

A Claude Code plugin marketplace (see [README.md](README.md) for the full plugin list): two skills
mirrored from Matt Pocock, three authored code-intelligence plugins (C/C++/Objective-C, Python,
MATLAB), and three mirrored official plugins (context7, github, code-review).

## Conventions for this repo

- Each authored plugin under `plugins/<name>/` is self-contained: its own `.claude-plugin/plugin.json`,
  and only the `.lsp.json`/`.mcp.json`/`skills/` it actually needs. Mirrored plugins have **no** local
  directory — they're pure `git-subdir` entries in `.claude-plugin/marketplace.json`, fetched from
  upstream at install time.
- When adding a new plugin, register it in `.claude-plugin/marketplace.json` and add a row to
  `README.md`'s plugin table.
- Pin every `git-subdir` source to a specific `sha` (get it with `git ls-remote <url> HEAD`); don't
  track `main` unpinned. Bump it deliberately, not automatically.
- Validate structure with `claude plugin validate ./plugins/<name>` before committing a new authored
  plugin, and `claude plugin validate .` for the marketplace itself.
- Before proposing a plugin for something that doesn't exist yet upstream (e.g. no ready-made LSP for
  a language), check for a real alternative (an MCP server, a different tool) before hand-authoring a
  config from scratch — and say so explicitly if none exists, rather than assuming one does.
