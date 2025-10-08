---@class CodeCompanion.Extension
---@field timer? uv_timer_t
---@field namespace_id? number
local M = {
  spinner_index = 1,
  namespace_id = nil,
  timer = nil,
  spinner_symbols = {
    '⠋',
    '⠙',
    '⠹',
    '⠸',
    '⠼',
    '⠴',
    '⠦',
    '⠧',
    '⠇',
    '⠏',
  },
  filetype = 'codecompanion',
}

function M:update_spinner(buf)
  self.spinner_index = (self.spinner_index % #self.spinner_symbols) + 1

  if not buf or not vim.api.nvim_buf_is_valid(buf) then return end

  vim.api.nvim_buf_clear_namespace(buf, self.namespace_id, 0, -1)

  local last_line = vim.api.nvim_buf_line_count(buf) - 1
  if last_line >= 0 then
    vim.api.nvim_buf_set_extmark(buf, self.namespace_id, last_line, 0, {
      virt_lines = { { { self.spinner_symbols[self.spinner_index] .. ' Processing...', 'Comment' } } },
      virt_lines_above = false,
    })
  end
end

function M:start_spinner(buf)
  self.spinner_index = 0

  if not buf or not vim.api.nvim_buf_is_valid(buf) then return end

  -- Clean up previous timer
  if self.timer then
    self.timer:stop()
    self.timer:close()
  end

  self.timer = vim.uv.new_timer()
  self.timer:start(0, 100, vim.schedule_wrap(function() self:update_spinner(buf) end))
end

function M:stop_spinner(buf)
  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end

  if buf and vim.api.nvim_buf_is_valid(buf) then vim.api.nvim_buf_clear_namespace(buf, self.namespace_id, 0, -1) end
end

function M:init()
  -- Create namespace for virtual text
  self.namespace_id = vim.api.nvim_create_namespace('CodeCompanionSpinner')

  vim.api.nvim_create_augroup('CodeCompanionHooks', { clear = true })
  local group = vim.api.nvim_create_augroup('CodeCompanionHooks', {})

  -- Use chat-specific events to ensure spinner only activates in chat buffers
  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = 'CodeCompanionChat*',
    group = group,
    callback = function(request)
      if request.match == 'CodeCompanionChatSubmitted' then
        self:start_spinner(request.buf)
      elseif request.match == 'CodeCompanionChatDone' or request.match == 'CodeCompanionChatStopped' then
        self:stop_spinner(request.buf)
      end
    end,
  })
end

function M.setup() M:init() end

return M
