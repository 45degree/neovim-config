---@diagnostic disable: undefined-global

return {

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('config.plugins.which-key-nvim')
    end,
  },

  -- 快速跳转
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    config = function()
      require('flash').setup({
        modes = { char = { enabled = false } },
      })
      vim.api.nvim_set_keymap('n', 's', "<cmd>lua require('flash').jump()<cr>", {})
    end,
  },

  -- sudo保存
  {
    'lambdalisue/suda.vim',
    event = 'VeryLazy',
    config = function()
      vim.g.suda_smart_edit = 1
    end,
    enable = function()
      return vim.fn.has('WIN32') == 0
    end,
  },

  {
    'ethanholz/nvim-lastplace',
    event = 'VeryLazy',
    config = function()
      require('nvim-lastplace').setup({
        lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
        lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
        lastplace_open_folds = true,
      })
    end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    event = 'BufEnter',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('config.plugins.neo-tree-nvim')
    end,
  },

  -- Lua
  {
    'ahmedkhalf/project.nvim',
    event = 'UIEnter',
    config = function()
      require('project_nvim').setup({
        detection_methods = { 'pattern', 'lsp' },
        patterns = { '.git', '*.sln' },
      })
    end,
  },

  -- 下划线
  {
    'yamatsum/nvim-cursorline',
    event = 'BufEnter',
    config = function()
      require('nvim-cursorline').setup({
        cursorline = {
          enable = false,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        },
      })
    end,
  },

  {
    'hrsh7th/vim-eft',
    event = 'BufEnter',
    config = function()
      vim.api.nvim_set_keymap('n', ';', '<Plug>(eft-repeat)', {})
      vim.api.nvim_set_keymap('x', ';', '<Plug>(eft-repeat)', {})
      vim.api.nvim_set_keymap('o', ';', '<Plug>(eft-repeat)', {})

      vim.api.nvim_set_keymap('n', 'f', '<Plug>(eft-f)', {})
      vim.api.nvim_set_keymap('x', 'f', '<Plug>(eft-f)', {})
      vim.api.nvim_set_keymap('o', 'f', '<Plug>(eft-f)', {})

      vim.api.nvim_set_keymap('n', 'F', '<Plug>(eft-F)', {})
      vim.api.nvim_set_keymap('x', 'F', '<Plug>(eft-F)', {})
      vim.api.nvim_set_keymap('o', 'F', '<Plug>(eft-F)', {})

      vim.api.nvim_set_keymap('n', 't', '<Plug>(eft-t)', {})
      vim.api.nvim_set_keymap('x', 't', '<Plug>(eft-t)', {})
      vim.api.nvim_set_keymap('o', 't', '<Plug>(eft-t)', {})

      vim.api.nvim_set_keymap('n', 'T', '<Plug>(eft-T)', {})
      vim.api.nvim_set_keymap('x', 'T', '<Plug>(eft-T)', {})
      vim.api.nvim_set_keymap('o', 'T', '<Plug>(eft-T)', {})
    end,
  },

  -- 自动匹配括号
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },

  -- 模糊搜索
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    config = function()
      require('config.plugins.telescope')
    end,
  },

  -- 成对编辑
  {
    'tpope/vim-surround',
    event = 'BufEnter',
  },

  -- 终端
  {
    'akinsho/toggleterm.nvim',
    event = 'BufEnter',
    config = function()
      require('config.plugins.toggleterm')
    end,
  },

  -- markdown
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.call('mkdp#util#install')
    end,
    config = function()
      require('config.plugins.markdown-preview')
    end,
  },

  -- 窗口选择
  {
    -- only needed if you want to use the commands with "_with_window_picker" suffix
    's1n7ax/nvim-window-picker',
    tag = 'v1.5',
    event = 'UIEnter',
    config = function()
      require('config.plugins.nvim-window-picker')
    end,
  },

  -- 翻译
  {
    'potamides/pantran.nvim',
    event = 'BufEnter',
    config = function()
      require('pantran').setup({
        default_engine = 'google',
      })
    end,
  },
}
