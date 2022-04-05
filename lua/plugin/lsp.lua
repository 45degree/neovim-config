---@diagnostic disable: undefined-global

return function(use)

    -- 代码补全
    use "neovim/nvim-lspconfig"
    use {
        "williamboman/nvim-lsp-installer",
        requires = "ray-x/lsp_signature.nvim",
        config = function()
            require "lsp_signature".setup{}
            local lsp_installer = require("nvim-lsp-installer")
            lsp_installer.on_server_ready(function(server)
                local opts = {
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
            "hrsh7th/cmp-path", --自动提示硬盘上的文件
            "onsails/lspkind-nvim",
            "SirVer/ultisnips",
            'quangnguyen30192/cmp-nvim-ultisnips',
        },
        config = function()
            local lspkind = require('lspkind')
            local cmp = require 'cmp'
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
                    format = function(entry, vim_item)
                        local lspkind_icons = {
                            Text = "",
                            Method = "",
                            Function = "",
                            Constructor = "",
                            Field = "",
                            Variable = "",
                            Class = "ﴯ",
                            Interface = "",
                            Module = "",
                            Property = "ﰠ",
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

                        local max_len = 20
                        if string.len(vim_item.abbr) > max_len then
                          vim_item.abbr = string.sub(vim_item.abbr, 1, max_len - 2) .. "··"
                        end

                        -- load lspkind icons
                        vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)
                        vim_item.menu = ({
                            -- cmp_tabnine = "[TN]",
                            buffer = "[BUF]",
                                orgmode = "[ORG]",
                                nvim_lsp = "[LSP]",
                                nvim_lua = "[LUA]",
                                path = "[PATH]",
                                tmux = "[TMUX]",
                                luasnip = "[SNIP]",
                                spell = "[SPELL]",
                            })[entry.source.name]
                        return vim_item
                    end,

                    -- format = lspkind.cmp_format({
                    --   mode = 'symbol', -- show only symbol annotations
                    --   maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    --
                    --   -- The function below will be called before any actual modifications from lspkind
                    --   -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    --   before = function (entry, vim_item)
                    --     return vim_item
                    --   end
                    -- })
                }
            })
        end
    }

    -- use {
    --     config = function()
    --         require('lspkind').init({
    --             -- DEPRECATED (use mode instead): enables text annotations
    --             --
    --             -- default: true
    --             -- with_text = true,
    --
    --             -- defines how annotations are shown
    --             -- default: symbol
    --             -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    --             mode = 'symbol',
    --
    --             -- default symbol map
    --             -- can be either 'default' (requires nerd-fonts font) or
    --             -- 'codicons' for codicon preset (requires vscode-codicons font)
    --             --
    --             -- default: 'default'
    --             preset = 'codicons',
    --
    --             -- override preset symbols
    --             --
    --             -- default: {}
    --             symbol_map = {
    --               Text = "",
    --               Method = "",
    --               Function = "",
    --               Constructor = "",
    --               Field = "ﰠ",
    --               Variable = "",
    --               Class = "ﴯ",
    --               Interface = "",
    --               Module = "",
    --               Property = "ﰠ",
    --               Unit = "塞",
    --               Value = "",
    --               Enum = "",
    --               Keyword = "",
    --               Snippet = "",
    --               Color = "",
    --               File = "",
    --               Reference = "",
    --               Folder = "",
    --               EnumMember = "",
    --               Constant = "",
    --               Struct = "פּ",
    --               Event = "",
    --               Operator = "",
    --               TypeParameter = ""
    --             },
    --         })
    --     end
    -- }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
        }
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

    use {
        'tami5/lspsaga.nvim',
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
                  enable = true,
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

            --- In lsp attach function
            local opts = { noremap=true, silent=true }
            vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'K',  '<cmd>Lspsaga hover_doc<cr>', opts)
            vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            vim.api.nvim_set_keymap('n', 'rn', '<cmd>Lspsaga rename<cr>', opts)
            vim.api.nvim_set_keymap('n', 'ca', '<cmd>Lspsaga code_action<cr>', opts)
        end
    }

end
