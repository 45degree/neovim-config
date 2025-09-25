return {
  'nvim-telescope/telescope.nvim',
  enabled = false,
  cmd = 'Telescope',
  dependencies = { 'nvim-telescope/telescope-live-grep-args.nvim' },
  opts = {
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
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ['<C-k>'] = function() require('telescope-live-grep-args.actions').quote_prompt() end,
            ['<C-i>'] = function() require('telescope-live-grep-args.actions').quote_prompt({ postfix = ' --iglob ' }) end,
          },
        },
      },
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension('live_grep_args')
  end,
}
