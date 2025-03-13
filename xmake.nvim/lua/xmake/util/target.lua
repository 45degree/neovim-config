local xmake_utils = require('xmake.util.xmake-utils')
local M = {}

---@param target_name string
---@return table<string, string>
function M.envs(target_name)
  local res = xmake_utils.run_xmake_script('./xmakeScript/target_envs.lua', target_name)
  assert(type(res) == 'table')
  return res
end

---@param target_name string
---@return string|nil
function M.targetfile(target_name)
  local res = xmake_utils.get_target_attribute(target_name, 'targetfile')
  assert(res == nil or type(res) == 'string')
  return res
end

---@param target_name string
---@return string|nil
function M.rundir(target_name)
  local res = xmake_utils.get_target_attribute(target_name, 'rundir')
  assert(res == nil or type(res) == 'string')
  return res
end

---@param target_name string
---@return string|string[]|nil
function M.deps(target_name)
  local res = xmake_utils.get_target_attribute(target_name, 'get', 'deps')
  assert(res == nil or type(res) == 'string' or type(res) == 'table')
  return res
end

---@param target_name string
---@return string|string[]|nil
function M.extrafiles(target_name)
  local res = xmake_utils.get_target_attribute(target_name, 'extrafiles')
  assert(res == nil or type(res) == 'string' or type(res) == 'table')
  return res
end

return M
