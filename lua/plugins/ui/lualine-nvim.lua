local icons = require('icons')

-- Config
local opts = {
  options = {
    icons_enabled = true,
    disabled_filetypes = { statusline = { 'alpha', 'dashboard' }, 'edgy' },
    always_divide_middle = true,
    globalstatus = true,
    -- Disable sections and component separators
    component_separators = '|',
    section_separators = { left = '', right = '' },
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      {
        'diff',
        symbols = { added = icons.gitsigns.added, modified = icons.gitsigns.modified, removed = icons.gitsigns.deleted },
      },
      { 'diagnostics', symbols = icons.diagnostic },
    },
    lualine_c = { 'lsp-dap', 'linter', 'formatter', 'ai-status' },
    lualine_x = { 'encoding', 'fileformat' },
    lualine_y = {
      { 'icon-filename', separator = ' ', padding = { left = 1, right = 0 } },
      { 'progress', padding = { left = 0, right = 1 } },
    },
    lualine_z = {
      function()
        return ' ' .. os.date('%R')
      end,
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
}

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
    require('lualine').setup(opts)
  end,
}
