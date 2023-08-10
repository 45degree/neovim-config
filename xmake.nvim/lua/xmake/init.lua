local project = require('xmake.util.project')
local util = require('xmake.util.util')
local dap = require('dap')
local Config = require('xmake.config')

local xmake = {}
xmake.config = {}

function xmake.setup(values)
  xmake.config = Config:new(values)
end

function xmake:Build(targetName, force)
  local env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' }
  local xmake_executable = xmake.config.xmake_executable
  if force then
    util.run(xmake_executable, env, { 'build', '-r', targetName }, xmake.config)
  else
    util.run(xmake_executable, env, { 'build', targetName }, xmake.config)
  end
end

function xmake:Debug(targetName, args)
  local params = {
    program = project.GetTargetExecPath(targetName, xmake.config),
    args = util.split_args(args),
    cwd = project.GetTargetRunDir(targetName, xmake.config),
    env = project.GetTargetEnvs(targetName, xmake.config),
  }
  dap.run(self.config.dap_configuration(params))
end

return xmake
