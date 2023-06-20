-- Config
local config = {
  options = {
    icons_enabled = true,
    disabled_filetypes = { 'alpha', 'edgy' },
    always_divide_middle = true,
    globalstatus = true,
    -- Disable sections and component separators
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
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

-- Now don't forget to initialize lualine
require('lualine').setup(config)
