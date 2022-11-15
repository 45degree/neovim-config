---@diagnostic disable: undefined-global

return function(use)

  -- 代码提纲
  use {
    'stevearc/aerial.nvim',
    config = function()
      require('aerial').setup()
    end
  }

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

  -- tags
  -- use {
  --   "ludovicchabant/vim-gutentags",
  --   config = function ()
  --     vim.g.gutentags_modules = {'ctags'}
  --     vim.g.gutentags_define_advanced_commands = 1
  --     vim.g.gutentags_cache_dir = vim.fn.expand('~/.cache/tags')
  --     vim.g.gutentags_file_list_command = {
  --       markers = {
  --         ['.git'] = [[bash -c "git ls-files; git ls-files --others --exclude-standard"]],
  --       },
  --     }
  --   end
  -- }

  -- 搜粟替换
  use 'nvim-pack/nvim-spectre'

  -- 格式化
  use 'editorconfig/editorconfig-vim'
end
