---@diagnostic disable: undefined-global

return function(use)

    -- 代码补全
    use {
        "neovim/nvim-lspconfig",
        config = function ()
            local opts = { noremap=true, silent=true }
            vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        end
    }
    use {
        "williamboman/nvim-lsp-installer",
        config = function()
            local lsp_installer = require("nvim-lsp-installer")
            -- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
            -- or if the server is already installed).
            lsp_installer.on_server_ready(function(server)
                local opts = {}
                if server.name == "clangd" then
                    opts.cmd = {
                        "clangd",
                        "--clang-tidy",
                        "-header-insertion=never",
                    }
                end

                server:setup(opts)
            end)
        end
    }

    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp", --neovim 内置 LSP 客户端的 nvim-cmp 源
            "hrsh7th/cmp-buffer", --从buffer中智能提示
            "hrsh7th/cmp-nvim-lua", --nvim-cmp source for neovim Lua API.
            "octaltree/cmp-look", --用于完成英语单词
            "hrsh7th/cmp-path", --自动提示硬盘上的文件
            "hrsh7th/cmp-calc", --输入数学算式（如1+1=）自动计算
            "f3fora/cmp-spell", --nvim-cmp 的拼写源基于 vim 的拼写建议
            "hrsh7th/cmp-emoji", --输入: 可以显示表情
            "L3MON4D3/LuaSnip",
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local lspkind = require('lspkind')
            local cmp = require 'cmp'
            cmp.setup ({
                snippet = {
                  -- REQUIRED - you must specify a snippet engine
                  expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                },
                {
                    { name = 'buffer' },
                }),
                formatting = {
                  format = lspkind.cmp_format({
                    mode = 'symbol_text', -- show only symbol annotations
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    before = function (entry, vim_item)
                      return vim_item
                    end
                  })
                }
            })
        end
    }

    use {
        "onsails/lspkind-nvim",
        config = function()
            require('lspkind').init({
                -- DEPRECATED (use mode instead): enables text annotations
                --
                -- default: true
                -- with_text = true,

                -- defines how annotations are shown
                -- default: symbol
                -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
                mode = 'symbol_text',

                -- default symbol map
                -- can be either 'default' (requires nerd-fonts font) or
                -- 'codicons' for codicon preset (requires vscode-codicons font)
                --
                -- default: 'default'
                preset = 'default',

                -- override preset symbols
                --
                -- default: {}
                symbol_map = {
                  Text = "",
                  Method = "",
                  Function = "",
                  Constructor = "",
                  Field = "ﰠ",
                  Variable = "",
                  Class = "ﴯ",
                  Interface = "",
                  Module = "",
                  Property = "ﰠ",
                  Unit = "塞",
                  Value = "",
                  Enum = "",
                  Keyword = "",
                  Snippet = "",
                  Color = "",
                  File = "",
                  Reference = "",
                  Folder = "",
                  EnumMember = "",
                  Constant = "",
                  Struct = "פּ",
                  Event = "",
                  Operator = "",
                  TypeParameter = ""
                },
            })
        end
    }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
        vim.cmd [[
            sign define DiagnosticSignError text= linehl= texthl=DiagnosticSignError numhl=
            sign define DiagnosticSignWarn text= linehl= texthl=DiagnosticSignWarn numhl=
            sign define DiagnosticSignInfo text= linehl= texthl=DiagnosticSignInfo numhl=
            sign define DiagnosticSignHint text=💡 linehl= texthl=DiagnosticSignHint numhl=
        ]]
        local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
        for type, icon in pairs(signs) do
          local hl = "LspDiagnosticsSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end
        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            -- This sets the spacing and the prefix, obviously.
            virtual_text = {
              spacing = 4,
              prefix = ''
            }
          }
        )
      end
    }

    use {
        'folke/lsp-colors.nvim',
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

end
