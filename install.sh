#!/usr/bin/env bash
# Installs every plugin in the coding-agent-plugins marketplace for the
# current user. Safe to re-run (marketplace add / plugin install both no-op
# if already present).
set -euo pipefail

MARKETPLACE_SOURCE="Ixiandesign/SRG_Code_Plugin"
MARKETPLACE_NAME="coding-agent-plugins"
PLUGINS=(
  context7
  github
  code-review
  mattpocock-skill-creator
  mattpocock-tdd
  clangd-lsp
  pyright-lsp
  matlab-mcp
)

if ! command -v claude >/dev/null 2>&1; then
  echo "claude CLI not found on PATH — install Claude Code first: https://claude.com/claude-code" >&2
  exit 1
fi

claude plugin marketplace add "$MARKETPLACE_SOURCE"

for plugin in "${PLUGINS[@]}"; do
  claude plugin install "${plugin}@${MARKETPLACE_NAME}"
done

cat <<EOF

Installed: ${PLUGINS[*]}

github needs GITHUB_PERSONAL_ACCESS_TOKEN set.
clangd-lsp/pyright-lsp need clangd/pyright-langserver on PATH.
matlab-mcp needs local setup — see plugins/matlab-mcp/README.md in the marketplace repo.
EOF
