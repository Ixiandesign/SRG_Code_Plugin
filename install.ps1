# Installs every plugin in the coding-agent-plugins marketplace for the
# current user. Safe to re-run (marketplace add / plugin install both no-op
# if already present).
$ErrorActionPreference = "Stop"

$MarketplaceSource = "Ixiandesign/SRG_Code_Plugin"
$MarketplaceName = "coding-agent-plugins"
$Plugins = @(
  "context7",
  "github",
  "code-review",
  "mattpocock-skill-creator",
  "mattpocock-tdd",
  "clangd-lsp",
  "pyright-lsp",
  "matlab-mcp"
)

if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
  Write-Error "claude CLI not found on PATH -- install Claude Code first: https://claude.com/claude-code"
  exit 1
}

claude plugin marketplace add $MarketplaceSource

foreach ($plugin in $Plugins) {
  claude plugin install "$plugin@$MarketplaceName"
}

Write-Host ""
Write-Host "Installed: $($Plugins -join ', ')"
Write-Host ""
Write-Host "github needs GITHUB_PERSONAL_ACCESS_TOKEN set."
Write-Host "clangd-lsp/pyright-lsp need clangd/pyright-langserver on PATH."
Write-Host "matlab-mcp needs local setup -- see plugins/matlab-mcp/README.md in the marketplace repo."
