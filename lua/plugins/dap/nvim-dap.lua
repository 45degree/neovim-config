return {
  'mfussenegger/nvim-dap',
  dependencies = { 'igorlfs/nvim-dap-view', 'mason-org/mason.nvim' },
  lazy = true,
  keys = {
    { '<F4>', function() require('dap').terminate() end, desc = 'DAP terminate' },
    { '<F5>', function() require('dap').continue() end, desc = 'DAP continue' },
    { '<F6>', function() require('dap').pause() end, desc = 'DAP pause' },
    { '<F7>', function() require('dap').run_to_cursor() end, desc = 'DAP run to cursor' },
    { '<F8>', function() require('dap').set_breakpoint(vim.fn.input('[Condition] > ')) end, desc = 'DAP conditional breakpoint' },
    { '<F9>', function() require('dap').toggle_breakpoint() end, desc = 'DAP toggle breakpoint' },
    { '<F10>', function() require('dap').step_over() end, desc = 'DAP step over' },
    { '<F11>', function() require('dap').step_into() end, desc = 'DAP step into' },
    { '<F12>', function() require('dap').step_out() end, desc = 'DAP step out' },
  },
  config = function()
    vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DiagnosticError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = 'DiagnosticError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = ' ', texthl = 'DiagnosticOk', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'Comment', linehl = '', numhl = '' })
    require('config.dap.init').setup()
  end,
}
