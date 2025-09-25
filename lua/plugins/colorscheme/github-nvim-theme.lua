return {
  'projekt0n/github-nvim-theme',
  lazy = true,
  opts = {
    options = {
      -- Compiled file's destination location
      compile_path = vim.fn.stdpath('cache') .. '/github-theme',
      compile_file_suffix = '_compiled', -- Compiled file suffix
      hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
      hide_nc_statusline = true, -- Override the underline style for non-active statuslines
      transparent = false, -- Disable setting bg (make neovim's background transparent)
      terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
      dim_inactive = true, -- Non focused panes set to alternative background
      module_default = true, -- Default enable value for modules
      styles = { -- Style to be applied to different syntax groups
        comments = 'italic', -- Value is any valid attr-list value `:help attr-list`
        functions = 'bold',
        keywords = 'bold,italic',
        variables = 'NONE',
        conditionals = 'italic',
        constants = 'NONE',
        numbers = 'NONE',
        operators = 'NONE',
        strings = 'NONE',
        types = 'NONE',
      },
    },
    groups = {
      all = {
        NeoTreeTabActive = { fg = 'fg1' },
        NeoTreeTabInactive = { fg = 'fg3', bg = 'bg0' },
        NeoTreeTabSeparatorInactive = { fg = 'bg0', bg = 'bg0' },
      },
    },
  },
  config = function(_, opts) require('github-theme').setup(opts) end,
}
