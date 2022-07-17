return function (server)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  capabilities.offsetEncoding = 'utf-8'

  local opts = {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      require "lsp_signature".on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded"
        }
      }, bufnr)
    end,
  }
  if server == "clangd" then
    opts.cmd = {
      "clangd",
      "-header-insertion=never",
    }
  end

  return opts
end
