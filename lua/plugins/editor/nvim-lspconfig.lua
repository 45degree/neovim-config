return {
  'neovim/nvim-lspconfig',
  event = { 'LazyFile', 'BufReadPre' },
  dependencies = {
    'folke/neoconf.nvim',
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
  },
  config = function()
    require('neoconf').setup()

    local disabled_server = require('config').lsp.disabled

    local enabled_server = vim.list_extend({}, require('config').lsp.enabled)
    for _, server in ipairs(require('mason-lspconfig').get_installed_servers()) do
      if disabled_server ~= nil and vim.list_contains(disabled_server, server) then goto continue end
      table.insert(enabled_server, server)
      ::continue::
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    vim.lsp.config('*', { capabilities = capabilities })
    vim.lsp.enable(enabled_server)

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client == nil then
          vim.notify('client is nil', vim.log.levels.ERROR)
          return
        end

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('LspCallbacks', { clear = true }),
          callback = function() vim.lsp.buf.clear_references() end,
        })

        local methods = vim.lsp.protocol.Methods

        if client:supports_method(methods.textDocument_semanticTokens_full) then vim.treesitter.stop(bufnr) end

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

        if client:supports_method(methods.textDocument_foldingRange) then
          local win = vim.api.nvim_get_current_win()
          vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end
      end,
    })

    vim.keymap.set('n', 'gd', function() require('snacks.picker').lsp_definitions({ layout = 'ivy' }) end, { noremap = true, silent = true })
    vim.keymap.set('n', 'gi', function() require('snacks.picker').lsp_implementations({ layout = 'ivy' }) end, { noremap = true, silent = true })
    vim.keymap.set('n', 'gr', function() require('snacks.picker').lsp_references({ layout = 'ivy' }) end, { noremap = true, silent = true })
    vim.keymap.set('n', 'K', function(...) vim.lsp.buf.hover(...) end, { noremap = true, silent = true })
    vim.keymap.set('n', 'rn', function(...) vim.lsp.buf.rename(...) end, { noremap = true, silent = true })
    vim.keymap.set('n', 'ca', function(...) vim.lsp.buf.code_action(...) end, { noremap = true, silent = true })
  end,
}
