---@class CopilotComponent : AiComponent
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

component.get_status = function()
  if client.is_disabled() then return end
  if not is_current_buffer_attached() then return end

  local data = ai_api.status.data.status
  if data == 'Warning' then return 'error' end
  if data == 'InProgress' then return 'loading' end
  if data == 'Normal' then return 'finished' end

  if vim.b.copilot_suggestion_auto_trigger == nil and lazy_require('copilot.config').get('suggestion').auto_trigger then return 'idle' end
  if vim.b.copilot_suggestion_auto_trigger then return 'idle' end
end

component.is_enabled = function() return not client.is_disabled() and is_current_buffer_attached() end

component.get_name = function() return 'copilot' end

return component
