return {
  'potamides/pantran.nvim',
  cmd = 'Pantran',
  config = function()
    require('pantran').setup({
      default_engine = 'google',
    })
  end,
}
