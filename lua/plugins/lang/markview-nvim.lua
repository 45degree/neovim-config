return {
  'OXY2DEV/markview.nvim',
  submodules = false,
  ft = { 'markdown', 'typst' },
  cmd = 'Markview',
  opts = { preview = { enable = true, filetypes = { 'markdown', 'typst' }, ignore_buftypes = {} } },
}
