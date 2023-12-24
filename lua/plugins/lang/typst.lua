local util = require('plugins.util')
local config = require('config')

util.on_very_lazy(function()
  if not config.lang.typst then
    return
  end

  if util.is_mason_package_installed('typst-lsp') then
    return
  end

  util.install_mason_package('typst-lsp')
end)

return {
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst', -- or ft = 'typst'
    version = '0.1.*',
    enabled = require('config').lang.typst,
    dependence = 'williamboman/mason.nvim',
    build = function()
      require('typst-preview').update()
    end,
  },
  {
    'kaarmu/typst.vim',
    ft = 'typst',
    enabled = require('config').lang.typst,
  },
}
