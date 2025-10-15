return {
  'folke/lsp-colors.nvim',
  event = 'LspAttach',
  enabled = false,
  -- dependencies = { 'nvim-cmp' },
  opts = {
    Error = '#db4b4b',
    Warning = '#e0af68',
    Information = '#0db9d7',
    Hint = '#10B981',
  },
}
