local config = require('xmake.config')

local M = {}

function M.setup(args) config.setup(args) end

function M.set_dap_config(dap_config_func) config.set_dap_configuration(dap_config_func) end

function M.build(targetName, force)
  local util = require('xmake.util.util')
  local env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' }
  local xmake_executable = config.opts.xmake_executable
  if force then
    util.run(xmake_executable, env, { 'build', '-r', targetName }, config.opts)
  else
    util.run(xmake_executable, env, { 'build', targetName }, config.opts)
  end
end

function M.debug(target_name, args)
  local util = require('xmake.util.util')
  local project = require('xmake.util.project')
  local dap = require('dap')
  local params = {
    target_name = target_name,
    program = project.get_target_attribute(target_name, 'targetfile')[1],
    args = util.split_args(args),
    cwd = project.get_target_attribute(target_name, 'rundir')[1],
    env = project.get_target_envs(target_name),
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

function M.run(targetName, args)
  local util = require('xmake.util.util')
  local env = { PATH = vim.env.PATH }
  local xmake_executable = config.opts.xmake_executable
  util.run(xmake_executable, env, { 'run', targetName, args }, config.opts)
end

function M.get_target_attribute(target_name, attribute, ...)
  local project = require('xmake.util.project')
  return project.get_target_attribute(target_name, attribute, ...)
end

return M
