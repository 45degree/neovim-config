local component = require('lualine.component'):extend()
local highlights = require('lualine.highlight')

function component:init(options)
  component.super.init(self, options)

  local function to_hex_color_string(num)
    local hex = string.format('%06x', num)
    return '#' .. hex
  end
  local hint_fg = to_hex_color_string(vim.api.nvim_get_hl(0, { name = 'DiagnosticHint' }).fg)
  self.hl = highlights.create_component_highlight_group({ fg = hint_fg }, 'linting', options)
end

function component:update_status()
  if not package.loaded['lint'] then
    return ''
  end

  local lint = require('lint')
  local icon = '󱉶 '

  local buf_ft = vim.bo.filetype
  local linters = lint.linters_by_ft[buf_ft]
  if linters == nil then
    return ''
  end

  local running_linters = {}
  for _, linter in ipairs(lint.get_running()) do
    running_linters[linter] = {}
  end

  local finished_linters = {}
  for _, linter in ipairs(linters) do
    if not running_linters[linter] then
      finished_linters[linter] = {}
    end
  end

  local finish_linter_list = {}
  for linter, _ in pairs(finished_linters) do
    table.insert(finish_linter_list, linter)
  end
  local finish_messages = table.concat(finish_linter_list, ',')

  local running_linter_list = {}
  for linter, _ in pairs(running_linters) do
    table.insert(running_linter_list, linter)
  end
  local running_messages = highlights.component_format_highlight(self.hl) .. table.concat(running_linter_list, ',')

  if #running_linter_list == 0 then
    return icon .. finish_messages
  elseif #finish_messages == 0 then
    return icon .. running_messages
  else
    return icon .. finish_messages .. ',' .. running_messages
  end
end

return component
