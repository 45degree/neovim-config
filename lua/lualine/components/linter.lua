local component = require('lualine.component'):extend()
local highlights = require('lualine.highlight')
local utils = require('lualine.utils.utils')

function component:init(options)
  component.super.init(self, options)
  local hint_fg = utils.extract_highlight_colors('DiagnosticHint', 'fg')

  self.hl = {}
  self.hl.running = highlights.create_component_highlight_group({ fg = hint_fg }, 'linting_running', options)
  self.hl.finish = highlights.create_component_highlight_group({}, 'linting_finish', options)
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

  local message = ''
  for idx, linter in ipairs(linters) do
    if running_linters[linter] then
      message = message .. highlights.component_format_highlight(self.hl.running) .. linter .. (idx == #linters and '' or ' ')
    else
      message = message .. highlights.component_format_highlight(self.hl.finish) .. linter .. (idx == #linters and '' or ' ')
    end
  end
  return icon .. message
end

return component
