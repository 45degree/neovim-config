local M = {}

function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      fn()
    end,
  })
end

function M.is_mason_package_installed(name)
  return require('mason-registry').is_installed(name)
end

function M.install_mason_package(name)
  local server_name, version = require('mason-core.package').Parse(name)
  local pkg = require('mason-registry').get_package(server_name)

  local notify_ok, notify = pcall(require, 'notify')
  if not notify_ok then
    vim.notify('[mason package] begin to automatically install: ' .. name, vim.log.levels.INFO)
  else
    notify('[mason package] begin to automatically install: ' .. name, vim.log.levels.INFO)
  end

  pkg:install({ version = version }):once(
    'closed',
    vim.schedule_wrap(function()
      if pkg:is_installed() then
        vim.notify('[mason package]' .. name .. ' automatically installed', vim.log.levels.INFO)
      else
        vim.notify('[mason package]' .. name .. ' failed to automatically install', vim.log.levels.ERROR)
      end
    end)
  )
end

return M
