local xmake = require('xmake')
local project = require('xmake.util.project')

local subcommands = {}

function subcommands.complete(arg, cmd_line)
  local matches = {}

  local words = vim.split(cmd_line, ' ', { trimempty = true })
  if not vim.endswith(cmd_line, ' ') then
    -- Last word is not fully typed, don't count it
    table.remove(words, #words)
  end

  if #words == 1 then
    for subcommand in pairs(xmake) do
      if vim.startswith(subcommand, arg) then
        table.insert(matches, subcommand)
      end
    end
  end

  local target = project.GetProjectTarget()

  if #matches == 0 then
    for _, v in ipairs(target) do
      if #v ~= 0 then
        table.insert(matches, v)
      end
    end
  end

  return matches
end

function subcommands.run(subcommand)
  if #subcommand.fargs == 0 then
    xmake.Build()
    return
  end
  local subcommand_func = xmake[subcommand.fargs[1]]
  if not subcommand_func then
    vim.notify('No such subcommand: ' .. subcommand.fargs[1], vim.log.levels.ERROR)
    return
  end

  local target = ""
  local args = {}
  for k, v in ipairs(subcommand.fargs) do
    if k == 2 then
      target = v
    elseif k > 2 then
      table.insert(args, v)
    end
  end
  subcommand_func(xmake, target, args)
end

return subcommands
