local utils = {}

local function append_to_quickfix(error, data)
  local line = error and error or data
  vim.fn.setqflist({}, 'a', { lines = { line } })
  -- scroll the quickfix buffer to bottom
  vim.api.nvim_command('cbottom')
end

function utils.split_args(args)
  if not args then return {} end

  -- Handle table for compatibility with the previous version
  if type(args) == 'table' then return args end

  -- Split on spaces unless "in quotes"
  local split_args = vim.fn.split(args, [[\s\%(\%([^'"]*\(['"]\)[^'"]*\1\)*[^'"]*$\)\@=]])

  -- Remove quotes
  for i, arg in ipairs(split_args) do
    split_args[i] = arg:gsub('"', ''):gsub("'", '')
  end
  return split_args
end

function utils.join_args(args)
  if not args then return '' end

  -- Handle strings for compatibility with the previous version
  if type(args) == 'string' then return args end

  -- Add quotes if argument contain spaces
  for index, arg in ipairs(args) do
    if arg:find(' ') then args[index] = '"' .. arg .. '"' end
  end

  return table.concat(args, ' ')
end

function utils.show_quickfix(quickfix_position, quickfix_size)
  vim.api.nvim_command(quickfix_position .. ' copen ' .. quickfix_size)
  vim.api.nvim_command('wincmd j')
end

function utils.close_quickfix() vim.api.nvim_command('cclose') end

---@param cmd string
---@param env table<string, string>
---@param args string[]
function utils.run(cmd, env, args, opts)
  vim.cmd('wall')
  vim.fn.setqflist({}, ' ', { title = cmd .. ' ' .. table.concat(args, ' ') })

  local show_quickfix = opts.show_quickfix == 'always'
  if show_quickfix then utils.show_quickfix(opts.quickfix_position, opts.quickfix_size) end

  ---@type vim.SystemOpts
  local cmd_opts = {}
  cmd_opts.env = env
  cmd_opts.stdout = vim.schedule_wrap(append_to_quickfix)
  cmd_opts.stderr = vim.schedule_wrap(append_to_quickfix)
  cmd_opts.cwd = vim.uv.cwd()

  ---@param obj vim.SystemCompleted
  local on_exit = function(obj)
    local signal = obj.signal
    local code = obj.code
    append_to_quickfix('Exited with code ' .. (signal == 0 and code or 128 + signal))
    if signal ~= 0 or signal ~= 0 and opts.show_quickfix == 'only_on_error' then
      utils.show_quickfix(opts.quickfix_position, opts.quickfix_size)
      vim.api.nvim_command('cbottom')
    end
  end

  vim.system(vim.list_extend({ cmd }, args), cmd_opts, vim.schedule_wrap(on_exit))
end

return utils
