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
  self.hl.disable = highlights.create_component_highlight_group({ fg = disable_fg }, 'fittencode-status-disable', options)
  self.hl.warn = highlights.create_component_highlight_group({ fg = warn_fg }, 'fittencode-status-warn', options)
  self.hl.info = highlights.create_component_highlight_group({ fg = info_fg }, 'fittencode-status-info', options)
  self.hl.error = highlights.create_component_highlight_group({ fg = error_fg }, 'fittencode-status-error', options)
  self.hl.hint = highlights.create_component_highlight_group({ fg = hint_fg }, 'fittencode-status-hint', options)
end

function component:update_status()
  if not package.loaded['fittencode'] then return '' end

  local current_status = require('fittencode').get_current_status()
  local status = require('fittencode.status').C
  if current_status == status.DISABLED then
    return highlights.component_format_highlight(self.hl.disable) .. ' fittencode'
  elseif current_status == status.GENERATING then
    return highlights.component_format_highlight(self.hl.warn) .. string.format(' fittencode: %s generating', self:get_spinner())
  elseif current_status == status.ERROR then
    return highlights.component_format_highlight(self.hl.error) .. ' fittencode'
  elseif current_status == status.IDLE then
    return highlights.component_format_highlight(self.hl.info) .. ' fittencode'
  elseif current_status == status.NO_MORE_SUGGESTIONS or current_status == status.SUGGESTIONS_READY then
    return highlights.component_format_highlight(self.hl.hint) .. ' fittencode'
  end
end

return component
