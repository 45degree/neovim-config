return {
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst', -- or ft = 'typst'
    version = '0.1.*',
    enabled = GLOBAL_CONFIG.lang.typst,
    build = function()
      require('typst-preview').update()
    end,
  },
}
