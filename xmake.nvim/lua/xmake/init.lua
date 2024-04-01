local project = require('xmake.util.project')
local util = require('xmake.util.util')
local dap = require('dap')
local Config = require('xmake.config')

local xmake = {}
xmake.config = {}

function xmake.setup(values)
  xmake.config = Config:new(values)
end

function xmake:build(targetName, force)
  local env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' }
  local xmake_executable = xmake.config.xmake_executable
  if force then
    util.run(xmake_executable, env, { 'build', '-r', targetName }, xmake.config)
  else
    util.run(xmake_executable, env, { 'build', targetName }, xmake.config)
  end
end

function xmake:debug(targetName, args)
  local params = {
    program = project.GetTargetExecPath(targetName, xmake.config),
    args = util.split_args(args),
    cwd = project.GetTargetRunDir(targetName, xmake.config),
    env = project.GetTargetEnvs(targetName, xmake.config),
  }
  local dap_configurations = self.config.dap_configuration(params);
  if #dap_configurations > 1 then
    local names = {};
    for _, config in ipairs(dap_configurations) do
      table.insert(names, config.name);
    end
    vim.ui.select(names, {}, function(item, idx)
      if item == nil or idx == nil then
        return;
      end
      dap.run(dap_configurations[idx]);
    end)
  elseif #dap_configurations == 1 then
    dap.run(dap_configurations[1])
  else
    dap.run(dap_configurations)
  end
end

function xmake:run(targetName, args)
  local env = { PATH = vim.env.PATH }
  local xmake_executable = xmake.config.xmake_executable
  util.run(xmake_executable, env, { 'run', targetName, args }, xmake.config)
end

return xmake
