return {
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    enabled = false,
    config = function()
      local opts = {
        library = {
          vim.env.LAZY .. '/luvit-meta/library', -- see below
          vim.env.LAZY .. '/mason.nvim/lua',
          vim.env.LAZY .. '/plenary.nvim/lua',
          -- You can also add plugins you always want to have loaded.
          -- Useful if the plugin has globals or types you want to use
          -- vim.env.LAZY .. "/LazyVim", -- see below
        },
      }
      require('lazydev.nvim').setup(opts)
    end,
  },
  { 'Bilal2453/luvit-meta', lazy = true, enabled = false },
}
