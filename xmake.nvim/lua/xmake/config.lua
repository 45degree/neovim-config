local xmake_executable = 'xmake'
if vim.fn.has('UNIX') == 1 then xmake_executable = vim.env.HOME .. '/.local/bin/xmake' end

local insert_natvis = function(natvis_files, extrafiles)
  for _, file in ipairs(extrafiles) do
    local extension = string.match(file, '.+%.(.+)$')
    if extension == 'natvis' then table.insert(natvis_files, file) end
  end
end

---@param params xmake-nvim.debug-params
---@return dap.Configuration[]
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

  ---@type dap.Configuration[]
  local dap_config = {}

  if vim.fn.executable('codelldb') ~= 0 then
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

  if vim.fn.executable('gdb') ~= 0 then
    table.insert(dap_config, {
      name = 'xmake debug with cpptools(gdb)',
      type = 'cppdbg',
      request = 'launch',
      stopOnEntry = true,
      MIMode = 'gdb',
      miDebuggerPath = vim.fn.exepath('gdb'),
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
      miDebuggerPath = vim.fn.exepath('lldb-mi'),
      program = params.program,
      args = params.args,
      cwd = params.cwd,
      environment = cpptools_env,
      visualizerFile = natvis_file,
    })
  end

  return dap_config
end

---@class xmake-nvim.debug-params
---@field target_name string current debug target name
---@field program string the absolute executable path of the target
---@field args string[] the arguments when run the target from debugger
---@field cwd string the working directory when run the target
---@field env table<string, string> the environment when run the target

---@class xmake-nvim.config
---@field xmake_executable string path to xmake executable, default is vim.fn.exepath('xmake')
---@field quickfix_size number output window height, default is 10
---@field quickfix_position 'belowright' | 'aboveleft'
---@field show_quickfix string 'always' | 'only_on_error'
---@field dap_configuration fun(params: xmake-nvim.debug-params): dap.Configuration[]
local M = {
  xmake_executable = xmake_executable,
  quickfix_size = 10, -- cmake output window height
  quickfix_position = 'belowright', -- "belowright", "aboveleft", ...
  show_quickfix = 'always', -- "always", "only_on_error"
  dap_configuration = default_dap_configuration,
}

--- setup xmake-nvim
---@param opts xmake-nvim.config
function M:setup(opts) self = vim.tbl_deep_extend('force', self, opts or {}) end

return M
