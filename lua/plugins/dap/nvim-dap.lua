return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'williamboman/mason.nvim',
  },
  event = 'VeryLazy',
  config = function()
    vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = ' ', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '⭐️', texthl = '', linehl = '', numhl = '' })
    require('plugins.dap.dapconfig.dap-config').setup()
  end,
}
