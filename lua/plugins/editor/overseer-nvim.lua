return {
  'stevearc/overseer.nvim',
  cmd = { 'OverseerBuild', 'OverseerRun', 'OverseerToggle' },
  config = function()
    local config = require('config')
    require('overseer').setup({
      strategy = { 'toggleterm', quit_on_exit = 'success', open_on_start = false },
      form = { border = config.border },
      confirm = { border = config.border },
      task_win = { border = config.border },
    })
  end,
  keys = {
    {'<leader>ctl', '<cmd>OverseerToggle<cr>', desc = 'task list'},
    {'<leader>ctr', '<cmd>OverseerRun<cr>', desc = 'task run'},
    {'<leader>cti', '<cmd>OverseerInfo<cr>', desc = 'task information'},
    {'<leader>ctc', '<cmd>OverseerClearCache<cr>', desc = 'clear task cache'},
  }
}
