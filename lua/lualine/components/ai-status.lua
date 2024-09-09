local component = require('lualine.component'):extend()
local copilot = require('util.copilot')
local codeium = require('util.codeium')
local fittencode = require('util.fittencode')
local highlights = require('lualine.highlight')
local utils = require('lualine.utils.utils')

---@class AiComponent
---@field get_status fun(): 'error'|'loading'|'finished'|'idle'|nil
---@field get_name fun(): string
---@field is_enabled fun(): boolean

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

  local warn_fg = utils.extract_highlight_colors('DiagnosticWarn', 'fg')
  local info_fg = utils.extract_highlight_colors('DiagnosticInfo', 'fg')
  local error_fg = utils.extract_highlight_colors('DiagnosticError', 'fg')
  local hint_fg = utils.extract_highlight_colors('DiagnosticHint', 'fg')

  self.hl = { warn = {}, info = {}, error = {}, hint = {} }
  self.hl.warn = highlights.create_component_highlight_group({ fg = warn_fg }, 'ai-status-warn', options)
  self.hl.info = highlights.create_component_highlight_group({ fg = info_fg }, 'ai-status-info', options)
  self.hl.error = highlights.create_component_highlight_group({ fg = error_fg }, 'ai-status-error', options)
  self.hl.hint = highlights.create_component_highlight_group({ fg = hint_fg }, 'ai-status-hint', options)
  self.copilot_lsp_attached = false

  if require('config').ai == 'copilot' then
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('copilot-status', {}),
      desc = 'Update copilot attached status',
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'copilot' then
          self.copilot_lsp_attached = true
          return true
        end
        return false
      end,
    })
  end
end

---@param ai AiComponent
function component:update_ai_status(ai)
  local icon = ' '
  local name = ai.get_name()

  if not ai.is_enabled() then return highlights.component_format_highlight(self.hl.error) .. string.format('%s %s', icon, name) end

  local status = ai.get_status()
  if status == 'loading' then
    return highlights.component_format_highlight(self.hl.warn) .. string.format('%s %s', self:get_spinner(), name)
  elseif status == 'error' then
    return highlights.component_format_highlight(self.hl.error) .. string.format('%s %s', icon, name)
  elseif status == 'finished' then
    return highlights.component_format_highlight(self.hl.info) .. string.format('%s %s', icon, name)
  elseif status == 'idle' then
    return highlights.component_format_highlight(self.hl.hint) .. string.format('%s %s', icon, name)
  end
  return ''
end

---@override
function component:update_status()
  -- All copilot API calls are blocking before copilot is attached,
  -- To avoid blocking the startup time, we check if copilot is attached
  local copilot_loaded = package.loaded['copilot'] ~= nil
  if copilot_loaded and self.copilot_lsp_attached then return self:update_ai_status(copilot) end

  local codeium_loaded = package.loaded['neocodeium'] ~= nil
  if codeium_loaded then return self:update_ai_status(codeium) end

  local fittencode_loaded = package.loaded['fittencode'] ~= nil
  if fittencode_loaded then return self:update_ai_status(fittencode) end

  return ''
end

return component
