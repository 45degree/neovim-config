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
  if force then
    util.run('xmake', env, { 'build', '-r', targetName }, xmake.config)
  else
    util.run('xmake', env, { 'build', targetName }, xmake.config)
  end
end

function xmake:Debug(targetName, args)
  args = util.split_args(args)
  local dap_config = {
    name = targetName,
    program = project.GetTargetExecPath(targetName, xmake.config),
    args = args,
    cwd = project.GetTargetRunDir(targetName, xmake.config),
    env = project.GetTargetEnvs(targetName, xmake.config),
    externalConsole = false,
  }

  dap.run(vim.tbl_extend('force', dap_config, xmake.config.dap_configuration))
end

return xmake
