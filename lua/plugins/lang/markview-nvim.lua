local enabled_filetypes = { 'markdown', 'typst', 'codecompanion', 'opencode_input', 'opencode_output' }

return {
  'OXY2DEV/markview.nvim',
  submodules = false,
  ft = enabled_filetypes,
  cmd = 'Markview',
  opts = {
    preview = { enable = true, filetypes = enabled_filetypes, ignore_buftypes = {} },
  },
}
