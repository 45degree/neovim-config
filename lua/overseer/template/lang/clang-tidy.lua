local overseer = require('overseer')

---@param opts overseer.SearchParams
local function get_compile_commands(opts) return vim.fs.find('compile_commands.json', { upward = true, type = 'file', path = opts.dir })[1] end

---@type overseer.TemplateFileDefinition
local tmpl = {
  name = 'clang-tidy',
  builder = function(params)
    local args = { params.file, '-quiet', '-p', params.cwd }
    if vim.fn.filereadable(params.cwd .. '/.clang-tidy') == 1 then
      table.insert(args, '-config-file')
      table.insert(args, params.cwd .. '/.clang-tidy')
    end

    return {
      cmd = 'clang-tidy',
      args = args,
      components = { { 'on_output_quickfix', set_diagnostics = true }, 'on_result_diagnostics', 'default' },
      cwd = params.cwd,
    }
  end,
  params = {
    cwd = { optional = true },
    file = { optional = false },
  },
  desc = 'Run clang-tidy on the single file',
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
      return true
    end,
  },

  generator = function(opts, cb)
    local cwd = vim.fs.dirname(get_compile_commands(opts))
    local file = vim.api.nvim_buf_get_name(0)
    local ret = { overseer.wrap_template(tmpl, nil, { cwd = cwd, file = file }) }
    cb(ret)
  end,
}

return provider
