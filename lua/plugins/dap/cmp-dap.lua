return {
  'rcarriga/cmp-dap',
  dependencies = {
    'nvim-cmp',
    'mfussenegger/nvim-dap',
  },
  event = 'LspAttach',
  config = function()
    require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
      sources = {
        { name = 'dap' },
      },
    })
  end,
}
