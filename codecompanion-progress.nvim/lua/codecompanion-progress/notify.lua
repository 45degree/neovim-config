---@class CodeCompanion.Extension.Progress.NotifyConfig
---@field symbols string[]
---@field enabled boolean
---@field only_inline boolean

---@class CodeCompanion.Extension.Progress.Notify
---@field timer? uv_timer_t
local M = {
  enabled = true,
  only_inline = false,
  spinner_index = 0,
  timer = nil,
  symbols = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
  started = false,
}

function M:update_notify(message)
  self.spinner_index = (self.spinner_index % #self.symbols) + 1
  vim.notify(message, vim.log.levels.INFO, {
    id = 'codecompanion_request',
    title = 'codecompanion processing',
    opts = function(notif)
      notif.icon = self.symbols[self.spinner_index]
      notif.timeout = 300
    end,
  })
end

function M:start_notify(data)
  local adapter = data.adapter
  local adapter_name = adapter.formatted_name or adapter.name
  local adapter_model = adapter.model
  local message = string.format('response from %s:%s', adapter_name, adapter_model)

  self.spinner_index = 0

  -- Clean up previous timer
  if self.timer then
    self.timer:stop()
    self.timer:close()
  end

  self.timer = vim.uv.new_timer()
  self.timer:start(0, 100, vim.schedule_wrap(function() self:update_notify(message) end))
end

function M:stop_nofity()
  if not self.timer then return end

  self.timer:stop()
  self.timer:close()
  self.timer = nil
end

function M:init()
  vim.api.nvim_create_augroup('CodeCompanionProgressNotifyHooks', { clear = true })
  local group = vim.api.nvim_create_augroup('CodeCompanionProgressNotifyHooks', {})

  if self.only_inline then
    -- vim.api.nvim_create_autocmd({ 'User' }, {
    --   pattern = { 'CodeCompanionRequest*', 'CodeCompanionInline*' },
    --   group = group,
    --   callback = function(request)
    --     if request.match == 'CodeCompanionInlineStarted' then
    --       self.started = true
    --     end
    --
    --     local start_event = { 'CodeCompanionRequestStarted', 'CodeCompanionRequestStreaming' }
    --     local stop_event = { 'CodeCompanionRequestFinished', 'CodeCompanionInlineFinished' }
    --     if self.started and vim.list_contains(start_event, request.match) then
    --       self:start_notify(request.data)
    --       self.started = false
    --     elseif vim.list_contains(stop_event, request.match) then
    --       self:stop_nofity()
    --     end
    --   end,
    -- })
  else
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = { 'CodeCompanionRequest*' },
      group = group,
      callback = function(request)
        if request.match == 'CodeCompanionRequestStarted' or request.match == 'CodeCompanionRequestStreaming' then
          self:start_notify(request.data)
        elseif request.match == 'CodeCompanionRequestFinished' then
          self:stop_nofity()
        end
      end,
    })
  end
end

---@param opts? CodeCompanion.Extension.Progress.NotifyConfig
function M.setup(opts)
  M = vim.tbl_deep_extend('force', M, opts or {})
  if not M.enabled then return end

  M:init()
end

return M
