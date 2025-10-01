if vim.version().minor < 7 then
  vim.notify('Neovim 0.7+ is required for xmake plugin', vim.log.levels.ERROR)
  return
end

-- local subcommands = require('xmake.subcommands')
local xmake = require('xmake')
local util = require('xmake.util.util')
local project = require('xmake.util.project')

---@param target_name string?
local debug_target = function(target_name)
  if target_name ~= nil then
    local args = util.split_args(vim.fn.input('Args: '))
    xmake.debug(target_name, args)
    return
  end

  vim.ui.select(project.binary_targets(), {}, function(item)
    if item == nil or item == '' then return end
    local args = util.split_args(vim.fn.input('Args: '))
    xmake.debug(item, args)
  end)
end

---@param target_name string?
local build_target = function(target_name)
  if target_name ~= nil then
    local opts = util.split_args(vim.fn.input('xmake build options: '))
    xmake.build(target_name, opts)
    return
  end

  vim.ui.select(project.targets(), {}, function(item)
    if item == nil or item == '' then return end

    local opts = util.split_args(vim.fn.input('xmake build options: '))
    xmake.build(item, opts)
  end)
end

---@param target_name string?
local run_target = function(target_name)
  if target_name ~= nil then
    local args = util.split_args(vim.fn.input('Args: '))
    xmake.run(target_name, args)
    return
  end

  vim.ui.select(project.binary_targets(), {}, function(item)
    if item == nil or item == '' then return end
    local args = util.split_args(vim.fn.input('Args: '))
    xmake.run(item, args)
  end)
end

---@param args vim.api.keyset.create_user_command.command_args
local command = function(args)
  local commands = vim.split(vim.trim(args.fargs[1]), '%s+')

  if commands[1] == 'Debug' then debug_target(commands[2]) end
  if commands[1] == 'Build' then build_target(commands[2]) end
  if commands[1] == 'Run' then run_target(commands[2]) end
end

local function complete(arg, cmd_line)
  local parts = vim.split(vim.trim(cmd_line), '%s+')
  local level = #parts

  if level == 1 then
    return { 'Build', 'Debug', 'Run' }
  elseif level == 2 then
    local sub = parts[2]
    if sub == 'Build' then
      return require('xmake.util.project').targets()
    elseif sub == 'Debug' or sub == 'Run' then
      return require('xmake.util.project').binary_targets()
    end
  end

  return {}
end

vim.api.nvim_create_user_command('XMake', command, { nargs = 1, complete = complete })
