local component = {}

--- @return string
local function get_codeium_status_string() return vim.fn['codeium#GetStatusString']() end

component.is_enabled = function() return get_codeium_status_string():match('ON') end

component.is_error = function() return get_codeium_status_string():match('OFF') end

component.is_loading = function()
  local status = get_codeium_status_string()
  return string.match(status, '%d/%d') or string.match(status, '0') or string.match(status, '%*')
end

component.is_sleep = function() return get_codeium_status_string():match('OFF') end

return component
