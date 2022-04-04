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
end
