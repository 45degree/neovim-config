return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst', -- or ft = 'typst'
  version = '0.1.*',
  enabled = require('config').lang.typst,
  dependence = 'williamboman/mason.nvim',
  build = function()
    require('typst-preview').update()
  end,
}
