---@diagnostic disable: undefined-global

local M = {}

local function config_dapui()
  local dap, dapui = require "dap", require "dapui"

  local debug_open = function()
    dapui.open()
    vim.api.nvim_command("DapVirtualTextEnable")
  end
  local debug_close = function()
    dap.repl.close()
    dapui.close()
    vim.api.nvim_command("DapVirtualTextDisable")
    -- vim.api.nvim_command("bdelete! term:")   -- close debug temrinal
  end

  dap.listeners.after.event_initialized["dapui_config"] = function()
    debug_open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    debug_close()
  end
  dap.listeners.before.event_exited["dapui_config"]     = function()
    debug_close()
  end
  dap.listeners.before.disconnect["dapui_config"]       = function()
    debug_close()
  end
end

local function config_debuggers()
  local dap = require("dap");

  -- load from json file
  require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'cpp' } })

  dap.adapters.python = require('config.dap.di-python').adapters
  dap.configurations.python = require('config.dap.di-python').configurations

  dap.adapters.cpptool = require('config.dap.di-cpp').adapters
  dap.configurations.cpptool = require('config.dap.di-cpp').configurations

  dap.adapters.codelldb = require('config.dap.di-codelldb').adapters
  dap.configurations.codelldb = require('config.dap.di-codelldb').configurations
end

function M.setup()
  config_dapui()
  config_debuggers() -- Debugger

  -- Shorten function name
  local keymap = vim.api.nvim_set_keymap
  -- set key map
  keymap("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", {})
  keymap("n", "<leader><F9>", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", {})
  -- keymap("n", "<leader>dr", "lua require'dap'.repl.open()<cr>", opts)
  -- keymap('n', '<F10>', '<cmd>lua require"user.dap.dap-util".reload_continue()<CR>', {})
  keymap("n", "<F4>", "<cmd>lua require'dap'.terminate()<cr>", {})
  keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", {})
  keymap("n", "<F6>", "<cmd>lua require'dap'.pause()<cr>", {})
  keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", {})
  keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", {})
  keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>", {})
  keymap("n", "DK", "<cmd>lua require'dapui'.eval()<cr>", {})
  keymap("n", "<leader><F8>", "<cmd>lua require'dap'.run_to_cursor() <cr>", {})
end

return M
