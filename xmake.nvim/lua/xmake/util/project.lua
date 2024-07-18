---@diagnostic disable: param-type-mismatch

require('xmake.util.string')
local config = require('xmake.config')
local Job = require('plenary.job')
local Path = require('plenary.path')

local M = {}

local __dirname = debug.getinfo(1, 'S').source:sub(2, -1):match('^.*/')

function M.get_project_target()
  local targetData = ''
  Job:new({
    command = config.opts.xmake_executable,
    args = { 'lua', Path:new(__dirname, './xmakeScript/target.lua'):__tostring() },
    env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' },
    on_stdout = function(_, data) targetData = targetData .. '\n' .. tostring(data) end,
  }):sync()

  local targets = {}
  for _, v in pairs(targetData:split('__end__')[1]:split('\n')) do
    v = v:trim()
    if v ~= '' then table.insert(targets, v) end
  end
  return targets
end

function M.get_project_binary_target()
  local targetData = ''
  Job:new({
    command = config.opts.xmake_executable,
    args = { 'lua', Path:new(__dirname, './xmakeScript/binary_target.lua'):__tostring() },
    env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' },
    on_stdout = function(_, data) targetData = targetData .. '\n' .. tostring(data) end,
  }):sync()

  local targets = {}
  for _, v in pairs(targetData:split('__end__')[1]:split('\n')) do
    v = v:trim()
    if v ~= '' then table.insert(targets, v) end
  end
  return targets
end

function M.get_target_envs(targetName)
  local targetData = ''
  Job:new({
    command = config.opts.xmake_executable,
    args = { 'lua', tostring(Path:new(__dirname, './xmakeScript/target_envs.lua')), targetName },
    env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' },
    on_stdout = function(_, data) targetData = targetData .. '\n' .. tostring(data) end,
  }):sync()

  local env = string.gsub(targetData:split('__end__')[1], '', '')

  if vim.fn.has('win32') == 1 then env = string.gsub(env, '\\', '\\\\') end

  return loadstring('return ' .. env)()
end

function M.get_target_attribute(target_name, attribute, ...)
  local target_data = ''
  Job:new({
    command = config.opts.xmake_executable,
    args = { 'lua', tostring(Path:new(__dirname, './xmakeScript/target_get.lua')), target_name, attribute, ... },
    env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' },
    on_stdout = function(_, data) target_data = target_data .. '\n' .. tostring(data) end,
  }):sync()

  local targets = {}
  for _, v in pairs(target_data:split('__end__')[1]:split('\n')) do
    v = v:trim()
    if v ~= '' then table.insert(targets, v) end
  end
  return targets
end

return M
