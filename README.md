# coding-agent-plugins

A Claude Code plugin marketplace bundling skill-authoring/TDD skills, language-server code
intelligence, and a few official integrations — install once, get all of it.

## Plugins

### Mirrored, from real upstream sources

Referenced via pinned `git-subdir` sources in [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json) —
not copied or reimplemented. Bump the `sha`/`ref` deliberately when picking up upstream changes.

| Plugin | Covers | Mirrored from |
|---|---|---|
| `mattpocock-skill-creator` | Reference for writing skills, `AGENTS.md`, `CLAUDE.md` (Matt Pocock's `writing-for-agents`) | `mattpocock/skills` |
| `mattpocock-tdd` | Test-driven development: red-green loop, seams, test anti-patterns | `mattpocock/skills` |
| `context7` | Up-to-date, version-specific library documentation | `anthropics/claude-plugins-official` |
| `github` | GitHub repo/issue/PR management | `anthropics/claude-plugins-official` |
| `code-review` | Automated multi-agent PR review | `anthropics/claude-plugins-official` |

### Authored here

| Plugin | Covers | Prerequisite |
|---|---|---|
| [`clangd-lsp`](plugins/clangd-lsp) | C/C++/Objective-C code intelligence | `clangd` on PATH |
| [`pyright-lsp`](plugins/pyright-lsp) | Python code intelligence | `pyright-langserver` on PATH (`npm install -g pyright`) |
| [`matlab-mcp`](plugins/matlab-mcp) | Run/analyze MATLAB code via MathWorks' official MCP server | one-time local setup — see [its README](plugins/matlab-mcp/README.md) |

No official MATLAB language-server plugin exists anywhere as of this writing (checked directly, not
assumed); `matlab-mcp` uses MathWorks' own MCP server instead, which does more than an LSP would
(runs code, not just diagnostics) at the cost of needing a local binary + MATLAB path.

## Installing everything, one line

Requires the `claude` CLI already installed. Adds the marketplace and installs all 8 plugins
(`scope: user`, so they're available in every project on the machine, not just one repo). Safe to
re-run — both `marketplace add` and `plugin install` no-op if already present.

macOS/Linux/Git Bash:
```bash
curl -fsSL https://raw.githubusercontent.com/Ixiandesign/SRG_Code_Plugin/main/install.sh | bash
```

Windows PowerShell:
```powershell
irm https://raw.githubusercontent.com/Ixiandesign/SRG_Code_Plugin/main/install.ps1 | iex
```

Each script still prints the per-plugin prerequisites below (env vars, `clangd`/`pyright` on PATH,
MATLAB MCP setup) — installing doesn't skip those.

## Installing selectively

```
/plugin marketplace add Ixiandesign/SRG_Code_Plugin
/plugin
```

Then enable whichever plugins that project needs — not every repo needs every language's LSP.

## Environment variables

- `github` needs `GITHUB_PERSONAL_ACCESS_TOKEN` (a GitHub personal access token; no Copilot
  subscription required).
- `context7` works anonymously; set `CONTEXT7_API_KEY` for higher rate limits.

## Cross-harness notes

Claude Code's own `SKILL.md`/`plugin.json`/`.lsp.json` conventions are Claude-Code-specific — other
harnesses don't read them natively. What *is* portable:

- `context7`, `github`, and `matlab-mcp` are plain stdio/HTTP **MCP servers**, so they work unchanged
  in any MCP-compatible harness (Cursor, Windsurf, VS Code Copilot, Claude Desktop, ...).
- The two Matt Pocock skills are also installable outside Claude Code via his own installer:
  `npx skills@latest add mattpocock/skills` (supports Codex and other agents).
- `clangd-lsp` and `pyright-lsp` are Claude Code's `.lsp.json` convention specifically — other
  harnesses typically ship their own native LSP integration instead.

## Contributing to this repo

See [AGENTS.md](AGENTS.md).
