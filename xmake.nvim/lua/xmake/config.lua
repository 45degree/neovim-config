local dap_type = 'cpptool'
if vim.fn.has('WIN32') == 1 then
  dap_type = 'codelldb'
end

local xmake_executable = 'xmake'
if vim.fn.has('UNIX') == 1 then
  xmake_executable = vim.env.HOME .. '/.local/bin/xmake'
end

local config =  {
  xmake_executable = xmake_executable,
  xmake_console_size = 10, -- cmake output window height
  xmake_console_position = "belowright", -- "belowright", "aboveleft", ...
  xmake_show_console = "always", -- "always", "only_on_error"
  dap_configuration = {
    name = 'Launch file',
    type = dap_type,
    request = 'launch',
    stopOnEntry = false,
    setupCommands = {
      {
        description = 'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false,
      },
    },
  },
  dap_open_command = require('dap').repl.open,
}

function config:new(const)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self
  return self
end

return config
