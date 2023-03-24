local project = require('xmake.util.project')
local util = require('xmake.util.util')
local dap = require('dap')
local config = require('xmake.config')

local XMake = {}

function XMake:Build(targetName, args)
  util.run('xmake', { 'build', '-r', targetName, args }, {
    env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' },
  })
end

function XMake:Debug(targetName, args)
  args = util.split_args(args)
  local dap_config = {
    name = targetName,
    program = project.GetTargetExecPath(targetName),
    args = args,
    cwd = project.GetTargetRunDir(targetName),
    env = project.GetTargetEnvs(targetName),
    externalConsole = false,
  }

  dap.run(vim.tbl_extend('force', dap_config, config.dap_configuration))
end

return XMake
