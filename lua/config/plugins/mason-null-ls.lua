local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
require('null-ls').setup({
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        -- on 0.8, you should use vim.lsp.buf.format instead
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

require('mason-null-ls').setup({
  automatic_setup = true,
  handlers = {
    function(source_name, methods)
      -- all sources with no handler get passed here

      -- To keep the original functionality of `automatic_setup = true`,
      -- please add the below.
      require('mason-null-ls.automatic_setup')(source_name, methods)
    end,
  },
})
