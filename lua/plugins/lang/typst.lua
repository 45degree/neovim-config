return {
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst', -- or ft = 'typst'
    version = '0.1.*',
    enabled = require('config').lang.typst,
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
