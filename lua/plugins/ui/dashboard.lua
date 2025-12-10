return {
  'folke/snacks.nvim',
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = function() require('snacks.picker').files() end },
          { icon = ' ', key = 'g', desc = 'Find Text', action = function() require('snacks.picker').grep() end },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = function() require('snacks.picker').recent() end },
          { icon = ' ', key = 'c', desc = 'Config', action = function() require('snacks.picker').files({ cwd = vim.fn.stdpath('config') }) end },
          { icon = ' ', key = 's', desc = 'Restore Session', action = function() require('session_manager').load_session(false) end },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'p', desc = 'Mason', action = ':Mason' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
    },
  },
}
