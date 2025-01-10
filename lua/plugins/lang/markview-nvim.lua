return {
  'OXY2DEV/markview.nvim',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  branch = 'dev',
  ft = { 'markdown', 'Avante', 'typst' },
  cmd = 'Markview',
  opts = { preview = { enable = true, filetypes = { 'markdown', 'typst', 'Avante' } } },
}
