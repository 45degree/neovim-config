local component = require('lualine.component'):extend()
local utils = require('lualine.utils.utils')
local highlights = require('lualine.highlight')

---Initialize component
---@override
function component:init(options)
  component.super.init(self, options)

  local disable_fg = utils.extract_highlight_colors('Conceal', 'fg')
  local warn_fg = utils.extract_highlight_colors('DiagnosticWarn', 'fg')
  local info_fg = utils.extract_highlight_colors('DiagnosticInfo', 'fg')
  local error_fg = utils.extract_highlight_colors('DiagnosticError', 'fg')
  local hint_fg = utils.extract_highlight_colors('DiagnosticHint', 'fg')

  self.hl = { warn = {}, info = {}, error = {}, hint = {}, disable = {} }
  self.hl.disable = highlights.create_component_highlight_group({ fg = disable_fg }, 'supermaven-status-disable', options)
  self.hl.warn = highlights.create_component_highlight_group({ fg = warn_fg }, 'supermaven-status-warn', options)
  self.hl.info = highlights.create_component_highlight_group({ fg = info_fg }, 'supermaven-status-info', options)
  self.hl.error = highlights.create_component_highlight_group({ fg = error_fg }, 'supermaven-status-error', options)
  self.hl.hint = highlights.create_component_highlight_group({ fg = hint_fg }, 'supermaven-status-hint', options)
end

function component:update_status()
  if not package.loaded['supermaven-nvim'] then return '' end

  local api = require('supermaven-nvim.api')
  if api.is_running() then return highlights.component_format_highlight(self.hl.info) .. ' supermaven' end
  return highlights.component_format_highlight(self.hl.disable) .. ' supermaven'
end

return component
