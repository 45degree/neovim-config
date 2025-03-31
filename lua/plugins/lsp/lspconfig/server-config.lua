---@diagnostic disable: undefined-global, deprecated

return function(server)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
  -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
    if client == nil then
      vim.notify('client is nil', vim.log.levels.ERROR)
      return
    end

    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('LspCallbacks', { clear = true }),
      callback = function() vim.lsp.buf.clear_references() end,
    })

    local methods = vim.lsp.protocol.Methods

    -- enable treesitter if lsp not support semantic highlight
    if client:supports_method(methods.textDocument_semanticTokens_full) then vim.treesitter.stop(bufnr) end

    if client:supports_method(methods.textDocument_inlayHint) then
      local inlay_hints_group = vim.api.nvim_create_augroup('toggle_inlay_hints', { clear = false })
      vim.defer_fn(function()
        local mode = vim.api.nvim_get_mode().mode
        vim.lsp.inlay_hint.enable(mode == 'n' or mode == 'v', { bufnr = bufnr })
      end, 500)

      vim.api.nvim_create_autocmd('InsertEnter', {
        group = inlay_hints_group,
        desc = 'Enable inlay hints',
        buffer = bufnr,
        callback = function() vim.lsp.inlay_hint.enable(false, { bufnr = bufnr }) end,
      })

      vim.api.nvim_create_autocmd('InsertLeave', {
        group = inlay_hints_group,
        desc = 'Disable inlay hints',
        buffer = bufnr,
        callback = function() vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end,
      })
    end

    if client:supports_method(methods.textDocument_codeLens) then
      local code_lens_group = vim.api.nvim_create_augroup('toggle_code_lens', { clear = false })
      vim.defer_fn(function() vim.lsp.codelens.refresh() end, 500)

      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
        desc = 'Refresh Code Lens',
        group = code_lens_group,
      })
    end
  end

  local status, config = pcall(require, 'plugins.lsp.lspconfig.server.' .. server)
  if status then return config(opts) end

  return opts
end
