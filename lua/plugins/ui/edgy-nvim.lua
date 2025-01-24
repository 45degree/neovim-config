return {
  'folke/edgy.nvim',
  event = 'VeryLazy',
  opts_extend = { 'bottom', 'left', 'right', 'top' },
  opts = {
    bottom = {
      {
        ft = 'toggleterm',
        size = { height = 10 },
        filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == '' end,
      },
      { ft = 'qf', title = 'QuickFix' },
      {
        ft = 'help',
        size = { height = 20 },
        -- don't open help files in edgy that we're editing
        filter = function(buf) return vim.bo[buf].buftype == 'help' end,
      },
    },
    left = {
      { title = 'Neo-Tree', ft = 'neo-tree', open = 'Neotree', pinned = true, size = { width = 40 } },
      { title = 'Outline', ft = 'Outline', open = function() require('outline').open() end, pinned = true, size = { width = 40, height = 0.2 } },
    },
    animate = { enabled = false },
  },
}
