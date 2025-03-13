local insert_natvis = function(natvis_files, extrafiles)
  for _, file in ipairs(extrafiles) do
    local extension = string.match(file, '.+%.(.+)$')
    if extension == 'natvis' then table.insert(natvis_files, file) end
  end
end

local set_xmake_dap_config = function(params)
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

return {
  dir = vim.fn.stdpath('config') .. '/xmake.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'XMake',
  config = function()
    -- MSBuild:
    vim.opt.errorformat:append([[\ %#%f(%l\,%c):\ %m]])
    -- cl.exe:
    vim.opt.errorformat:append([[\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %m]])
    -- clang / gcc
    vim.opt.errorformat:append([[%E%f:%l:%c:\ %trror:\ %m,%-Z%p^,%+C%.%#]])

    require('xmake').setup({})
    require('xmake').set_dap_config(set_xmake_dap_config)
  end,
}
