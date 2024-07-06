return {
  'stevearc/overseer.nvim',
  cmd = { 'OverseerBuild', 'OverseerRun', 'OverseerToggle' },
  config = function()
    local config = require('config')
    require('overseer').setup({
      form = { border = config.border, win_opts = { winblend = 0 } },
      confirm = { border = config.border, win_opts = { winblend = 0 } },
      task_win = { border = config.border, win_opts = { winblend = 0 } },
    })
  end,
  keys = {
    { '<leader>ctl', '<cmd>OverseerToggle<cr>', desc = 'task list' },
    { '<leader>ctr', '<cmd>OverseerRun<cr>', desc = 'task run' },
    { '<leader>cti', '<cmd>OverseerInfo<cr>', desc = 'task information' },
    { '<leader>ctc', '<cmd>OverseerClearCache<cr>', desc = 'clear task cache' },
  },
}
