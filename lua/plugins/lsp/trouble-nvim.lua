return {
  'folke/trouble.nvim',
  cmd = { 'TroubleToggle', 'Trouble' },
  dependencies = { 'nvim-cmp', 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('trouble').setup({})
  end,
}
