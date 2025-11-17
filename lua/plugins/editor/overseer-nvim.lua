return {
  {
    'stevearc/overseer.nvim',
    cmd = { 'OverseerBuild', 'OverseerRun', 'OverseerToggle' },
    opts = function()
      local config = require('config')
      return {
        -- strategy = { 'jobstart', use_terminal = true, preserve_output = false },
        form = { border = config.border, win_opts = { winblend = 0 } },
        task_win = { border = config.border, win_opts = { winblend = 0 } },
        task_list = { direction = 'right' },
      }
    end,
    keys = {
      { '<m-1>', '<cmd>OverseerToggle<cr>', desc = 'task list' },
      { '<m-2>', '<cmd>OverseerRun<cr>', desc = 'task run' },
    },
  },

  {
    'folke/edgy.nvim',
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = 'Overseer',
        ft = 'OverseerList',
        open = function() require('overseer').open() end,
      })
    end,
  },
}
