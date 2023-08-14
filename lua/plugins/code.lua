return {
  -- 快速注释
  {
    'echasnovski/mini.comment',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    config = function()
      require('mini.comment').setup()
    end,
  },

  -- 快速文档
  {
    'danymat/neogen',
    event = 'BufEnter',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('neogen').setup({})
    end,
    enabled = false,
  },

  -- todo comments
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope', 'TodoLocList', 'TodoQuickFix' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup({})
    end,
  },

  -- 代码高亮
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('config.plugins.nvim-treesitter')
    end,
  },

  {
    'echasnovski/mini.ai',
    version = '*',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('mini.ai').setup()
    end,
  },

  -- 搜粟替换
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
  },

  -- xmake
  {
    dir = vim.fn.stdpath('config') .. '/xmake.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    config = function()
      -- MSBuild:
      vim.opt.errorformat:append([[\ %#%f(%l\,%c):\ %m]])
      -- cl.exe:
      vim.opt.errorformat:append([[\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %m]])
      -- clang / gcc
      vim.opt.errorformat:append([[%E%f:%l:%c:\ %trror:\ %m,%-Z%p^,%+C%.%#]])

      require('xmake').setup({})
    end,
  },

  -- 项目模板
  {
    'nvimdev/template.nvim',
    cmd = { 'Template', 'TemProject' },
    config = function()
      require('template').setup({
        temp_dir = vim.fn.stdpath('config') .. '/template',
      })
    end,
  },
}
