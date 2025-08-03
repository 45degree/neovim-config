local config = require('xmake.config')
local path = require('plenary.path')

local M = {
  project = require('xmake.util.project'),
  target = require('xmake.util.target'),
  __has_set_neoconf = false,
}

function M.setup(args)
  config.setup(args)

  local ok, neoconf_plugins = pcall(require, 'neoconf.plugins')
  if ok and not M.__has_set_neoconf and config.neoconf then
    neoconf_plugins.register({
      name = 'xmake',
      on_schema = function(schema)
        schema:import('xmake', {
          debugger = {
            gdb = 'gdb',
            codelldb = 'codelldb',
            lldb_mi = 'lldb-mi',
          },
          executable = 'xmake',
        })
      end,
      on_update = function()
        local new_config = require('neoconf').get('xmake')
        if new_config == nil then return end
        config.setup({
          xmake_executable = new_config.executable,
          debugger = {
            gdb = new_config.debugger.gdb,
            codelldb = new_config.debugger.codelldb,
            lldb_mi = new_config.debugger.lldb_mi,
          },
        })
      end,
    })
    M.__has_set_neoconf = true
  end
end

function M.set_dap_config(dap_config_func) config.set_dap_configuration(dap_config_func) end

function M.build(targetName, force)
  local util = require('xmake.util.util')
  local env = { PATH = vim.env.PATH, ['COLORTERM'] = 'nocolor' }
  local xmake_executable = config.opts.xmake_executable
  if force then
    util.run(xmake_executable, env, { 'build', '-r', targetName }, config.opts)
  else
    util.run(xmake_executable, env, { 'build', targetName }, config.opts)
  end
end

---@class xmake-nvim.debugger
---@field gdb string
---@field codelldb string
---@field lldb_mi string

---@class xmake-nvim.debug-params
---@field target_name string
---@field program string
---@field args string[]
---@field cwd string
---@field env table<string, string>
---@field debugger xmake-nvim.debugger

function M.debug(target_name, args)
  local util = require('xmake.util.util')
  local project = require('xmake.util.project')
  local target = require('xmake.util.target')
  local dap = require('dap')
  local rootdir = path:new(project.projectdir())
  local target_file = path:new(target.targetfile(target_name))
  local target_rundir = path:new(target.rundir(target_name))

  ---@type xmake-nvim.debug-params
  local params = {
    target_name = target_name,
    program = rootdir:joinpath(target_file):absolute(),
    args = util.split_args(args),
    cwd = target_rundir:absolute(),
    env = target.envs(target_name),
    debugger = {
      gdb = config.opts.debugger.gdb,
      codelldb = config.opts.debugger.codelldb,
      lldb_mi = config.opts.debugger.lldb_mi,
    },
  }
  local dap_configurations = config.dap_configuration(params)
  if #dap_configurations > 1 then
    local names = {}
    for _, dap_config in ipairs(dap_configurations) do
      table.insert(names, dap_config.name)
    end
    vim.ui.select(names, {}, function(item, idx)
      if item == nil or idx == nil then return end
      dap.run(dap_configurations[idx])
    end)
  elseif #dap_configurations == 1 then
    dap.run(dap_configurations[1])
  else
    dap.run(dap_configurations)
  end
end

function M.run(targetName, args)
  local util = require('xmake.util.util')
  local env = { PATH = vim.env.PATH }
  local xmake_executable = config.opts.xmake_executable
  util.run(xmake_executable, env, { 'run', targetName, args }, config.opts)
end

return M
