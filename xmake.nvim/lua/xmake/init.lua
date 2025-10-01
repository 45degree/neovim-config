local config = require('xmake.config')
local path = require('plenary.path')

---@class xmake-nvim
local M = {}

--- setup the plugin
--- @param args xmake-nvim.config
function M.setup(args) config:setup(args) end

--- set the dap configuration
--- @param dap_configuration fun(params: xmake-nvim.debug-params): dap.Configuration[]
function M.set_dap_configuration(dap_configuration) config.dap_configuration = dap_configuration end

--- build the target
---@param targetName string target name
---@param opts string[] xmake build options
function M.build(targetName, opts)
  local util = require('xmake.util.util')
  local env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' }
  local xmake_executable = config.xmake_executable
  local cmd_line = { 'build' }
  cmd_line = vim.list_extend(cmd_line, opts)
  cmd_line = vim.list_extend(cmd_line, { targetName })
  util.run(xmake_executable, env, cmd_line, config)
end

--- debug the target
--- @param target_name string target name
--- @param args string[] arguments when run the target
function M.debug(target_name, args)
  local project = require('xmake.util.project')
  local target = require('xmake.util.target')
  local dap = require('dap')
  local rootdir = path:new(project.projectdir())
  local target_file = path:new(target.targetfile(target_name))
  local target_rundir = path:new(target.rundir(target_name))

  ---@type xmake-nvim.debug-params
  local params = {
    target_name = target_name,
    program = rootdir:joinpath(target_file):absolute(),
    args = args,
    cwd = target_rundir:absolute(),
    env = target.envs(target_name),
  }
  local dap_configurations = config.dap_configuration(params)
  if #dap_configurations > 1 then
    local names = {}
    for _, dap_config in ipairs(dap_configurations) do
      table.insert(names, dap_config.name)
    end
    vim.ui.select(names, {}, function(item, idx)
      if item == nil or idx == nil then return end
      dap.run(dap_configurations[idx])
    end)
  elseif #dap_configurations == 1 then
    dap.run(dap_configurations[1])
  else
    dap.run(dap_configurations)
  end
end

--- debug the target
--- @param target_name string target name
--- @param args string[] arguments when run the target
function M.run(target_name, args)
  local util = require('xmake.util.util')
  local env = { PATH = vim.env.PATH }
  util.run(config.xmake_executable, env, { 'run', target_name, util.join_args(args) }, config)
end

return M
