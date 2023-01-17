---@diagnostic disable: undefined-global

return function(use)

  -- 代码补全
  use "neovim/nvim-lspconfig"
  use {
    "williamboman/mason.nvim",
    requires = {
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
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "SirVer/ultisnips",
      'quangnguyen30192/cmp-nvim-ultisnips',
      "hrsh7th/cmp-buffer", --从buffer中智能提示
      "hrsh7th/cmp-nvim-lua", --nvim-cmp source for neovim Lua API.
      "hrsh7th/cmp-path", --自动提示硬盘上的文件
    },
    config = function()
      local cmp = require 'cmp'
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

      cmp.setup ({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        enabled = function()
          return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
              or require("cmp_dap").is_dap_buffer()
        end,
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
           -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ['<C-y>'] = cmp.config.disable,
          ['<C-e>'] = cmp.mapping({
              i = cmp.mapping.abort(),
              c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Tab>'] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert}),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert}),
          ['<Up>'] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert}),
          ['<Down>'] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert}),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'ultisnips' },
        },
        {
          { name = 'buffer' },
          { name = 'path' },
          { name = 'nvim_lua' }
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local lspkind_icons = {
              Text = "",
              Method = "",
              Function = "",
              Constructor = "",
              Field = "",
              Variable = "",
              Class = "",
              Interface = "",
              Module = "",
              Property = "",
              Unit = "",
              Value = "",
              Enum = "",
              Keyword = "",
              Snippet = "",
              Color = "",
              File = "",
              Reference = "",
              Folder = "",
              EnumMember = "",
              Constant = "",
              Struct = "",
              Event = "",
              Operator = "",
              TypeParameter = "",
            }

            local menus = {
              -- cmp_tabnine = "[TN]",
              buffer = "[BUF]",
              orgmode = "[ORG]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[LUA]",
              path = "[PATH]",
              tmux = "[TMUX]",
              luasnip = "[SNIP]",
              utilsnips = "[SNIP]",
              spell = "[SPELL]",
            }

            local max_len = 20
            if string.len(vim_item.abbr) > max_len then
              vim_item.abbr = string.sub(vim_item.abbr, 1, max_len - 2) .. "··"
            end

            -- load lspkind icons
            vim_item.menu = string.format("%s %s", menus[entry.source.name], vim_item.kind);
            vim_item.kind = lspkind_icons[vim_item.kind]
            return vim_item
          end,
        }
      })
    end
  }

  -- 代码片段
  use 'honza/vim-snippets'

  use {
    "folke/trouble.nvim",
    after = "nvim-cmp",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
      }
    end
  }

  use {
    'folke/lsp-colors.nvim',
    after = "nvim-cmp",
    config = function()
      -- Lua
      require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981"
      })
    end
  }

  use {
    'glepnir/lspsaga.nvim',
    after = "telescope.nvim",
    config = function ()
      local saga = require("lspsaga")
      saga.setup({
        symbol_in_winbar = {
          enable = true,
          separator = ' > ',
          hide_keyword = true,
          show_file = true,
          folder_level = 2,
          respect_root = false,
          color_mode = false,
        },
        code_action = {
          num_shortcut = true,
          keys = {
            -- string |table type
            quit = 'q',
            exec = '<CR>',
          },
        },
        rename = {
          quit = 'q',
          exec = '<CR>',
          mark = 'x',
          confirm = '<CR>',
          in_select = true,
          whole_project = false,
        },
        ui = {
          -- currently only round theme
          theme = 'round',
          title = true,
          -- border type can be single,double,rounded,solid,shadow.
          border = 'single',
          winblend = 0,
          expand = '',
          collapse = '',
          preview = ' ',
          code_action = '💡',
          diagnostic = '🐞',
          incoming = ' ',
          outgoing = ' ',
          colors = {
            --float window normal background color
            normal_bg = 'NONE',
            --title background color
            title_bg = '#afd700',
          },
        }
      })

      vim.diagnostic.config{
        virtual_text = {
          prefix = '',
          sources = "always"
        },
        float = {
          sources = "always"
        },
        update_in_insert = false,
      }

      --- In lsp attach function
      local opts = { noremap=true, silent=true }
      vim.api.nvim_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions theme=dropdown<cr>', opts)
      vim.api.nvim_set_keymap('n', 'K',  '<cmd>Lspsaga hover_doc<cr>', opts)
      vim.api.nvim_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations theme=dropdown<cr>', opts)
      vim.api.nvim_set_keymap('n', 'gr', '<cmd>Telescope lsp_references theme=dropdown<cr>', opts)
      vim.api.nvim_set_keymap('n', 'rn', '<cmd>Lspsaga rename<cr>', opts)
      vim.api.nvim_set_keymap('n', 'ca', '<cmd>Lspsaga code_action<cr>', opts)
    end
  }

  use {
    'j-hui/fidget.nvim',
    config = function ()
      require("fidget").setup{}
    end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    after = "nvim-cmp",
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
  }
end
