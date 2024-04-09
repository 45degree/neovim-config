return {
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  cmd = "Neogen",
  config = function()
    require('neogen').setup({})
  end,
}
