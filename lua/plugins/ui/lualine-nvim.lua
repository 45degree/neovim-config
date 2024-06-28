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
    lualine_c = {
      { 'filename', path = 1, symbols = { modified = '  ', readonly = '', unnamed = '' } },
      'lsp-dap',
      'linter',
      'formatter',
      'ai-status',
      -- stylua: ignore
      { require('lazy.status').updates, cond = require('lazy.status').has_updates },
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = {
      { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
      { 'location', padding = { left = 0, right = 1 } },
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
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  config = function()
    require('lualine').setup(opts)
  end,
}
