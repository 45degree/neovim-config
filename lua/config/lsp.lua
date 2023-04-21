---@diagnostic disable: undefined-global, deprecated

return function(server)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  local opts = {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      require('lsp_signature').on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = 'rounded',
        },
      }, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
    end,
  }

  local status, config = pcall(require, 'config.lsp.' .. server)
  if status then
    return config(opts)
  end

  return opts
end
