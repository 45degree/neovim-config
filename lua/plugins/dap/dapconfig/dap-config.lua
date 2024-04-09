---@diagnostic disable: undefined-global

local M = {}

local function config_debuggers()
  -- load from json file
  require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'cpp' } })
  require('plugins.dap.dapconfig.di-cpp')
  require('plugins.dap.dapconfig.di-python')
end

function M.setup()
  config_debuggers() -- Debugger
end

return M
