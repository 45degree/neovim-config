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

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.fn.exepath('OpenDebugAD7'),
}

if vim.fn.has('win32') == 1 then
  dap.adapters.cppdbg.options = {
    detached = false,
  }
  dap.adapters.codelldb.executable.detached = false
end

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
    MIMode = 'gdb',
    miDebuggerPath = vim.fn.exepath('gdb'),
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
    miDebuggerPath = vim.fn.exepath('gdb'),
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
