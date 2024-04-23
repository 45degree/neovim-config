;; lua
local lsp_config = require("lspconfig")
local default_clangd_cmd = require("lspconfig.configs").clangd.cmd
table.insert(
	default_clangd_cmd,
  {{_cursor_}}
)

lsp_config.clangd.setup({ cmd = default_clangd_cmd })
