return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'mason-org/mason.nvim',
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/nvim-dap-ui',
  },
  lazy = true,
  init = function()
    -- set key map
    vim.keymap.set('n', '<F4>', function()
      require('dap').terminate()
      require('dap').disconnect()
    end)
    vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
    vim.keymap.set('n', '<F6>', function() require('dap').pause() end)
    vim.keymap.set('n', '<F7>', function() require('dap').run_to_cursor() end)
    vim.keymap.set('n', '<F8>', function() require('dap').set_breakpoint(vim.fn.input('[Condition] > ')) end)
    vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end)
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
    vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
    vim.keymap.set('n', 'DK', function() require('dapui').eval() end)
  end,
  config = function()
    vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DiagnosticError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = 'DiagnosticError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = ' ', texthl = 'DiagnosticOk', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'Comment', linehl = '', numhl = '' })
    require('plugins.dap.dapconfig.dap-config').setup()
  end,
}
