---@diagnostic disable: undefined-global, deprecated

return function(server)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  local opts = {
    capabilities = capabilities,
  }

  local status, config = pcall(require, 'config.lsp.server.' .. server)
  if status then
    return config(opts)
  end

  return opts
end
