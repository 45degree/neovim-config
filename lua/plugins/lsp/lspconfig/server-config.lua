---@diagnostic disable: undefined-global, deprecated

return function(server)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Enable LSP folddingRange capability
  -- capabilities.textDocument.foldingRange = {
  --   dynamicRegistration = false,
  --   lineFoldingOnly = true,
  -- }

  local opts = {
    capabilities = capabilities,
  }

  ---
  ---@param client vim.lsp.Client
  ---@param bufnr integer
  opts.on_attach = function(client, bufnr)
    -- disable treesitter if lsp support semantic highlight
    if client.supports_method(vim.lsp.protocol.Methods.textDocument_semanticTokens_full) then vim.treesitter.stop(bufnr) end
  end

  local status, config = pcall(require, 'plugins.lsp.lspconfig.server.' .. server)
  if status then return config(opts) end

  return opts
end
