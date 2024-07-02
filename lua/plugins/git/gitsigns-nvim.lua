local opts = {
  signs = {
    add = { text = '│' },
    change = { text = '│' },
    delete = { text = '│' },
    topdelete = { text = '│' },
    changedelete = { text = '│' },
    untracked = { text = '│' },
  },
  current_line_blame = true
}

return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config = function()
    require('gitsigns').setup(opts)
  end,
}
