return {
  -- 代码补全
   "neovim/nvim-lspconfig",

   {
     "williamboman/mason.nvim",
     lazy = false,
     dependences = {
       "williamboman/mason-lspconfig.nvim",
       "ray-x/lsp_signature.nvim",
       "hrsh7th/cmp-nvim-lsp", --neovim 内置 LSP 客户端的 nvim-cmp 源
     },
     config = function()
       require("mason").setup{}
       require("mason-lspconfig").setup()
       require "lsp_signature".setup{
         hint_prefix = " "
       }

       local lspinstaller = require('mason-lspconfig')
       local lspconfig = require('lspconfig')

       for _, server in ipairs(lspinstaller.get_installed_servers()) do
         local config = require('config.lsp')(server)
         lspconfig[server].setup(config)
       end
     end
  },

  {
    "hrsh7th/nvim-cmp",
    dependences = {
      "SirVer/ultisnips",
      'quangnguyen30192/cmp-nvim-ultisnips',
      "hrsh7th/cmp-buffer", --从buffer中智能提示
      "hrsh7th/cmp-nvim-lua", --nvim-cmp source for neovim Lua API.
      "hrsh7th/cmp-path", --自动提示硬盘上的文件
      "windwp/nvim-autopairs"
    },
    config = function()
      require('config.plugins.nvim-cmp')
    end
  },

  -- 代码片段
  'honza/vim-snippets',

  {
    "folke/trouble.nvim",
    dependences = {
      "nvim-cmp",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("trouble").setup {
      }
    end
  },

  {
    'folke/lsp-colors.nvim',
    dependences = { "nvim-cmp" },
    config = function()
      -- Lua
      require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981"
      })
    end
  },

  {
    'glepnir/lspsaga.nvim',
    dependences = {"telescope.nvim"},
    config = function ()
      require('config.plugins.lspsaga')
    end
  },

  {
    'j-hui/fidget.nvim',
    config = function ()
      require("fidget").setup{}
    end
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    dependences = {"nvim-cmp"},
    config = function ()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.clang_format.with({
            filetypes = { "c", "cpp" },
          }),
        },
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              -- on 0.8, you should use vim.lsp.buf.format instead
              callback = function ()
                vim.lsp.buf.format({ bufnr = bufnr })
              end
            })
          end
        end,
      })
    end
  },
}
