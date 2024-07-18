local overseer = require('overseer')

---@param opts overseer.SearchParams
local function get_compile_commands(opts) return vim.fs.find('compile_commands.json', { upward = true, type = 'file', path = opts.dir })[1] end

---@type overseer.TemplateFileDefinition
local tmpl = {
  name = 'cppcheck',
  builder = function(params)
    return {
      cmd = 'cppcheck',
      args = {
        '--project=compile_commands.json',
        '--enable=warning,style,performance,information',
        '--suppress=missingIncludeSystem',
        '--inline-suppr',
        '--quiet',
        '--template={file}:{line}:{column}: [{id}] {severity}: {message}',
      },
      components = { { 'on_output_quickfix', set_diagnostics = true }, 'on_result_diagnostics', 'default' },
      cwd = params.cwd,
    }
  end,
  params = {
    cwd = { optional = true },
  },
  desc = 'Run cppcheck on the project',
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
      if vim.fn.executable('cppcheck') == 0 then return false, 'Command "cppcheck" not found' end
      if not get_compile_commands(opts) then return false, 'No compile_commands found' end
      return true
    end,
  },

  generator = function(opts, cb)
    local file = get_compile_commands(opts)
    local cwd = vim.fs.dirname(file)
    local ret = { overseer.wrap_template(tmpl, nil, { cwd = cwd }) }
    vim.print(file)
    cb(ret)
  end,
}

return provider
