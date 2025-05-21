local config = require('xmake.config')
local path = require('plenary.path')
local __dirname = debug.getinfo(1, 'S').source:sub(2, -1):match('^.*/')

local M = {}

---@alias xmake-nvim.json number|string|boolean|table<string, xmake-nvim.json>|xmake-nvim.json[]

---@return xmake-nvim.json
function M.run_xmake_script(script_path, ...)
  local opts = { env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' } }
  local cmd = { config.opts.xmake_executable, 'lua', tostring(path:new(__dirname, script_path)), ... }
  local output = vim.system(cmd, opts):wait()
  if output.code ~= 0 or not output.stdout or #output.stdout == 0 then
    local error_msg = #output.stdout == 0 and 'Command executed successfully but returned no output'
      or 'Command execution failed with code ' .. output.code
    vim.notify(error_msg, vim.log.levels.ERROR)
    return {}
  end
  local res = vim.json.decode(output.stdout)
  return res ~= vim.NIL and res or {}
end

function M.get_target_attribute(target_name, attribute, ...) return M.run_xmake_script('./xmakeScript/target_get.lua', target_name, attribute, ...) end

function M.get_project_attribute(attribute, ...) return M.run_xmake_script('./xmakeScript/project_get.lua', attribute, ...) end

return M
