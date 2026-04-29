---@diagnostic disable: undefined-global

local M = {}

local function config_debuggers()
  -- load from json file
  require('config.dap.di-cpp')
  require('config.dap.di-python')
end

local function setup_exception_breakpoints()
  local dap = require('dap')
  local eb = require('config.dap.exception-breakpoints')

  ---@param session dap.Session
  dap.listeners.after.configurationDone['exception_breakpoints'] = function(session, _)
    local adapter_id = session.config.type
    local filters = session.capabilities.exceptionBreakpointFilters or {}
    eb.update_options(adapter_id, filters)
  end

  ---@param session dap.Session
  dap.listeners.after.launch['exception_breakpoints'] = function(session, _) eb.set_exception_breakpoints(session.config.type) end

  vim.api.nvim_create_user_command('DapToggleExceptionBreakpoints', function(opts) eb.toggle({ args = opts.args or '' }) end, {
    nargs = '?',
    complete = function() return vim.tbl_keys(dap.adapters) end,
    desc = 'Toggle DAP exception breakpoints for an adapter',
  })
end

function M.setup()
  config_debuggers()
  setup_exception_breakpoints()
end

return M
