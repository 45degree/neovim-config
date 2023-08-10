local Job = require('plenary.job')
local Path = require('plenary.path')
local config = require('xmake.config')
local scandir = require('plenary.scandir')
local utils = {}

local function append_to_quickfix(error, data)
  local line = error and error or data
  vim.fn.setqflist({}, 'a', { lines = { line } })
  -- scroll the quickfix buffer to bottom
  vim.api.nvim_command('cbottom')
end

function utils.split_args(args)
  if not args then
    return {}
  end

  -- Handle table for compatibility with the previous version
  if type(args) == 'table' then
    return args
  end

  -- Split on spaces unless "in quotes"
  local splitted_args = vim.fn.split(args, [[\s\%(\%([^'"]*\(['"]\)[^'"]*\1\)*[^'"]*$\)\@=]])

  -- Remove quotes
  for i, arg in ipairs(splitted_args) do
    splitted_args[i] = arg:gsub('"', ''):gsub("'", '')
  end
  return splitted_args
end

function utils.join_args(args)
  if not args then
    return ''
  end

  -- Handle strings for compatibility with the previous version
  if type(args) == 'string' then
    return args
  end

  -- Add quotes if argument contain spaces
  for index, arg in ipairs(args) do
    if arg:find(' ') then
      args[index] = '"' .. arg .. '"'
    end
  end

  return table.concat(args, ' ')
end

function utils.show_quickfix(quickfix_position, quickfix_size)
  vim.api.nvim_command(quickfix_position .. ' copen ' .. quickfix_size)
  vim.api.nvim_command('wincmd j')
end

function utils.close_quickfix()
  vim.api.nvim_command('cclose')
end

function utils.run(cmd, env, args, opts)
  vim.cmd('wall')
  vim.fn.setqflist({}, ' ', { title = cmd .. ' ' .. table.concat(args, ' ') })

  local show_quickfix = opts.show_quickfix == 'always'
  if show_quickfix then
    utils.show_quickfix(opts.quickfix_position, opts.quickfix_size)
  end

  utils.job = Job:new({
    command = cmd,
    args = args,
    cwd = vim.loop.cwd(),
    env = env,
    on_stdout = vim.schedule_wrap(append_to_quickfix),
    on_stderr = vim.schedule_wrap(append_to_quickfix),
    on_exit = vim.schedule_wrap(function(_, code, signal)
      append_to_quickfix('Exited with code ' .. (signal == 0 and code or 128 + signal))
      if code == 0 and signal == 0 then
        if opts.on_success then
          opts.on_success()
        end
      elseif opts.show_quickfix == 'only_on_error' then
        utils.show_quickfix(opts.quickfix_position, opts.quickfix_size)
        vim.api.nvim_command('cbottom')
      end
    end),
  })

  utils.job:start()
  return utils.job
end

function utils.ensure_no_job_active()
  if not utils.last_job or utils.last_job.is_shutdown then
    return true
  end
  utils.notify('Another job is currently running: ' .. utils.last_job.command, vim.log.levels.ERROR)
  return false
end

return utils
