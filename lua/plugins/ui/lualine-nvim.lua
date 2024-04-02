local icons = require('icons')

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

local function get_linter_info()
  local ok, lint = pcall(require, 'lint')
  if not ok then
    return 'Nvim-lint not installed'
  end

  local prefix = '󱉶 linter:';

  local buf_ft = vim.bo.filetype
  local linters = lint.linters_by_ft[buf_ft];
  if linters == nil then
    return prefix .. "no linters"
  end

  local current_linters = lint.get_running()
  if #current_linters == 0 then
    return '󱉶 linter:' .. table.concat(linters, ',')
  end
  return '󱉶 running linter:' .. table.concat(current_linters, ',')
end

local function get_formatter_info()
  -- Check if 'conform' is available
  local status, conform = pcall(require, 'conform')
  if not status then
    return 'Conform not installed'
  end

  local lsp_format = require('conform.lsp_format')

  -- Get formatters for the current buffer
  local formatters = conform.list_formatters_for_buffer()
  if formatters and #formatters > 0 then
    local formatterNames = {}

    for _, formatter in ipairs(formatters) do
      table.insert(formatterNames, formatter)
    end

    return '󰷈 formatter:' .. table.concat(formatterNames, ' ')
  end

  -- Check if there's an LSP formatter
  local bufnr = vim.api.nvim_get_current_buf()
  local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

  if not vim.tbl_isempty(lsp_clients) then
    return '󰷈 LSP Formatter'
  end

  return ''
end

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
      {
        'filename',
        path = 1,
        symbols = { modified = '  ', readonly = '', unnamed = '' },
      },
      { get_active_lsp_name, icon = ' LSP:' },
      { get_linter_info },
      { get_formatter_info },
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
