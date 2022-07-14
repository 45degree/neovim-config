---@diagnostic disable: undefined-global

return function(use)

  -- 代码补全
  use "neovim/nvim-lspconfig"
  use {
    "williamboman/nvim-lsp-installer",
    requires = {
      "ray-x/lsp_signature.nvim",
      "hrsh7th/cmp-nvim-lsp", --neovim 内置 LSP 客户端的 nvim-cmp 源
    },
    config = function()
      require('nvim-lsp-installer').setup{}
      require "lsp_signature".setup{}

      local lspinstaller = require('nvim-lsp-installer')
      local lspconfig = require('lspconfig')

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
      capabilities.offsetEncoding = 'utf-8'

      for _, server in ipairs(lspinstaller.get_installed_servers()) do
        local opts = {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            require "lsp_signature".on_attach({
              bind = true, -- This is mandatory, otherwise border config won't get registered.
              handler_opts = {
                border = "rounded"
              }
            }, bufnr)
          end,
        }
        if server.name == "clangd" then
          opts.cmd = {
            "clangd",
            "-header-insertion=never",
          }
        end
        lspconfig[server.name]:setup(opt)
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
    'tami5/lspsaga.nvim',
    after = "telescope.nvim",
    config = function ()
      local lspsaga = require 'lspsaga'
      lspsaga.setup { -- defaults ...
        debug = false,
        use_saga_diagnostic_sign = true,
        -- diagnostic sign
        error_sign = "",
        warn_sign = "",
        hint_sign = "",
        infor_sign = "",
        diagnostic_header_icon = "   ",
        -- code action title icon
        code_action_icon = " ",
        code_action_prompt = {
          enable = false,
          sign = true,
          sign_priority = 9,
          virtual_text = true,
        },
        finder_definition_icon = "  ",
        finder_reference_icon = "  ",
        max_preview_lines = 10,
        finder_action_keys = {
          open = "o",
          vsplit = "s",
          split = "i",
          quit = "q",
          scroll_down = "<C-f>",
          scroll_up = "<C-b>",
        },
        code_action_keys = {
          quit = "q",
          exec = "<CR>",
        },
        rename_action_keys = {
          quit = "<C-c>",
          exec = "<CR>",
        },
        definition_preview_icon = "  ",
        border_style = "single",
        rename_prompt_prefix = "➤",
        rename_output_qflist = {
          enable = false,
          auto_open_qflist = false,
        },
        server_filetype_map = {},
        diagnostic_prefix_format = "%d. ",
        diagnostic_message_format = "%m %c",
        highlight_prefix = false,
      }

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
          require("null-ls").builtins.diagnostics.cppcheck;
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
                -- local bufnr = vim.api.nvim_get_current_buf()
                local util = require 'vim.lsp.util'
                local params = util.make_formatting_params({})
                client.request('textDocument/formatting', params, nil, bufnr)
              end
            })
          end
        end,
      })
    end
  }

  -- 调用链
  use {
    'ldelossa/litee-calltree.nvim',
    requires = 'ldelossa/litee.nvim',
    config = function ()
      -- configure the litee.nvim library 
      require('litee.lib').setup({
        panel = {
            orientation = "bottom",
            panel_size  = 10
        },
      })
      -- configure litee-calltree.nvim
      require('litee.calltree').setup({
        -- NOTE: the plugin is in-progressing
        on_open = "pannel", -- pannel | popout
        hide_cursor = false,
        keymaps = {
          expand = "o",
          collapse = "zc",
          collapse_all = "zM",
          jump = "<CR>",
          jump_split = "s",
          jump_vsplit = "v",
          jump_tab = "t",
          hover = "i",
          details = "d",
          close = "q",
          close_panel_pop_out = "<C-c>",
          help = "?",
          hide = "H",
          switch = "S",
          focus = "f"
        },
      })
    end
  }
end
