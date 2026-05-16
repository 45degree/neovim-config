return {
  'rcarriga/cmp-dap',
  dependencies = {
    'nvim-cmp',
    'mfussenegger/nvim-dap',
  },
  ft = { 'dap-repl', 'dap-view' },
  enabled = false,
  config = function()
    require('cmp').setup.filetype({ 'dap-repl', 'dap-view' }, {
      sources = {
        { name = 'dap' },
      },
    })
  end,
}
