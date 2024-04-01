return {
  'jay-babu/mason-null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'nvimtools/none-ls.nvim',
    'nvim-cmp',
  },
  config = function()
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
  end,
}
