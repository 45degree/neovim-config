---@diagnostic disable: undefined-global

return {
  -- 颜色主题
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    cond = function()
      return OptionConfig.getColorTheme() == 'gruvbox-material'
    end,
    config = function()
      require('config.colorTheme.gruvbox-material')
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },

  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    cond = function()
      return OptionConfig.getColorTheme() == 'nordic'
    end,
    config = function()
      vim.cmd([[colorscheme nordic]])
    end,
  },

  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    cond = function()
      return OptionConfig.getColorTheme() == 'bluloco'
    end,
    config = function()
      -- your optional config goes here, see below.
      require('bluloco').setup({
        style = 'auto', -- "auto" | "dark" | "light"
        transparent = false,
        italics = false,
        terminal = vim.fn.has('gui_running') == 1, -- bluoco colors are enabled in gui terminals per default.
        guicursor = true,
      })

      vim.cmd([[colorscheme bluloco]])
    end,
  },

  {
    'JoosepAlviste/palenightfall.nvim',
    lazy = false,
    priority = 1000,
    cond = function()
      return OptionConfig.getColorTheme() == 'palenightfall'
    end,
    config = function()
      vim.cmd([[colorscheme palenightfall]])
    end,
  },

  {
    'sainnhe/edge',
    lazy = false,
    cond = function()
      return OptionConfig.getColorTheme() == 'edge'
    end,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme edge]])
    end,
  },

  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    cond = function()
      return OptionConfig.getColorTheme() == 'everforest'
    end,
    config = function()
      vim.cmd([[colorscheme everforest]])
    end,
  },

  {
    'rmehri01/onenord.nvim',
    lazy = false,
    priority = 1000,
    cond = function()
      return OptionConfig.getColorTheme() == 'onenord'
    end,
    config = function()
      vim.cmd([[colorscheme onenord]])
    end,
  },

  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    cond = function()
      return OptionConfig.getColorTheme() == 'sonokai'
    end,
    config = function()
      vim.cmd([[colorscheme sonokai]])
    end,
  },

  {
    'glepnir/zephyr-nvim',
    lazy = false,
    priority = 1000,
    cond = function()
      return OptionConfig.getColorTheme() == 'zephyr'
    end,
    config = function()
      vim.cmd([[colorscheme zephyr]])
    end,
  },

  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
    cond = function()
      return OptionConfig.getColorTheme() == 'onedarkpro'
    end,
    config = function()
      vim.cmd([[colorscheme onedark]])
    end,
  },

  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    build = ':CatppuccinCompile',
    cond = function()
      local theme = OptionConfig.getColorTheme()
      return theme == 'catppuccin-latte'
        or theme == 'catppuccin-frappe'
        or theme == ' catppuccin-macchiato'
        or theme == 'catppuccin-mocha'
        or theme == 'catppuccin'
    end,
    config = function()
      require('config.colorTheme.catppuccin')
      local theme = OptionConfig.getColorTheme()
      vim.cmd('colorscheme ' .. theme)
    end,
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    cond = function()
      return OptionConfig.getColorTheme() == 'tokyonight'
    end,
    config = function()
      vim.g.tokyonight_transparent = true
      vim.g.tokyonight_transparent_sidebar = true
      vim.g.tokyonight_lualine_bold = true
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    cond = function()
      local theme = OptionConfig.getColorTheme()
      return theme == 'kanagawa' or theme == 'kanagawa-dragon' or theme == 'kanagawa-lotus' or theme == 'kanagawa-wave'
    end,
    build = ':KanagawaCompile',
    config = function()
      require('config.colorTheme.kanagawa')
      local theme = OptionConfig.getColorTheme()
      vim.cmd('colorscheme ' .. theme)
    end,
  },

  {
    'loctvl842/monokai-pro.nvim',
    lazy = false,
    cond = function()
      local theme = OptionConfig.getColorTheme()
      return theme == 'monokai-pro'
    end,
    config = function()
      require('config.colorTheme.monokai-pro')
      local theme = OptionConfig.getColorTheme()
      vim.cmd('colorscheme ' .. theme)
    end,
  },

  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    cond = function()
      local theme = OptionConfig.getColorTheme()
      return theme == 'nightfox'
        or theme == 'dayfox'
        or theme == 'dawnfox'
        or theme == 'duskfox'
        or theme == 'nordfox'
        or theme == 'terafox'
        or theme == 'carbonfox'
    end,
    config = function()
      require('config.colorTheme.nightfox')
      local theme = OptionConfig.getColorTheme()
      vim.cmd('colorscheme ' .. theme)
    end,
  },

  -- init.lua:
  {
    'hardhackerlabs/theme-vim',
    name = 'hardhacker',
    lazy = false,
    cond = function()
      local theme = OptionConfig.getColorTheme()
      return theme == 'hardhacker'
    end,
    config = function()
      vim.cmd.colorscheme('hardhacker')
    end,
  },

  -- 图标
  {
    'kyazdani42/nvim-web-devicons',
    event = 'BufEnter',
    config = function()
      local web_devicons_ok, web_devicons = pcall(require, 'nvim-web-devicons')
      if not web_devicons_ok then
        return
      end
      web_devicons.setup({})
    end,
  },

  -- 开始面板
  {
    'goolord/alpha-nvim',
    config = function()
      -- require'alpha'.setup(require'alpha.themes.dashboard'.config)
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
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
    event = 'BufEnter',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('config.plugins.lualine')
    end,
  },

  -- tab栏
  {
    'romgrk/barbar.nvim',
    event = 'BufEnter',
    config = function()
      require('config.plugins.barbar')
    end,
  },

  -- 缩进线
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    config = function()
      require('indent_blankline').setup({
        show_current_context = true,
        show_current_context_start = true,
        buftype_exclude = { 'terminal', 'nofile', 'prompt' },
        filetype_exclude = { 'dashboard', 'coc-explorer', 'NvimTree', 'neo-tree' },
      })
    end,
  },

  -- 提示
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    config = function()
      require('notify').setup({})
      vim.notify = require('notify')
    end,
  },

  -- command line
  {
    'gelguy/wilder.nvim',
    event = 'CmdlineEnter',
    build = ':UpdateRemotePlugins',
    config = function()
      require('config.plugins.wilder')
    end,
  },

  -- 显示颜色
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufEnter',
    config = function()
      require('colorizer').setup()
    end,
  },

  -- 代码折叠
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'BufEnter',
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      require('ufo').setup({})
    end,
    enable = function()
      return vim.fn.has('nvim-0.9') == 1
    end,
  },

  {
    'luukvbaal/statuscol.nvim',
    event = 'BufEnter',
    after = 'kevinhwang91/nvim-ufo',
    config = function()
      local builtin = require('statuscol.builtin')
      require('statuscol').setup({
        relculright = true,
        ft_ignore = { 'neo-tree', 'toggleterm' },
        bt_ignore = { 'nofile', 'prompt' },
        segments = {
          { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
          { sign = { name = { '.*' }, maxwidth = 1 }, click = 'v:lua.ScSa' },
          { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
          { sign = { name = { 'GitSigns' }, maxwidth = 2, colwidth = 1 }, click = 'v:lua.ScSa' },
        },
      })
    end,
    enable = function()
      return vim.fn.has('nvim-0.9') == 1
    end,
  },
}
