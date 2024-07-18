local component = {}

-- From TJDevries
-- https://github.com/tjdevries/lazy-require.nvim
local function lazy_require(require_path)
  return setmetatable({}, {
    __index = function(_, key) return require(require_path)[key] end,

    __newindex = function(_, key, value) require(require_path)[key] = value end,
  })
end

local client = lazy_require('copilot.client')
local ai_api = lazy_require('copilot.api')

local is_current_buffer_attached = function() return client.buf_is_attached(vim.api.nvim_get_current_buf()) end

---Check if copilot is enabled
---@return boolean
component.is_enabled = function()
  if client.is_disabled() then return false end

  if not is_current_buffer_attached() then return false end

  return true
end

---Check if copilot is online
---@return boolean
component.is_error = function()
  if client.is_disabled() then return false end

  if not is_current_buffer_attached() then return false end

  local data = ai_api.status.data.status
  if data == 'Warning' then return true end

  return false
end

---Show copilot running status
---@return boolean
component.is_loading = function()
  if client.is_disabled() then return false end

  if not is_current_buffer_attached() then return false end

  local data = ai_api.status.data.status
  if data == 'InProgress' then return true end

  return false
end

---Check auto trigger suggestions
---@return boolean
component.is_sleep = function()
  if client.is_disabled() then return false end

  if not is_current_buffer_attached() then return false end

  if vim.b.copilot_suggestion_auto_trigger == nil then return lazy_require('copilot.config').get('suggestion').auto_trigger end
  return vim.b.copilot_suggestion_auto_trigger
end

return component
