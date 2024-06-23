return {
  'RRethy/nvim-base16',
  lazy = true,
  confg = function()
    require('base16-colorscheme').with_config({
      telescope = true,
      indentblankline = true,
      notify = true,
      ts_rainbow = true,
      cmp = true,
      illuminate = true,
      dapui = true,
    })
  end,
}
