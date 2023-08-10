if vim.version().minor < 7 then
  vim.notify('Neovim 0.7+ is required for xmake plugin', vim.log.levels.ERROR)
  return
end

-- local subcommands = require('xmake.subcommands')
local xmake = require('xmake')
local project = require('xmake.util.project')

local debugTargetSelect = function(opts)
  opts = opts or {}
  vim.ui.select(project.GetProjectBinaryTarget(xmake.config), {}, function(item)
    if item == nil or item == '' then
      return
    end
    local args = vim.fn.input('Args: ')
    xmake:Debug(item, args)
  end)
end

local buildTargetSelect = function(opts, force)
  opts = opts or {}
  vim.ui.select(project.GetProjectTarget(xmake.config), {}, function(item)
    if item == nil or item == '' then
      return
    end
    print(item)
    xmake:Build(item, force)
  end)
end

local command = function(commandArgs)
  if commandArgs.fargs[1] == 'Debug' then
    debugTargetSelect({})
  elseif commandArgs.fargs[1] == 'Build' then
    buildTargetSelect({}, false)
  elseif commandArgs.fargs[1] == 'ReBuild' then
    buildTargetSelect({}, true)
  end
end

local function complete(arg, cmd_line)
  local matches = { 'Build', 'Debug', 'ReBuild' }
  return matches
end

vim.api.nvim_create_user_command('XMake', command, { nargs = 1, complete = complete })
