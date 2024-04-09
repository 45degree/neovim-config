return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'williamboman/mason.nvim',
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/nvim-dap-ui',
    'nvim-telescope/telescope-dap.nvim',
  },
  lazy = true,
  init = function()
    -- Shorten function name
    local keymap = vim.api.nvim_set_keymap
    -- set key map
    keymap('n', '<F9>', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", {})
    keymap('n', '<space><F9>', "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", {})
    keymap('n', '<F4>', "<cmd>lua require'dap'.terminate()<cr>", {})
    keymap('n', '<F5>', "<cmd>lua require'dap'.continue()<cr>", {})
    keymap('n', '<F6>', "<cmd>lua require'dap'.pause()<cr>", {})
    keymap('n', '<F10>', "<cmd>lua require'dap'.step_over()<cr>", {})
    keymap('n', '<F11>', "<cmd>lua require'dap'.step_into()<cr>", {})
    keymap('n', '<F12>', "<cmd>lua require'dap'.step_out()<cr>", {})
    keymap('n', 'DK', "<cmd>lua require'dapui'.eval()<cr>", {})
    keymap('n', '<space><F8>', "<cmd>lua require'dap'.run_to_cursor() <cr>", {})
  end,
  config = function()
    vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = ' ', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '⭐️', texthl = '', linehl = '', numhl = '' })
    require('plugins.dap.dapconfig.dap-config').setup()
    require('telescope').load_extension('dap')
  end,
}
