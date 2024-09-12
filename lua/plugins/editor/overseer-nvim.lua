return {
  'stevearc/overseer.nvim',
  cmd = { 'OverseerBuild', 'OverseerRun', 'OverseerToggle' },
  opts = function()
    local config = require('config')
    return {
      dap = false,
      strategy = { 'toggleterm', direction = 'float' },
      form = { border = config.border, win_opts = { winblend = 0 } },
      confirm = { border = config.border, win_opts = { winblend = 0 } },
      task_win = { border = config.border, win_opts = { winblend = 0 } },
      task_editor = { bindings = { i = { ['<m-2>'] = 'Cancel' }, n = { ['<m-2>'] = 'Cancel' } } },
      templates = { 'builtin', 'project' },
      task_list = { direction = 'right' },
    }
  end,
  keys = {
    { '<m-1>', '<cmd>OverseerToggle<cr>', desc = 'task list' },
    { '<m-2>', '<cmd>OverseerRun<cr>', desc = 'task run' },
  },
}
