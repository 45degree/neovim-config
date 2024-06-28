local component = require('lualine.component'):extend()
local copilot = require('util.copilot')
local codeium = require('util.codeium')
local highlights = require('lualine.highlight')

---Return a spinner from the list of spinners
---@return string
function component:get_spinner()
  local spinner = self.spinners[self.spinner_count]
  self.spinner_count = self.spinner_count + 1
  if self.spinner_count > #self.spinners then
    self.spinner_count = 1
  end
  return spinner
end

---Initialize component
---@override
function component:init(options)
  component.super.init(self, options)

  self.spinners = require('util.spinners').dots
  self.spinner_count = 1

  local function to_hex_color_string(num)
    local hex = string.format('%06x', num)
    return '#' .. hex
  end

  local warn_fg = to_hex_color_string(vim.api.nvim_get_hl(0, { name = 'DiagnosticWarn' }).fg)
  local info_fg = to_hex_color_string(vim.api.nvim_get_hl(0, { name = 'DiagnosticInfo' }).fg)
  local error_fg = to_hex_color_string(vim.api.nvim_get_hl(0, { name = 'DiagnosticError' }).fg)
  local hint_fg = to_hex_color_string(vim.api.nvim_get_hl(0, { name = 'DiagnosticHint' }).fg)

  self.hl = { warn = {}, info = {}, error = {}, hint = {} }
  self.hl.warn = highlights.create_component_highlight_group({ fg = warn_fg }, 'ai-status-warn', options)
  self.hl.info = highlights.create_component_highlight_group({ fg = info_fg }, 'ai-status-info', options)
  self.hl.error = highlights.create_component_highlight_group({ fg = error_fg }, 'ai-status-error', options)
  self.hl.hint = highlights.create_component_highlight_group({ fg = hint_fg }, 'ai-status-hint', options)
end

function component:update_ai_status(ai, name)
  local icon = ' '

  if ai.is_loading() then
    return highlights.component_format_highlight(self.hl.hint) .. string.format('%s %s', self:get_spinner(), name)
  elseif ai.is_error() then
    return highlights.component_format_highlight(self.hl.error) .. string.format('%s %s', icon, name)
  elseif ai.is_enabled() then
    return highlights.component_format_highlight(self.hl.info) .. string.format('%s %s', icon, name)
  elseif ai.is_sleep() then
    return highlights.component_format_highlight(self.hl.warn) .. string.format('%s %s', icon, name)
  end
  return ''
end

---@override
function component:update_status()
  -- All copilot API calls are blocking before copilot is attached,
  -- To avoid blocking the startup time, we check if copilot is attached
  local copilot_loaded = package.loaded['copilot'] ~= nil
  if copilot_loaded then
    return self:update_ai_status(copilot, 'copilot')
  end

  local codeium_loaded = vim.g.codeium_os ~= nil
  if codeium_loaded then
    return self:update_ai_status(codeium, 'codeium')
  end

  return ''
end

return component
