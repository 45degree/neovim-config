local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
require('null-ls').setup({})

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
