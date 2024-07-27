---@class CodeiumComponent : AiComponent
local component = {}

--- @return string
local function get_codeium_status_string() return vim.fn['codeium#GetStatusString']() end

component.get_status = function()
  local status_string = get_codeium_status_string()
  if status_string:match('OFF') then return 'idle' end
  if status_string:match('%*') then return 'loading' end
  if status_string:match('%d/%d') or status_string:match('0') then return 'finished' end

  return 'idle'
end

component.is_enabled = function() return get_codeium_status_string():match('ON') end

component.get_name = function() return 'codeium' end

return component
