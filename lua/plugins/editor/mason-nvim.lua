return {
  'mason-org/mason.nvim',
  cmd = 'Mason',
  opts = {
    ui = {
      border = require('config').border,
      icons = {
        -- The list icon to use for installed packages.
        package_installed = require('icons').widgets.loaded,
        -- The list icon to use for packages that are installing, or queued for installation.
        package_pending = require('icons').widgets.on_load,
        -- The list icon to use for packages that are not installed.
        package_uninstalled = require('icons').widgets.not_loaded,
      },
    },
  },
}
