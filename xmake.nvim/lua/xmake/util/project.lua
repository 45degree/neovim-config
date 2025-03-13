local xmake_utils = require('xmake.util.xmake-utils')
local path = require('plenary.path')

local M = {}

---@return string[]
function M.targets()
  local res = xmake_utils.run_xmake_script('./xmakeScript/project_target.lua')
  assert(type(res) == 'table')
  return res
end

---@return string[]
function M.binary_targets()
  local res = xmake_utils.run_xmake_script('./xmakeScript/binary_target.lua')
  assert(type(res) == 'table')
  return res
end

---@return string|nil
function M.projectdir() return tostring(path:new(xmake_utils.get_project_attribute('rootfile')):parent()) end

---@return string|nil
function M.rootfile()
  local res = xmake_utils.get_project_attribute('rootfile')
  assert(res == nil or type(res) == 'string')
  return res
end

return M
