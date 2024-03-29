return {
  -- 代码补全
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    config = function()
      local icons = require('config.icon')
      require('mason').setup({
        ui = {
          border = 'single',
          icons = {
            -- The list icon to use for installed packages.
            package_installed = icons.widgets.loaded,
            -- The list icon to use for packages that are installing, or queued for installation.
            package_pending = icons.widgets.on_load,
            -- The list icon to use for packages that are not installed.
            package_uninstalled = icons.widgets.not_loaded,
          },
        },
      })
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    -- event = 'VeryLazy',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'folke/neodev.nvim',
    },
    config = function()
      require('mason-lspconfig').setup()

      local lspinstaller = require('mason-lspconfig')
      local lspconfig = require('lspconfig')

      for _, server in ipairs(lspinstaller.get_installed_servers()) do
        local config = require('config.lsp.server-config')(server)
        lspconfig[server].setup(config)
      end

      require('config.lsp.config')
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer', --从buffer中智能提示
      'hrsh7th/cmp-nvim-lua', --nvim-cmp source for neovim Lua API.
      'hrsh7th/cmp-path', --自动提示硬盘上的文件
      'ray-x/lsp_signature.nvim',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/vscode-snippets' } })
      require('luasnip.loaders.from_snipmate').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
      require('config.plugins.nvim-cmp')
      require('lsp_signature').setup({ hint_prefix = '󰷼 ' })
    end,
  },

  {
    'hrsh7th/cmp-nvim-lsp', --neovim 内置 LSP 客户端的 nvim-cmp 源
    event = 'LspAttach',
  },

  -- ai 补全
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({ suggestion = { auto_trigger = true } })
    end,
  },

  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    dependencies = {
      'nvim-cmp',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('trouble').setup({})
    end,
  },

  {
    'folke/lsp-colors.nvim',
    event = 'LspAttach',
    dependencies = { 'nvim-cmp' },
    config = function()
      -- Lua
      require('lsp-colors').setup({
        Error = '#db4b4b',
        Warning = '#e0af68',
        Information = '#0db9d7',
        Hint = '#10B981',
      })
    end,
  },

  {
    'kosayoda/nvim-lightbulb',
    event = 'LspAttach',
    config = function()
      require('nvim-lightbulb').setup({
        autocmd = { enabled = true },
        virtual_text = {
          enabled = true,
          text = '',
        },
      })
    end,
  },

  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
      'nvim-cmp',
    },
    config = function()
      require('config.plugins.mason-null-ls')
    end,
  },

  -- 代码大纲
  {
    'simrat39/symbols-outline.nvim',
    event = 'LspAttach',
    config = function()
      require('config.plugins.symbol-outline')
    end,
  },

  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    event = 'LspAttach',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('config.plugins.barbecue')
    end,
  },
}
