if vim.version().minor < 7 then
  vim.notify('Neovim 0.7+ is required for xmake plugin', vim.log.levels.ERROR)
  return
end

-- local subcommands = require('xmake.subcommands')
local xmake = require('xmake')


local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local project = require('xmake.util.project')
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local debugTargetSelect = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "targetSelect",
    finder = finders.new_table {
      results = project.GetProjectBinaryTarget(),
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local target  = action_state.get_selected_entry()[1]

        -- input 
        local args = vim.fn.input("Args: ")
        xmake:Debug(target, args)
      end)
      return true
    end,
  }):find()
end

local command = function (commandArgs)
  if commandArgs.fargs[1] == "Debug" then
    debugTargetSelect({});
  end
end

local function complete(arg, cmd_line)
  local matches = {}

  local words = vim.split(cmd_line, ' ', { trimempty = true })
  if not vim.endswith(cmd_line, ' ') then
    -- Last word is not fully typed, don't count it
    table.remove(words, #words)
  end

  for subcommand in pairs(xmake) do
    if vim.startswith(subcommand, arg) then
      table.insert(matches, subcommand)
    end
  end

  return matches
end


vim.api.nvim_create_user_command('XMake', command, { nargs = 1, complete = complete})
