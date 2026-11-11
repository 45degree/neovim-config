local component = require('lualine.component'):extend()
local highlights = require('lualine.highlight')
local utils = require('lualine.utils.utils')

function component:init(options)
  component.super.init(self, options)
  self.spinners = require('util.spinners').dots
  self.spinner_count = 1
  self.processing = false
  self.n_requests = 0
  self.n_finished_requests = 0

  local group = vim.api.nvim_create_augroup('LualineMinuetStatus', { clear = true })
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MinuetRequestStartedPre',
    group = group,
    callback = function(event)
      self.n_requests = event.data and event.data.n_requests or 0
      self.n_finished_requests = 0
      self.processing = false
    end,
  })
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MinuetRequestStarted',
    group = group,
    callback = function() self.processing = true end,
  })
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MinuetRequestFinished',
    group = group,
    callback = function()
      self.n_finished_requests = self.n_finished_requests + 1
      if self.n_finished_requests >= self.n_requests then self.processing = false end
    end,
  })

  local info_fg = utils.extract_highlight_colors('DiagnosticInfo', 'fg')
  local hint_fg = utils.extract_highlight_colors('DiagnosticHint', 'fg')
  self.hl = {
    info = highlights.create_component_highlight_group({ fg = info_fg }, 'minuet-status-info', options),
    hint = highlights.create_component_highlight_group({ fg = hint_fg }, 'minuet-status-hint', options),
  }
end

function component:get_spinner()
  local spinner = self.spinners[self.spinner_count]
  self.spinner_count = self.spinner_count % #self.spinners + 1
  return spinner
end

function component:update_status()
  local minuet = package.loaded['minuet']
  if not minuet or not minuet.config then return '' end

  if self.processing then
    return highlights.component_format_highlight(self.hl.hint) .. string.format('󰚩 minuet %s', self:get_spinner())
  end

  return highlights.component_format_highlight(self.hl.info) .. '󰚩 minuet'
end

return component
