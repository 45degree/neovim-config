return {
  'williamboman/mason.nvim',
  cmd = 'Mason',
  config = function()
    local icons = require('icons')
    local config = require('config')
    require('mason').setup({
      ui = {
        border = config.border,
        icons = {
          -- The list icon to use for installed packages.
          package_installed = icons.widgets.loaded,
          -- The list icon to use for packages that are installing, or queued for installation.
          package_pending = icons.widgets.on_load,
          -- The list icon to use for packages that are not installed.
          package_uninstalled = icons.widgets.not_loaded,
        },
      },
    })
  end,
}
