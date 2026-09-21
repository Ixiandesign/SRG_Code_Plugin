# matlab-mcp

Wires up MathWorks' official [MATLAB MCP Server](https://github.com/matlab/matlab-mcp-server) —
start/quit MATLAB, run code in an active session, and check style/correctness from the agent.

No plugin can vendor MATLAB itself or a prebuilt binary for every OS, so this one needs a one-time
local setup before it works:

1. Install MATLAB R2021a or later and make sure it's on your system PATH.
2. Download the `matlab-mcp-server` binary for your OS from the
   [latest release](https://github.com/matlab/matlab-mcp-server/releases/latest) (or build it with
   `go install github.com/matlab/matlab-mcp-server/cmd/matlab-mcp-server@latest`).
3. Edit [`.mcp.json`](.mcp.json) in this plugin directory:
   - `command` → full path to the binary you downloaded/built.
   - `env.MW_MCP_SERVER_MATLAB_ROOT` → your local MATLAB installation path.

Other optional settings from upstream (pass as extra `args` or env vars if needed):

| Flag | Env var | Purpose |
|---|---|---|
| `--initial-working-folder` | `MW_MCP_SERVER_INITIAL_WORKING_FOLDER` | Working directory |
| `--matlab-display-mode` | `MW_MCP_SERVER_MATLAB_DISPLAY_MODE` | `desktop` or `nodesktop` |
| `--disable-telemetry` | `MW_MCP_SERVER_DISABLE_TELEMETRY` | Set `true` to opt out |

This is a standard stdio MCP server, so the same binary/config also works in VS Code and Claude
Desktop, not just Claude Code — see upstream's README for their `.vscode/mcp.json` example.
