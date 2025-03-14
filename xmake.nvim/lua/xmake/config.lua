local xmake_executable = 'xmake'
if vim.fn.has('UNIX') == 1 then xmake_executable = vim.env.HOME .. '/.local/bin/xmake' end

local insert_natvis = function(natvis_files, extrafiles)
  for _, file in ipairs(extrafiles) do
    local extension = string.match(file, '.+%.(.+)$')
    if extension == 'natvis' then table.insert(natvis_files, file) end
  end
end

---@param params xmake-nvim.debug-params
local function default_dap_configuration(params)
  local xmake = require('xmake')

  local natvis_file = {}
  local deps = xmake.target.deps(params.target_name)
  if deps then
    deps = type(deps) ~= 'table' and { deps } or deps
    for _, dep in ipairs(deps) do
      local files = xmake.target.extrafiles(dep)
      files = type(files) ~= 'table' and { files } or files
      insert_natvis(natvis_file, files)
    end
  end
  local extrafiles = xmake.target.extrafiles(params.target_name)
  extrafiles = type(extrafiles) ~= 'table' and { extrafiles } or extrafiles
  insert_natvis(natvis_file, extrafiles)

  local cpptools_env = {}
  for k, v in pairs(params.env) do
    table.insert(cpptools_env, { name = k, value = v })
  end

  local dap_config = {}

  if vim.fn.executable(params.debugger.codelldb) ~= 0 then
    table.insert(dap_config, {
      name = 'xmake debug with codelldb',
      type = 'codelldb',
      request = 'launch',
      stopOnEntry = false,
      program = params.program,
      args = params.args,
      cwd = params.cwd,
      env = params.env,
      externalConsole = false,
    })
  end

  if vim.fn.executable(params.debugger.gdb) ~= 0 then
    table.insert(dap_config, {
      name = 'xmake debug with cpptools(gdb)',
      type = 'cppdbg',
      request = 'launch',
      stopOnEntry = true,
      MIMode = 'gdb',
      miDebuggerPath = params.debugger.gdb,
      program = params.program,
      args = params.args,
      cwd = params.cwd,
      environment = cpptools_env,
      visualizerFile = natvis_file,
      setupCommands = {
        {
          text = '-enable-pretty-printing',
          description = 'enable pretty printing',
          ignoreFailures = false,
        },
      },
    })
  end

  if vim.fn.executable('lldb-mi') ~= 0 then
    table.insert(dap_config, {
      name = 'xmake debug with cpptools(lldb)',
      type = 'cppdbg',
      request = 'launch',
      stopOnEntry = true,
      MIMode = 'lldb',
      miDebuggerPath = params.debugger.lldb_mi,
      program = params.program,
      args = params.args,
      cwd = params.cwd,
      environment = cpptools_env,
      visualizerFile = natvis_file,
    })
  end

  return dap_config
end

local M = {}
M.opts = {
  xmake_executable = xmake_executable,
  quickfix_size = 10, -- cmake output window height
  quickfix_position = 'belowright', -- "belowright", "aboveleft", ...
  show_quickfix = 'always', -- "always", "only_on_error"
  debugger = {
    gdb = 'gdb',
    codelldb = 'codelldb',
    lldb_mi = 'lldb-mi',
  },
}
M.dap_configuration = default_dap_configuration

function M.setup(args) M.opts = vim.tbl_deep_extend('force', M.opts, args or {}) end

--- set debug configuration for dap
---@param callback fun(params: xmake-nvim.debug-params): table
function M.set_dap_configuration(callback) M.dap_configuration = callback or default_dap_configuration end

return M
