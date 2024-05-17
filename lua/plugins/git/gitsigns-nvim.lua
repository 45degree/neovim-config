local opts = {
  signs = {
    add = { text = '│' },
    change = { text = '│' },
    delete = { text = '│' },
    topdelete = { text = '│' },
    changedelete = { text = '│' },
    untracked = { text = '│' },
  },
}

return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config = function()
    require('gitsigns').setup(opts)
  end,
}
