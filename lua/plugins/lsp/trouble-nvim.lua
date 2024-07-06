return {
  'folke/trouble.nvim',
  cmd = { 'TroubleToggle', 'Trouble' },
  config = function()
    require('trouble').setup({})
  end,
}
