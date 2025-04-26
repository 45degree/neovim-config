local component = require('lualine.component'):extend()
local utils = require('lualine.utils.utils')
local highlights = require('lualine.highlight')

---Return a spinner from the list of spinners
---@return string
function component:get_spinner()
  local spinner = self.spinners[self.spinner_count]
  self.spinner_count = self.spinner_count + 1
  if self.spinner_count > #self.spinners then self.spinner_count = 1 end
  return spinner
end

---Initialize component
---@override
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
  self.hl.disable = highlights.create_component_highlight_group({ fg = disable_fg }, 'codeium-status-disable', options)
  self.hl.warn = highlights.create_component_highlight_group({ fg = warn_fg }, 'codeium-status-warn', options)
  self.hl.info = highlights.create_component_highlight_group({ fg = info_fg }, 'codeium-status-info', options)
  self.hl.error = highlights.create_component_highlight_group({ fg = error_fg }, 'codeium-status-error', options)
  self.hl.hint = highlights.create_component_highlight_group({ fg = hint_fg }, 'codeium-status-hint', options)
end

function component:update_status()
  if not package.loaded['neocodeium'] then return '' end

  local plugin_status, server_status = require('neocodeium').get_status()

  local plugin_disable_reason = {
    [1] = 'globally disabled',
    [2] = 'locally disabled',
    [3] = 'disabled by filetypes',
    [4] = 'disabled by filter',
    [5] = 'wrong encoding',
    [6] = 'disabled in special buftypes',
  }

  if plugin_status ~= 0 then -- this client is disabled
    return highlights.component_format_highlight(self.hl.error) .. string.format(' codeium: %s', plugin_disable_reason[plugin_status])
  elseif server_status == 2 then -- the server is disabled
    return highlights.component_format_highlight(self.hl.disable) .. ' codeium: server disabled'
  elseif server_status == 1 then
    return highlights.component_format_highlight(self.hl.warn) .. string.format(' codeium: %s connecting ', self:get_spinner())
  elseif server_status == 0 then
    return highlights.component_format_highlight(self.hl.info) .. ' codeium'
  end
  return ''
end

return component
