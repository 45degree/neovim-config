local component = require('lualine.component'):extend()

function component:init(options)
  component.super.init(self, options)
end

function component:update_status()
  if not package.loaded['conform'] then
    return
  end

  -- Check if 'conform' is available
  local conform = require('conform')
  local lsp_format = require('conform.lsp_format')

  -- Get formatters for the current buffer
  local formatters = conform.list_formatters_for_buffer()
  if formatters and #formatters > 0 then
    local formatterNames = {}

    for _, formatter in ipairs(formatters) do
      table.insert(formatterNames, formatter)
    end

    return '󰉢 ' .. table.concat(formatterNames, ' ')
  end

  -- Check if there's an LSP formatter
  local bufnr = vim.api.nvim_get_current_buf()
  local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

  if not vim.tbl_isempty(lsp_clients) then
    return '󰉢 LSP Formatter'
  end

  return ''
end

return component
