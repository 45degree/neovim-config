local dap_type = 'cppdbg';
if vim.fn.has('win32') then
  dap_type = 'codelldb'
end

local xmake_executable = 'xmake'
if vim.fn.has('UNIX') then
  xmake_executable = vim.env.HOME.."/.local/bin/xmake"
end

local config = {
  defaults = {
    xmake_executable = xmake_executable,
    dap_configuration = {
      name = "Launch file",
      type = dap_type,
      request = 'launch',
      stopOnEntry = false,
    },
    dap_open_command = require('dap').repl.open,
  },
}

setmetatable(config, { __index = config.defaults })

return config
