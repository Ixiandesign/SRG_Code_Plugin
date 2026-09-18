# AGENTS.md — SRG_Code_Plugin (this repo)

This file documents conventions for contributing to **this repo itself** — the plugin marketplace.
It is not the lab's experiment/machine-safety conventions; those live in
`plugins/lab-conventions/templates/AGENTS.md`, which is the template consuming project repos copy in.

## What this repo is

A Claude Code plugin marketplace for the Schoop Research Group. It ships two plugins:

- `plugins/machine-control` — KMotion/KFlop CNC integration and PFV4/camera trigger sync for the
  custom in-situ orthogonal cutting machine.
- `plugins/lab-conventions` — experiment metadata schema, file naming, general coding best practices,
  and the AGENTS.md template other project repos bootstrap from.

A third plugin, `dic-piv-analysis` (NCORR/PIV/DIC), is deferred — see the architecture plan referenced
in commit history for the scoped-but-not-yet-built skill/agent/LSP list.

## Conventions for this repo

- Each plugin under `plugins/<name>/` is self-contained: its own `.claude-plugin/plugin.json`, and
  only the `skills/`, `agents/`, `hooks/`, `.mcp.json`, `.lsp.json` it actually needs.
- Keep `SKILL.md` bodies focused — split a skill when it starts covering mutually-exclusive contexts
  rather than letting one file grow into a catch-all.
- Only add a subagent when it needs a genuinely different tool-access or system-prompt profile from
  the main assistant — default to a skill.
- When adding a new sub-plugin, register it in `.claude-plugin/marketplace.json`.
- Validate structure with `claude plugin validate ./plugins/<name>` before committing a new plugin.
