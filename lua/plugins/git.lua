return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'config.plugins.gitsigns'
    end,
  },

  {
    'sindrets/diffview.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- 内置git命令
  'tpope/vim-fugitive',
}
