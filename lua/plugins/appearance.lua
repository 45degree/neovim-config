---@diagnostic disable: undefined-global

return {
  -- 颜色主题
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      if OptionConfig.getColorTheme() == 'gruvbox-material' then
        require('config.colorTheme.gruvbox-material')
        vim.cmd([[colorscheme gruvbox-material]])
      end
    end,
  },

  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      if OptionConfig.getColorTheme() == 'nordic' then
        vim.cmd([[colorscheme nordic]])
      end
    end,
  },

  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      if OptionConfig.getColorTheme() == 'bluloco' then
        -- your optional config goes here, see below.
        require('bluloco').setup({
          style = 'auto', -- "auto" | "dark" | "light"
          transparent = false,
          italics = false,
          terminal = vim.fn.has('gui_running') == 1, -- bluoco colors are enabled in gui terminals per default.
          guicursor = true,
        })

        vim.cmd([[colorscheme bluloco]])
      end
    end,
  },

  {
    'JoosepAlviste/palenightfall.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      if OptionConfig.getColorTheme() == 'palenightfall' then
        vim.cmd([[colorscheme palenightfall]])
      end
    end,
  },

  {
    'sainnhe/edge',
    lazy = false,
    priority = 1000,
    config = function()
      if OptionConfig.getColorTheme() == 'edge' then
        vim.cmd([[colorscheme edge]])
      end
    end,
  },

  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      if OptionConfig.getColorTheme() == 'everforest' then
        vim.cmd([[colorscheme everforest]])
      end
    end,
  },

  {
    'rmehri01/onenord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      if OptionConfig.getColorTheme() == 'onenord' then
        vim.cmd([[colorscheme onenord]])
      end
    end,
  },

  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      if OptionConfig.getColorTheme() == 'sonokai' then
        vim.cmd([[colorscheme sonokai]])
      end
    end,
  },

  {
    'glepnir/zephyr-nvim',
    lazy = false,
    priority = 1000,
    config = function()
      if OptionConfig.getColorTheme() == 'zephyr' then
        vim.cmd([[colorscheme zephyr]])
      end
    end,
  },

  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      if OptionConfig.getColorTheme() == 'onedarkpro' then
        vim.cmd([[colorscheme onedark]])
      end
    end,
  },

  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    build = ':CatppuccinCompile',
    config = function()
      local theme = OptionConfig.getColorTheme()
      if string.sub(theme, 1, string.len('catppuccin')) == 'catppuccin' then
        require('config.colorTheme.catppuccin')
        vim.cmd('colorscheme ' .. theme)
      end
    end,
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    config = function()
      if OptionConfig.getColorTheme() == 'tokyonight' then
        vim.g.tokyonight_transparent = true
        vim.g.tokyonight_transparent_sidebar = true
        vim.g.tokyonight_lualine_bold = true
        vim.cmd([[colorscheme tokyonight]])
      end
    end,
  },

  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    build = ':KanagawaCompile',
    config = function()
      local theme = OptionConfig.getColorTheme()
      if string.sub(theme, 1, string.len('kanagawa')) == 'kanagawa' then
        require('config.colorTheme.kanagawa')
        vim.cmd('colorscheme ' .. theme)
      end
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
      local theme = OptionConfig.getColorTheme()
      if theme == 'monokai-pro' then
        require('config.colorTheme.monokai-pro')
        vim.cmd('colorscheme ' .. theme)
      end
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
      local theme = OptionConfig.getColorTheme()
      if
        theme == 'nightfox'
        or theme == 'dayfox'
        or theme == 'dawnfox'
        or theme == 'duskfox'
        or theme == 'nordfox'
        or theme == 'terafox'
        or theme == 'carbonfox'
      then
        require('config.colorTheme.nightfox')
        vim.cmd('colorscheme ' .. theme)
      end
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
      local theme = OptionConfig.getColorTheme()
      if theme == 'hardhacker' then
        vim.cmd.colorscheme('hardhacker')
      end
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
        dashboard.button('h', '  History', '<cmd>Telescope oldfiles <cr>'),
        dashboard.button('c', '  Color', '<cmd>Telescope colorscheme <cr>'),
        dashboard.button('m', '  marks', '<cmd>Telescope marks <cr>'),
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
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('config.plugins.noice-nvim')
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
    enabled = function()
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
        ft_ignore = { 'neo-tree', 'toggleterm', 'Outline' },
        bt_ignore = { 'nofile', 'prompt' },
        segments = {
          { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
          { sign = { name = { '.*' }, maxwidth = 1 }, click = 'v:lua.ScSa' },
          { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
          { sign = { name = { 'GitSigns' }, maxwidth = 2, colwidth = 1 }, click = 'v:lua.ScSa' },
        },
      })
    end,
    enabled = function()
      return vim.fn.has('nvim-0.9') == 1
    end,
  },

  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    config = function()
      vim.opt.splitkeep = 'screen'
      require('config.plugins.edgy')
    end,
    enabled = true,
  },
}
