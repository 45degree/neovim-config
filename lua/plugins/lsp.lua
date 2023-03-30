return {
  -- 代码补全
  'neovim/nvim-lspconfig',

  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'ray-x/lsp_signature.nvim',
      'hrsh7th/cmp-nvim-lsp', --neovim 内置 LSP 客户端的 nvim-cmp 源
    },
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
      require('mason-lspconfig').setup()
      require('lsp_signature').setup({
        hint_prefix = ' ',
      })

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
    dependencies = {
      'SirVer/ultisnips',
      'quangnguyen30192/cmp-nvim-ultisnips',
      'hrsh7th/cmp-buffer', --从buffer中智能提示
      'hrsh7th/cmp-nvim-lua', --nvim-cmp source for neovim Lua API.
      'hrsh7th/cmp-path', --自动提示硬盘上的文件
      'windwp/nvim-autopairs',
    },
    config = function()
      require('config.plugins.nvim-cmp')
    end,
  },

  -- 代码片段
  'honza/vim-snippets',

  {
    'folke/trouble.nvim',
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
    'glepnir/lspsaga.nvim',
    dependencies = { 'telescope.nvim' },
    config = function()
      require('config.plugins.lspsaga')
    end,
  },

  {
    'j-hui/fidget.nvim',
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
}
