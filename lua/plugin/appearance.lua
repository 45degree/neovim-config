---@diagnostic disable: undefined-global

return function(use)
  -- 颜色主题
  use "rebelot/kanagawa.nvim"
  use {
    'sainnhe/gruvbox-material',
    config = function ()
      require('config.colorTheme.gruvbox-material')
    end
  }
  use 'sainnhe/edge'
  use 'sainnhe/everforest'
  use 'rmehri01/onenord.nvim'
  use 'sainnhe/sonokai'
  use 'glepnir/zephyr-nvim'
  use 'olimorris/onedarkpro.nvim'
  use {'kartikp10/noctis.nvim', requires = { 'rktjmp/lush.nvim' }}
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function ()
      require('config.colorTheme.catppuccin')
    end
  }

  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_transparent = true
      vim.g.tokyonight_transparent_sidebar = true
      vim.g.tokyonight_lualine_bold = true
    end
  }

  -- 图标
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'

  -- 开始面板
  use {
    "goolord/alpha-nvim",
    config = function ()
      -- require'alpha'.setup(require'alpha.themes.dashboard'.config)
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'
      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }
      dashboard.section.buttons.val = {
        dashboard.button( "f", "  file", "<cmd>Telescope find_files <cr>"),
        dashboard.button( "p", "  project", "<cmd>Telescope projects<cr>"),
        dashboard.button( "h", "  History", "<cmd>Telescope oldfiles <cr>"),
        dashboard.button( "c", "  Color" , "<cmd>Telescope colorscheme <cr>"),
        dashboard.button( "m", "  marks" , "<cmd>Telescope marks <cr>"),
        dashboard.button( "w", "  word" , "<cmd>Telescope live_grep <cr>"),
      }
      alpha.setup(dashboard.config)
    end
  }

  -- 状态栏
  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function ()
      require('config.lualine')
    end
  }

  -- tab栏
  use {
    'romgrk/barbar.nvim',
    config = function ()
      require('config.barbar')
    end
  }

  -- 缩进线
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.list = true
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#666666 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#666666 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#666666 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#666666 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#666666 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=#666666 gui=nocombine]]

      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true,
        buftype_exclude = { "terminal", "nofile", "prompt"},
        filetype_exclude = { "dashboard", "coc-explorer", "NvimTree", "neo-tree"},
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
      }
    end
  }

  -- 提示
  use {
    'rcarriga/nvim-notify',
    config = function ()
      vim.notify = require("notify")
      require("telescope").load_extension("notify")
    end
  }

  -- 显示颜色
  use {
    'NvChad/nvim-colorizer.lua',
    config = function ()
      require'colorizer'.setup()
    end
  }
end
