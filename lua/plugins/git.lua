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
    config = function()
      require('diffview').setup({
        view = {
          default = {
            -- Config for changed files, and staged files in diff views.
            layout = 'diff2_horizontal',
            winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
          },
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = 'diff3_mixed',
            disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
            winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
          },
          file_history = {
            -- Config for changed files in file history views.
            layout = 'diff2_horizontal',
            winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
          },
        },
      })
    end,
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

  {
    'akinsho/git-conflict.nvim',
    event = 'VeryLazy',
    version = '*',
    config = function()
      require('git-conflict').setup({
        default_mappings = true, -- disable buffer local mapping created by this plugin
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      })
    end,
  },
}
