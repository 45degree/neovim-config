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

  -- Shorten function name
  local keymap = vim.api.nvim_set_keymap
  -- set key map
  keymap('n', '<F9>', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", {})
  keymap('n', '<space><F9>', "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", {})
  keymap('n', '<F4>', "<cmd>lua require'dap'.terminate()<cr>", {})
  keymap('n', '<F5>', "<cmd>lua require'dap'.continue()<cr>", {})
  keymap('n', '<F6>', "<cmd>lua require'dap'.pause()<cr>", {})
  keymap('n', '<F10>', "<cmd>lua require'dap'.step_over()<cr>", {})
  keymap('n', '<F11>', "<cmd>lua require'dap'.step_into()<cr>", {})
  keymap('n', '<F12>', "<cmd>lua require'dap'.step_out()<cr>", {})
  keymap('n', 'DK', "<cmd>lua require'dapui'.eval()<cr>", {})
  keymap('n', '<space><F8>', "<cmd>lua require'dap'.run_to_cursor() <cr>", {})
end

return M
