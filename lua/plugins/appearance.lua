---@diagnostic disable: undefined-global

return {
  -- 颜色主题
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function ()
      require('config.colorTheme.gruvbox-material')
    end
  },

  {
    'sainnhe/edge',
    priority = 1000,
  },

  {
    'sainnhe/everforest',
    priority = 1000,
  },

  {
    'rmehri01/onenord.nvim',
    priority = 1000,
  },

  {
    'sainnhe/sonokai',
    priority = 1000,
  },

  {
    'glepnir/zephyr-nvim',
    priority = 1000,
  },

  {
    'olimorris/onedarkpro.nvim',
    priority = 1000,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    build = ":CatppuccinCompile",
    config = function ()
      require('config.colorTheme.catppuccin')
    end
  },

  {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_transparent = true
      vim.g.tokyonight_transparent_sidebar = true
      vim.g.tokyonight_lualine_bold = true
    end
  },

  -- 图标
  {
    'DaikyXendo/nvim-material-icon',
    dependences = {"kyazdani42/nvim-web-devicons"},
    config = function ()
      local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
      if not web_devicons_ok then
      	return
      end

      local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
      if not material_icon_ok then
      	return
      end

      web_devicons.setup({
      	override = material_icon.get_icons(),
      })

      require'nvim-material-icon'.setup {
        -- your personnal icons can go here (to override)
        -- you can specify color or cterm_color instead of specifying both of them
        -- DevIcon will be appended to `name`
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          }
        };
        -- globally enable different highlight colors per icon (default to true)
        -- if set to false all icons will have the default icon's color
        color_icons = true;
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true;
      }
    end
  },

  -- 开始面板
  {
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
  },

  -- 状态栏
  {
    'nvim-lualine/lualine.nvim',
    dependences = {'kyazdani42/nvim-web-devicons'},
    config = function ()
      require('config.plugins.lualine')
    end
  },

  -- tab栏
  {
    'romgrk/barbar.nvim',
    config = function ()
      require('config.plugins.barbar')
    end
  },

  -- 缩进线
  {
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
  },

  -- 提示
  {
    'rcarriga/nvim-notify',
    dependences = {"nvim-telescope/telescope.nvim"},
    config = function ()
      vim.notify = require("notify")
      require("telescope").load_extension("notify")
    end
  },

  -- 显示颜色
  {
    'NvChad/nvim-colorizer.lua',
    config = function ()
      require'colorizer'.setup()
    end
  }
}
