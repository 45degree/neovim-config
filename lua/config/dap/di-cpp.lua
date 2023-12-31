local dap = require('dap')

local inputProgram = function()
  local programFile = vim.fn.input({
    prompt = 'Path to executable: ',
    default = vim.fn.getcwd(),
    completion = 'file',
  })
  return programFile
end

dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fn.exepath('codelldb'),
    args = { '--port', '${port}' },
  },
}

dap.adapters.cpptool = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.fn.exepath('OpenDebugAD7'),
}

dap.configurations.cpp = {
  {
    name = 'Launch file(debug with codelldb)',
    type = 'codelldb',
    request = 'launch',
    program = inputProgram,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
  {
    name = 'Launch file(debug with cpptool)',
    type = 'cppdbg',
    request = 'launch',
    miDebuggerPath = '/usr/bin/gdb',
    program = inputProgram,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
      {
        description = 'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false,
      },
    },
  },
  {
    name = 'Attach process(debug with cpptool)',
    type = 'cppdbg',
    request = 'attach',
    processId = require('dap.utils').pick_process,
    program = inputProgram,
    cwd = '${workspaceFolder}',
    setupCommands = {
      {
        description = 'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false,
      },
    },
  },
  {
    name = 'Attach to gdbserver :1234(debug with cpptool)',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = inputProgram,
    setupCommands = {
      {
        description = 'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false,
      },
    },
  },
}
