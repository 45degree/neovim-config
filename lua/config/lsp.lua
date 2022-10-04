---@diagnostic disable: undefined-global, deprecated

local clangd_flags = {
  "--all-scopes-completion",
  "--suggest-missing-includes",
  "--background-index",
  "--pch-storage=disk",
  "--cross-file-rename",
  "--log=info",
  "--completion-style=detailed",
  "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
  "--clang-tidy",
  -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
  -- "--fallback-style=Google",
  -- "--header-insertion=never",
  -- "--query-driver=<list-of-white-listed-complers>"
}

return function (server)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  capabilities.offsetEncoding = 'utf-8'

  local opts = {
    capabilities = capabilities,
    on_attach = function(_, bufnr)
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
      unpack(clangd_flags)
    }
  end

  return opts
end
