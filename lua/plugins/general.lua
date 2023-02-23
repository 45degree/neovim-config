---@diagnostic disable: undefined-global

return {

  {
    'folke/which-key.nvim',
    config = function ()
      require('config.plugins.which-key-nvim')
    end
  },

  -- 快速跳转
  {
    'ggandor/leap.nvim',
    config = function ()
      require('leap').add_default_mappings()
    end
  },

  -- sudo保存
  {
    'lambdalisue/suda.vim',
    config = function()
      vim.g.suda_smart_edit = 1
    end
  },

  {
    'ethanholz/nvim-lastplace',
    config = function()
      require'nvim-lastplace'.setup {
        lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
        lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
        lastplace_open_folds = true
      }
    end
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      require('config.plugins.neo-tree-nvim')
    end
  },

  -- Lua
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
      }
    end
  },

  -- 下划线
  {
    "yamatsum/nvim-cursorline",
    config = function ()
      require('nvim-cursorline').setup {
        cursorline = {
          enable = false,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        }
      }
    end
  },

  {
    "hrsh7th/vim-eft",
    config = function ()
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
    end
  },

  -- 自动匹配括号
  {
    'windwp/nvim-autopairs',
    config = function ()
        require('nvim-autopairs').setup{}
    end
  },

  -- 模糊搜索
  {
      "nvim-telescope/telescope.nvim",
      config = function()
        require('config.plugins.telescope')
      end
  },

  -- 成对编辑
  'tpope/vim-surround',

  -- 终端
  {
    "akinsho/toggleterm.nvim",
    event = "BufRead",
    config = function ()
      require('config.plugins.toggleterm')
    end
  },

  -- markdown
  {
    'iamcco/markdown-preview.nvim',
    ft = "markdown",
    build = function()
      vim.call('mkdp#util#install')
    end,
    config = function ()
      require('config.plugins.markdown-preview')
    end
  },

  -- 菜单
  {
    'gelguy/wilder.nvim',
    event = "CmdlineEnter",
    config = function ()
      require('config.plugins.wilder')
    end
  },

  -- 窗口选择
  {
    -- only needed if you want to use the commands with "_with_window_picker" suffix
    's1n7ax/nvim-window-picker',
    config = function()
      require('config.plugins.nvim-window-picker')
    end,
  }
}
