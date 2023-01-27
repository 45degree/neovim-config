return {
  -- 快速注释
  {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  },

  -- 快速文档
  {
    "danymat/neogen",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    config = function()
      require('neogen').setup {}
    end,
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
      require("todo-comments").setup {
      }
    end
  },

  -- 代码高亮
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'p00f/nvim-ts-rainbow',
    },
    config = function()
      require('config.plugins.nvim-treesitter')
    end
  },

  -- 搜粟替换
  'nvim-pack/nvim-spectre',

  -- 格式化
  'editorconfig/editorconfig-vim',

  -- 高亮搜索
  {
    'asiryk/auto-hlsearch.nvim',
    config = function ()
      require("auto-hlsearch").setup({
        remap_keys = { "/", "?", "*", "#", "n", "N" },
        create_commands = true,
      })
    end
  }
}
