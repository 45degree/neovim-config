---@class CodeiumComponent : AiComponent
local component = {}

component.get_status = function()
  local completer = require('neocodeium.completer')

  local plugin_status, server_status = require('neocodeium').get_status()

  if plugin_status ~= 0 then return 'error' end
  if server_status == 2 then return 'error' end

  if completer.status == 0 then return 'idle' end
  if completer.status == 1 then return 'loading' end
  if completer.status == 2 then return 'finished' end

  return 'idle'
end

component.is_enabled = function()
  local plugin_status, server_status = require('neocodeium').get_status()
  return plugin_status == 0 and server_status ~= 2
end

component.get_name = function() return 'codeium' end

return component
