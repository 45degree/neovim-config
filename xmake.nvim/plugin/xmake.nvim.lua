if vim.version().minor < 7 then
  vim.notify('Neovim 0.7+ is required for xmake plugin', vim.log.levels.ERROR)
  return
end

-- local subcommands = require('xmake.subcommands')
local xmake = require('xmake')

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local project = require('xmake.util.project')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local debugTargetSelect = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = 'targetSelect',
      finder = finders.new_table({
        results = project.GetProjectBinaryTarget(xmake.config),
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local target = action_state.get_selected_entry()[1]

          -- input
          local args = vim.fn.input('Args: ')
          xmake:Debug(target, args)
        end)
        return true
      end,
    })
    :find()
end

local buildTargetSelect = function(opts, force)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = 'targetSelect',
      finder = finders.new_table({
        results = project.GetProjectTarget(xmake.config),
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local target = action_state.get_selected_entry()[1]

          xmake:Build(target, force)
        end)
        return true
      end,
    })
    :find()
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
