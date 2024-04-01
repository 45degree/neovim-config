return {
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('neogen').setup({})
  end,
}
