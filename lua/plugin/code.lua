---@diagnostic disable: undefined-global

return function(use)

  -- 快速注释
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- 快速文档
  use {
    "danymat/neogen",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('neogen').setup {}
    end,
  }

  -- todo comments
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
      }
    end
  }

  -- 代码高亮
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'p00f/nvim-ts-rainbow',
    },
    config = function()
      require('config.nvim-treesitter')
    end
  }

  -- 搜粟替换
  use 'nvim-pack/nvim-spectre'

  -- 格式化
  use 'editorconfig/editorconfig-vim'

  -- 高亮搜索
  use {
    'asiryk/auto-hlsearch.nvim',
    config = function ()
      require("auto-hlsearch").setup({
        remap_keys = { "/", "?", "*", "#", "n", "N" },
        create_commands = true,
      })
    end
  }
end
