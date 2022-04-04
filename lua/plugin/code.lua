---@diagnostic disable: undefined-global

return function(use)

    -- 代码提纲
    use {
        'liuchengxu/vista.vim',
        config = function()
            vim.g.vista_default_executive = 'coc'
        end
    }

    -- 快速注释
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- 代码debug
    use 'puremourning/vimspector'

    -- todo comments
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {
        }
      end
    }

    -- 代码高亮
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require'nvim-treesitter.configs'.setup {
              ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
              sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
              -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
              ignore_install = {}, -- List of parsers to ignore installing
              highlight = {
                enable = true,              -- false will disable the whole extension
                -- disable = { "c", "cpp", "rust" },  -- list of language that will be disabled
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
               },
              rainbow = {
                enable = true,
                -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil, -- Do not enable for files with more than n lines, int
                -- colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
              }
            }
        end
    }

    use {
        'p00f/nvim-ts-rainbow',
        after = "nvim-treesitter"
    }

    use {
        "andymass/vim-matchup",
        after = "nvim-treesitter",
        config = function ()
            vim.cmd [[let g:matchup_matchparen_offscreen = {'method': 'popup'}]]
        end
    }

    -- diff view
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        cmd = "DiffviewOpen",
        config = function()
            require 'diffview'.setup {
                diff_binaries = false,    -- Show diffs for binaries
                enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
                use_icons = true,         -- Requires nvim-web-devicons
                icons = {                 -- Only applies when use_icons is true.
                    folder_closed = "",
                    folder_open = "",
                },
                signs = {
                    fold_closed = "",
                    fold_open = "",
                },
                file_panel = {
                    position = "left",                  -- One of 'left', 'right', 'top', 'bottom'
                    width = 35,                         -- Only applies when position is 'left' or 'right'
                    height = 10,                        -- Only applies when position is 'top' or 'bottom'
                    listing_style = "tree",             -- One of 'list' or 'tree'
                    tree_options = {                    -- Only applies when listing_style is 'tree'
                      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
                      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
                    },
                },
                file_history_panel = {
                    position = "bottom",
                    width = 35,
                    height = 16,
                    log_options = {
                        max_count = 256,      -- Limit the number of commits
                        follow = false,       -- Follow renames (only for single file)
                        all = false,          -- Include all refs under 'refs/' including HEAD
                        merges = false,       -- List only merge commits
                        no_merges = false,    -- List no merge commits
                        reverse = false,      -- List commits in reverse order
                    },
                },
                default_args = {    -- Default args prepended to the arg-list for the listed commands
                    DiffviewOpen = {},
                    DiffviewFileHistory = {},
                },
                hooks = {}         -- See ':h diffview-config-hooks'
            }
        end
    }

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
                preset = 'codicons',

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
                  Operator = "",
                  TypeParameter = ""
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
end
