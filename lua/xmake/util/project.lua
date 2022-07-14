require("xmake.util.string")
local Job = require("plenary.job")
local Path = require("plenary.path")

local M = {}

local __dirname = debug.getinfo(1, "S").source:sub(2, -1):match("^.*/")

function M.GetProjectTarget()
  local targetData = ""
  Job:new({
    command = 'xmake',
    args = {'lua', Path:new(__dirname, './xmakeScript/target.lua'):__tostring()},
    env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' },
    on_stdout = function(_, data)
      targetData = targetData..'\n'..tostring(data)
    end,
  }):sync()

  return targetData:split('__end__')[1]:split('\n')
end

function M.GetTargetEnvs(targetName)
  local targetData = ""
  Job:new({
    command = 'xmake',
    args = {'lua', tostring(Path:new(__dirname, './xmakeScript/target_envs.lua')), targetName},
    env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' },
    on_stdout = function(_, data)
      targetData = targetData..tostring(data)
    end,
  }):sync()

  local env = string.gsub(targetData:split('__end__')[1], "", "")

  if vim.fn.has('win32') == 1 then
    env = string.gsub(env, "\\", "\\\\")
  end

  return loadstring('return '..env)()
end

function M.GetTargetRunDir(targetName)
  local targetData = ""
  Job:new({
    command = 'xmake',
    args = {'lua', tostring(Path:new(__dirname, './xmakeScript/target_rundir.lua')), targetName},
    env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' },
    on_stdout = function(_, data)
      targetData = targetData..tostring(data)
    end,
  }):sync()

  return targetData:split('__end__')[1]
end

function M.GetTargetExecPath(targetName)
  local targetData = ""
  Job:new({
    command = 'xmake',
    args = {'lua', tostring(Path:new(__dirname, './xmakeScript/targetpath.lua')), targetName},
    env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' },
    on_stdout = function(_, data)
      targetData = targetData..tostring(data)
    end,
  }):sync()

  return targetData:split('__end__')[1]
end

return M
