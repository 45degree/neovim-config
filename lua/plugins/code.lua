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

  {
    'chentoast/marks.nvim',
    event = 'BufEnter',
    config = function()
      require('marks').setup({
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = {},
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = '⚑',
          virt_text = 'hello world',
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {},
      })
    end,
  },
}
