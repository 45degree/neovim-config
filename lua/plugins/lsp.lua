return {
  -- 代码补全
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            -- The list icon to use for installed packages.
            package_installed = ' ',
            -- The list icon to use for packages that are installing, or queued for installation.
            package_pending = ' ',
            -- The list icon to use for packages that are not installed.
            package_uninstalled = ' ',
          },
        },
      })
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
    },
    config = function()
      require('mason-lspconfig').setup()

      local lspinstaller = require('mason-lspconfig')
      local lspconfig = require('lspconfig')

      for _, server in ipairs(lspinstaller.get_installed_servers()) do
        local config = require('config.lsp')(server)
        lspconfig[server].setup(config)
      end
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'LspAttach',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer', --从buffer中智能提示
      'hrsh7th/cmp-nvim-lua', --nvim-cmp source for neovim Lua API.
      'hrsh7th/cmp-path', --自动提示硬盘上的文件
      'windwp/nvim-autopairs',
      'hrsh7th/cmp-nvim-lsp', --neovim 内置 LSP 客户端的 nvim-cmp 源
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/vscode-snippets' } })
      require('luasnip.loaders.from_snipmate').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
      require('config.plugins.nvim-cmp')
    end,
  },

  {
    'folke/trouble.nvim',
    event = 'LspAttach',
    dependencies = {
      'nvim-cmp',
      'kyazdani42/nvim-web-devicons',
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
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    dependencies = { 'telescope.nvim' },
    config = function()
      require('config.plugins.lspsaga')
    end,
  },

  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    config = function()
      require('fidget').setup({})
    end,
  },

  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'nvim-cmp',
    },
    config = function()
      require('config.plugins.mason-null-ls')
    end,
  },

  {
    'zbirenbaum/neodim',
    event = { 'LspAttach' },
    config = function()
      require('neodim').setup({
        alpha = 0.75,
        blend_color = '#000000',
        update_in_insert = {
          enable = true,
          delay = 100,
        },
        hide = {
          virtual_text = true,
          signs = true,
          underline = true,
        },
      })
    end,
  },

  {
    'VidocqH/lsp-lens.nvim',
    config = function()
      require('lsp-lens').setup({
        enable = true,
        include_declaration = false, -- Reference include declaration
        sections = {
          -- Enable / Disable specific request
          definition = false,
          references = true,
          implementation = true,
        },
        ignore_filetype = {
          'prisma',
        },
      })
    end,
  },
}
