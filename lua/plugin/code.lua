return function(use)

    -- 代码格式化
    use {
        'sbdchd/neoformat',
        config = function()
            -- Doxygen高亮
            vim.api.nvim_exec([[
                augroup fmt
                  autocmd!
                  autocmd BufWritePre * undojoin | Neoformat
                augroup END
            ]], false)
        end
    }

    -- 代码提纲
    use {
        'liuchengxu/vista.vim',
        config = function()
            vim.g.vista_default_executive = 'coc'
        end
    }

    -- 快速注释
    use 'tpope/vim-commentary'

    -- 代码debug
    use 'puremourning/vimspector'

    -- 代码高亮
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            -- 彩虹括号
            'p00f/nvim-ts-rainbow'
        },
        config = function()
            require'nvim-treesitter.configs'.setup {
              ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
              sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
              -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
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


    -- 代码补全
    use { 'neoclide/coc.nvim', branch= 'release'}
end
