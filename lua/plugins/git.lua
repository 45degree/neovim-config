return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('config.plugins.gitsigns')
    end,
  },

  {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- 内置git命令
  {
    'tpope/vim-fugitive',
    -- event = 'VeryLazy',
    cmd = 'Git',
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'nvim-telescope/telescope.nvim', -- optional
      'sindrets/diffview.nvim', -- optional
    },
    cmd = 'Neogit',
    config = function()
      local neogit = require('neogit')
      neogit.setup({
        signs = {
          -- { CLOSED, OPENED }
          hunk = { '', '' },
          item = { '', '' },
          section = { '', '' },
        },
      })
    end,
  },
}
