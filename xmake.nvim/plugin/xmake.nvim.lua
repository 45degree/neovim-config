if vim.version().minor < 7 then
  vim.notify('Neovim 0.7+ is required for xmake plugin', vim.log.levels.ERROR)
  return
end

-- local subcommands = require('xmake.subcommands')
local xmake = require('xmake')
local project = require('xmake.util.project')

local debugTargetSelect = function(opts)
  opts = opts or {}
  vim.ui.select(project.get_project_binary_target(), {}, function(item)
    if item == nil or item == '' then
      return
    end
    local args = vim.fn.input('Args: ')
    xmake.debug(item, args)
  end)
end

local buildTargetSelect = function(opts, force)
  opts = opts or {}
  vim.ui.select(project.get_project_target(), {}, function(item)
    if item == nil or item == '' then
      return
    end
    print(item)
    xmake.build(item, force)
  end)
end

local runTargetSelect = function()
  vim.ui.select(project.get_project_binary_target(), {}, function(item)
    if item == nil or item == '' then
      return
    end
    local args = vim.fn.input('Args: ')
    xmake.run(item, args)
  end)
end

local command = function(commandArgs)
  if commandArgs.fargs[1] == 'Debug' then
    debugTargetSelect({})
  elseif commandArgs.fargs[1] == 'Build' then
    buildTargetSelect({}, false)
  elseif commandArgs.fargs[1] == 'ReBuild' then
    buildTargetSelect({}, true)
  elseif commandArgs.fargs[1] == 'Run' then
    runTargetSelect()
  end
end

local function complete(arg, cmd_line)
  local matches = { 'Build', 'Debug', 'ReBuild', 'Run' }
  return matches
end

vim.api.nvim_create_user_command('XMake', command, { nargs = 1, complete = complete })
