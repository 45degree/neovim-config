return {
  -- 快速注释
  {
    'numToStr/Comment.nvim',
    event = 'BufEnter',
    config = function()
      require('Comment').setup()
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
  },

  -- todo comments
  {
    'folke/todo-comments.nvim',
    event = 'BufEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup({})
    end,
  },

  -- 代码高亮
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufEnter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'HiPhish/nvim-ts-rainbow2',
    },
    config = function()
      require('config.plugins.nvim-treesitter')
    end,
  },

  -- 搜粟替换
  {
    'nvim-pack/nvim-spectre',
    event = 'BufEnter',
  },

  -- 格式化
  {
    'editorconfig/editorconfig-vim',
    event = 'BufEnter',
  },

  -- 高亮搜索
  {
    'asiryk/auto-hlsearch.nvim',
    event = 'VeryLazy',
    config = function()
      require('auto-hlsearch').setup({
        remap_keys = { '/', '?', '*', '#', 'n', 'N' },
        create_commands = true,
      })
    end,
  },

  -- xmake
  {
    dir = vim.fn.stdpath('config') .. '/xmake.nvim',
    event = 'CmdlineEnter',
    dependencies = { 'nvim-lua/plenary.nvim', 'telescope.nvim' },
    config = function()
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
