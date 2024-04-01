return {
  'nvim-telescope/telescope-dap.nvim',
  event = 'VeryLazy',
  dependencies = {
    'telescope.nvim',
    'mfussenegger/nvim-dap',
  },
  config = function()
    require('telescope').load_extension('dap')
  end,
}
