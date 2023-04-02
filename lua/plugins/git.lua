return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
      require('config.plugins.gitsigns')
    end,
  },

  {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- 内置git命令
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
  },
}
