local overseer = require('overseer')

---@param opts overseer.SearchParams
local function get_compile_commands(opts) return vim.fs.find('compile_commands.json', { upward = true, type = 'file', path = opts.dir })[1] end

local function get_run_clang_tidy_file()
  local paths = vim.split(vim.env.PATH, vim.fn.has('WIN32') and ';' or ':')
  local run_clang_tidy_files = { 'run-clang-tidy', 'run-clang-tidy.py' }
  for _, path in ipairs(paths) do
    for _, file in ipairs(run_clang_tidy_files) do
      if vim.fn.filereadable(path .. '/' .. file) == 1 then return path .. '/' .. file end
    end
  end
  return nil
end

---@type overseer.TemplateFileDefinition
local tmpl = {
  name = 'clang-tidy',
  builder = function(params)
    local args = { params.run_clang_tidy_path, '-quiet', '-p', params.cwd }
    if vim.fn.filereadable(params.cwd .. '/.clang-tidy') == 1 then
      table.insert(args, '-config-file')
      table.insert(args, params.cwd .. '/.clang-tidy')
    end

    return {
      cmd = 'python',
      args = args,
      components = { { 'on_output_quickfix', set_diagnostics = true }, 'on_result_diagnostics', 'default' },
      cwd = params.cwd,
    }
  end,
  params = {
    cwd = { optional = true },
    run_clang_tidy_path = { optional = false },
  },
  desc = 'Run clang-tidy on the project',
  tags = { 'LINT' },
  condition = {
    filetype = { 'c', 'cpp' },
  },
}

---@type overseer.TemplateFileProvider
local provider = {
  cache_key = get_compile_commands,
  condition = {
    callback = function(opts)
      if vim.fn.executable('clang-tidy') == 0 then return false, 'Command "clang-tidy" not found' end
      if not get_compile_commands(opts) then return false, 'No compile_commands found' end
      if not get_run_clang_tidy_file() then return false, "Can't find run-clang-tidy" end
      if vim.fn.executable('python') == 0 then return false, 'Command "python" not found' end
      return true
    end,
  },

  generator = function(opts, cb)
    local file = get_compile_commands(opts)
    local run_clang_tidy_path = get_run_clang_tidy_file()
    local cwd = vim.fs.dirname(file)
    local ret = { overseer.wrap_template(tmpl, nil, { cwd = cwd, run_clang_tidy_path = run_clang_tidy_path }) }
    cb(ret)
  end,
}

return provider
