local icons = require('config.icon')

local function get_active_lsp_name()
  local msg = 'No Active Lsp'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end

  msg = ''
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      msg = msg .. client.name .. ','
    end
  end
  return string.sub(msg, 1, #msg - 1)
end

-- Config
local config = {
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
      {
        'filename',
        path = 1,
        symbols = { modified = '  ', readonly = '', unnamed = '' },
      },
      { get_active_lsp_name, icon = ' LSP:' },
      { 'tabnine' },
      -- stylua: ignore
      {
        function() return "  " .. require("dap").status() end,
        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
      },
      { require('lazy.status').updates, cond = require('lazy.status').has_updates },
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = {
      { 'progress', separator = ' ',                  padding = { left = 1, right = 0 } },
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

-- Now don't forget to initialize lualine
require('lualine').setup(config)
