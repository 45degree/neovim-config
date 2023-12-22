---@diagnostic disable: undefined-global, missing-fields

return {
  -- 颜色主题
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      if GLOBAL_CONFIG.colorscheme == 'gruvbox-material' then
        require('config.colorTheme.gruvbox-material')
        vim.cmd([[colorscheme gruvbox-material]])
      end
    end,
  },

  {
    'sainnhe/edge',
    lazy = false,
    priority = 1000,
    config = function()
      if GLOBAL_CONFIG.colorscheme == 'edge' then
        vim.cmd([[colorscheme edge]])
      end
    end,
  },

  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    name = 'catppuccin',
    build = ':CatppuccinCompile',
    config = function()
      local theme = GLOBAL_CONFIG.colorscheme
      if string.sub(theme, 1, string.len('catppuccin')) == 'catppuccin' then
        require('config.colorTheme.catppuccin')
        vim.cmd('colorscheme ' .. theme)
      end
    end,
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      if GLOBAL_CONFIG.colorscheme == 'tokyonight' then
        vim.g.tokyonight_transparent = true
        vim.g.tokyonight_transparent_sidebar = true
        vim.g.tokyonight_lualine_bold = true
        vim.cmd([[colorscheme tokyonight]])
      end
    end,
  },

  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    build = ':NightfoxCompile',
    config = function()
      local theme = GLOBAL_CONFIG.colorscheme
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

  -- 图标
  {
    'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    config = function()
      local web_devicons_ok, web_devicons = pcall(require, 'nvim-web-devicons')
      if not web_devicons_ok then
        return
      end
      web_devicons.setup({
        override_by_extension = {
          ['template'] = {
            icon = '󰘓',
            color = '#3b484e',
            name = 'Template',
          },
        },
      })
    end,
  },

  -- 开始面板
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'AlphaReady',
          callback = function()
            require('lazy').show()
          end,
        })
      end

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
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = '󱐋 Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- 状态栏
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    config = function()
      require('config.plugins.lualine')
    end,
  },

  -- tab栏
  {
    'romgrk/barbar.nvim',
    event = 'VeryLazy',
    config = function()
      require('config.plugins.barbar')
    end,
  },

  -- 缩进线
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('ibl').setup({
        indent = { char = '│' },
        exclude = {
          filetypes = { 'neo-tree', 'alpha', 'help', 'lazy', 'mason', 'Neogit*' },
          buftypes = { 'terminal', 'nofile', 'prompt' },
        },
        scope = { enabled = false },
      })
    end,
  },

  {
    'echasnovski/mini.indentscope',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'help', 'alpha', 'neo-tree', 'Trouble', 'lazy', 'mason', 'notify', 'toggleterm', 'Neogit*' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function()
      require('mini.indentscope').setup({
        symbol = '│',
        options = { try_as_border = true },
        draw = {
          animation = require('mini.indentscope').gen_animation.none(),
        },
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
    event = 'VeryLazy',
    config = function()
      require('colorizer').setup({})
    end,
  },

  -- 代码折叠
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    -- event = 'VeryLazy',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      })

      -- disable fold in this file
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { '\\[dap-repl\\]', 'DAP *', 'dapui_*', 'alpha', 'Neogit*', 'Outline' },
        callback = function()
          require('ufo').detach()
          vim.opt_local.foldenable = false
        end,
      })
    end,
    enabled = function()
      return vim.fn.has('nvim-0.9') == 1
    end,
  },

  {
    'luukvbaal/statuscol.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = 'kevinhwang91/nvim-ufo',
    config = function()
      local builtin = require('statuscol.builtin')
      require('statuscol').setup({
        relculright = true,
        ft_ignore = { 'neo-tree', 'toggleterm', 'Outline', 'alpha' },
        bt_ignore = { 'nofile', 'prompt' },
        segments = {
          { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
          { sign = { name = { '.*' }, maxwidth = 1 }, click = 'v:lua.ScSa' },
          { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
          { sign = { namespace = { 'gitsign*' }, maxwidth = 2, colwidth = 1 }, click = 'v:lua.ScSa' },
        },
      })
    end,
    enabled = function()
      return vim.fn.has('nvim-0.9') == 1
    end,
  },

  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    config = function()
      require('dressing').setup({
        input = { enabled = true },
        select = {
          -- Set to false to disable the vim.ui.select implementation
          enabled = true,

          -- Priority list of preferred vim.select implementations
          backend = { 'telescope', 'builtin', 'nui' },
        },
      })
    end,
  },

  {
    'equalsraf/neovim-gui-shim',
    cond = function()
      if vim.fn.has('gui_running') ~= 1 then
        return false
      end
      return true
    end,
  },
}
