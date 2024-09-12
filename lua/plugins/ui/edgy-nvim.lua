return {
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    opts = function()
      return {
        bottom = {
          {
            ft = 'toggleterm',
            size = { height = 10 },
            filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == '' end,
          },
          'Trouble',
          { ft = 'qf', title = 'QuickFix' },
          {
            ft = 'help',
            size = { height = 20 },
            -- don't open help files in edgy that we're editing
            filter = function(buf) return vim.bo[buf].buftype == 'help' end,
          },
          { title = 'Spectre', ft = 'spectre_panel', size = { height = 0.4 } },
          { title = 'Neotest Output', ft = 'neotest-output-panel', size = { height = 15 } },
        },
        left = {
          { ft = 'neo-tree', size = { width = 40 } },
        },
        right = {
          {
            title = 'Overseer',
            ft = 'OverseerList',
            open = function() require('overseer').open() end,
            pinned = true,
          },
        },
        animate = { enabled = false },
      }
    end,
  },

  -- use edgy's selection window
  {
    'nvim-telescope/telescope.nvim',
    optional = true,
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend('force', opts.defaults, {
        get_selection_window = function()
          require('edgy').goto_main()
          return 0
        end,
      })
    end,
  },

  -- prevent neo-tree from opening files in edgy windows
  {
    'nvim-neo-tree/neo-tree.nvim',
    optional = true,
    opts = function(_, opts)
      opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types or { 'terminal', 'Trouble', 'qf', 'Outline', 'trouble' }
      table.insert(opts.open_files_do_not_replace_types, 'edgy')
    end,
  },
}
