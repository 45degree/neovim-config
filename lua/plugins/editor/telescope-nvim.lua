return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'ahmedkhalf/project.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
  },
  opts = function()
    local lga_actions = require('telescope-live-grep-args.actions')
    return {
      defaults = {
        prompt_prefix = '   ',
        selection_caret = ' ',
        entry_prefix = '  ',
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        preview = { treesitter = false },
      },
      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
            },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension('projects')
    require('telescope').load_extension('fzy_native')
    require('telescope').load_extension('live_grep_args')
  end,
}
