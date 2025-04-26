local component = require('lualine.component'):extend()
local utils = require('lualine.utils.utils')
local highlights = require('lualine.highlight')

function component:get_spinner()
  local spinner = self.spinners[self.spinner_count]
  self.spinner_count = self.spinner_count + 1
  if self.spinner_count > #self.spinners then self.spinner_count = 1 end
  return spinner
end

function component:init(options)
  component.super.init(self, options)

  self.spinners = require('util.spinners').dots
  self.spinner_count = 1

  local disable_fg = utils.extract_highlight_colors('Conceal', 'fg')
  local warn_fg = utils.extract_highlight_colors('DiagnosticWarn', 'fg')
  local info_fg = utils.extract_highlight_colors('DiagnosticInfo', 'fg')
  local error_fg = utils.extract_highlight_colors('DiagnosticError', 'fg')
  local hint_fg = utils.extract_highlight_colors('DiagnosticHint', 'fg')

  self.hl = { warn = {}, info = {}, error = {}, hint = {}, disable = {} }
  self.hl.disable = highlights.create_component_highlight_group({ fg = disable_fg }, 'copilot-status-disable', options)
  self.hl.warn = highlights.create_component_highlight_group({ fg = warn_fg }, 'copilot-status-warn', options)
  self.hl.info = highlights.create_component_highlight_group({ fg = info_fg }, 'copilot-status-info', options)
  self.hl.error = highlights.create_component_highlight_group({ fg = error_fg }, 'copilot-status-error', options)
  self.hl.hint = highlights.create_component_highlight_group({ fg = hint_fg }, 'copilot-status-hint', options)
end

function component:update_status()
  if not package.loaded['copilot'] then return '' end

  local client = require('copilot.client')

  ---@type copilot_status_notification_data 
  local status_data = require('copilot.status').data
  local status = status_data.status

  if client.is_disabled() then
    return highlights.component_format_highlight(self.hl.disable) .. ' copilot'
  end

  if status == 'Normal' then
    return highlights.component_format_highlight(self.hl.info) .. ' copilot'
  elseif status == 'InProgress' then
    return highlights.component_format_highlight(self.hl.hint) .. string.format(' copilot: %s in progress', self:get_spinner())
  elseif status == 'Warning' then
    return highlights.component_format_highlight(self.hl.warn) .. string.format(' copilot: %s', status_data.message)
  end

  return ''
end

return component
