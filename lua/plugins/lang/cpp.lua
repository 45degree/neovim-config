local util = require('plugins.util')
local config = require('config')

util.on_very_lazy(function()
  if not config.lang.cpp then
    return
  end

  if util.is_mason_package_installed('clangd') then
    return
  end

  util.install_mason_package('clangd')
end)

return {}
