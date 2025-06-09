return {
  'OXY2DEV/markview.nvim',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  submodules = false,
  ft = { 'markdown', 'typst', 'codecompanion' },
  cmd = 'Markview',
  opts = { preview = { enable = true, filetypes = { 'markdown', 'typst', 'codecompanion' }, ignore_buftypes = {} } },
}
