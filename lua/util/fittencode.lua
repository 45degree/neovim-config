---@class FittencodeComponent : AiComponent
local component = {}

component.get_status = function()
  local status = require('fittencode').get_current_status()

  if status == require('fittencode.status').C.ERROR then
    return 'error'
  elseif status == require('fittencode.status').C.GENERATING then
    return 'loading'
  elseif status == require('fittencode.status').C.SUGGESTIONS_READY then
    return 'finished'
  elseif status == require('fittencode.status').C.IDLE then
    return 'idle'
  end
  return 'idle'
end

component.is_enabled = function()
  local status = require('fittencode').get_current_status()
  return status ~= require('fittencode.status').C.DISABLED
end

component.get_name = function() return 'fittencode' end

return component
