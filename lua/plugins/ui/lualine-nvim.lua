return {
  'nvim-lualine/lualine.nvim',
  event = 'LazyFile',
  opts = {
    options = {
      icons_enabled = true,
      disabled_filetypes = { statusline = { 'alpha', 'dashboard', 'snacks_dashboard' }, 'edgy' },
      always_divide_middle = true,
      globalstatus = true,
      -- Disable sections and component separators
      component_separators = '',
      section_separators = { left = '', right = '' },
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = {},
      lualine_b = {
        'icon-mode',
        'color-branch',
        {
          'diff',
          symbols = {
            added = require('icons').gitsigns.added,
            modified = require('icons').gitsigns.modified,
            removed = require('icons').gitsigns.deleted,
          },
        },
        { 'diagnostics', symbols = require('icons').diagnostic },
      },
      lualine_c = { 'lsp-dap', 'linter', 'formatter', 'ai-status' },
      lualine_x = { 'location', 'task', 'encoding', 'fileformat' },
      lualine_y = { 'icon-filename', 'ui-progress' },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = { 'icon-filename', 'ui-progress' },
      lualine_z = {},
    },
  },
}
