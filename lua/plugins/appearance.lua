---@diagnostic disable: undefined-global

return {
  -- 颜色主题
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      require 'config.colorTheme.gruvbox-material'
    end,
  },

  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function() end,
  },

  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      -- your optional config goes here, see below.
      require('bluloco').setup {
        style = 'auto', -- "auto" | "dark" | "light"
        transparent = false,
        italics = false,
        terminal = vim.fn.has 'gui_running' == 1, -- bluoco colors are enabled in gui terminals per default.
        guicursor = true,
      }

      vim.cmd [[colorscheme bluloco]]
    end,
  },

  {
    'JoosepAlviste/palenightfall.nvim',
    lazy = false,
    priority = 1000,
    config = function() end,
  },

  {
    'sainnhe/edge',
    lazy = false,
    priority = 1000,
    config = function() end,
  },

  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
  },

  {
    'rmehri01/onenord.nvim',
    lazy = false,
    priority = 1000,
  },

  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
  },

  {
    'glepnir/zephyr-nvim',
    lazy = false,
    priority = 1000,
  },

  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
  },

  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    build = ':CatppuccinCompile',
    config = function()
      require 'config.colorTheme.catppuccin'
    end,
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    config = function()
      vim.g.tokyonight_transparent = true
      vim.g.tokyonight_transparent_sidebar = true
      vim.g.tokyonight_lualine_bold = true
    end,
  },

  -- 图标
  {
    'DaikyXendo/nvim-material-icon',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      local web_devicons_ok, web_devicons = pcall(require, 'nvim-web-devicons')
      if not web_devicons_ok then
        return
      end

      local material_icon_ok, material_icon = pcall(require, 'nvim-material-icon')
      if not material_icon_ok then
        return
      end

      web_devicons.setup {
        override = material_icon.get_icons(),
      }

      require('nvim-material-icon').setup {
        -- your personnal icons can go here (to override)
        -- you can specify color or cterm_color instead of specifying both of them
        -- DevIcon will be appended to `name`
        override = {
          zsh = {
            icon = '',
            color = '#428850',
            cterm_color = '65',
            name = 'Zsh',
          },
        },
        -- globally enable different highlight colors per icon (default to true)
        -- if set to false all icons will have the default icon's color
        color_icons = true,
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true,
      }
    end,
  },

  -- 开始面板
  {
    'goolord/alpha-nvim',
    config = function()
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
        dashboard.button('f', '  file', '<cmd>Telescope find_files <cr>'),
        dashboard.button('p', '  project', '<cmd>Telescope projects<cr>'),
        dashboard.button('h', '  History', '<cmd>Telescope oldfiles <cr>'),
        dashboard.button('c', '  Color', '<cmd>Telescope colorscheme <cr>'),
        dashboard.button('m', '  marks', '<cmd>Telescope marks <cr>'),
        dashboard.button('w', '  word', '<cmd>Telescope live_grep <cr>'),
      }
      alpha.setup(dashboard.config)
    end,
  },

  -- 状态栏
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require 'config.plugins.lualine'
    end,
  },

  -- tab栏
  {
    'romgrk/barbar.nvim',
    config = function()
      require 'config.plugins.barbar'
    end,
  },

  -- 缩进线
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        show_current_context = true,
        show_current_context_start = true,
        buftype_exclude = { 'terminal', 'nofile', 'prompt' },
        filetype_exclude = { 'dashboard', 'coc-explorer', 'NvimTree', 'neo-tree' },
      }
    end,
  },

  -- 提示
  {
    'rcarriga/nvim-notify',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('notify').setup {
        background_colour = '#000000',
      }

      vim.notify = require 'notify'
      require('telescope').load_extension 'notify'
    end,
  },

  -- 显示颜色
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
}
