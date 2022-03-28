return function(use)

    use 'liuchengxu/vim-which-key'

    -- sudo保存
    use {
        'lambdalisue/suda.vim',
        config = function()
            vim.g.suda_smart_edit = 1
        end
    }

    -- 启动速度
    use {
        "dstein64/vim-startuptime",
        cmd = "StartupTime"
    }

    -- 下划线
    use {
        "itchyny/vim-cursorword",
        event = {"BufReadPre", "BufNewFile"}
    }

    use {
        "hrsh7th/vim-eft",
        config = function ()
            vim.api.nvim_set_keymap('n', ';', '<Plug>(eft-repeat)', {})
            vim.api.nvim_set_keymap('x', ';', '<Plug>(eft-repeat)', {})
            vim.api.nvim_set_keymap('o', ';', '<Plug>(eft-repeat)', {})

            vim.api.nvim_set_keymap('n', 'f', '<Plug>(eft-f)', {})
            vim.api.nvim_set_keymap('x', 'f', '<Plug>(eft-f)', {})
            vim.api.nvim_set_keymap('o', 'f', '<Plug>(eft-f)', {})

            vim.api.nvim_set_keymap('n', 'F', '<Plug>(eft-F)', {})
            vim.api.nvim_set_keymap('x', 'F', '<Plug>(eft-F)', {})
            vim.api.nvim_set_keymap('o', 'F', '<Plug>(eft-F)', {})

            vim.api.nvim_set_keymap('n', 't', '<Plug>(eft-t)', {})
            vim.api.nvim_set_keymap('x', 't', '<Plug>(eft-t)', {})
            vim.api.nvim_set_keymap('o', 't', '<Plug>(eft-t)', {})

            vim.api.nvim_set_keymap('n', 'T', '<Plug>(eft-T)', {})
            vim.api.nvim_set_keymap('x', 'T', '<Plug>(eft-T)', {})
            vim.api.nvim_set_keymap('o', 'T', '<Plug>(eft-T)', {})
        end
    }

    -- 自动匹配括号
    use 'jiangmiao/auto-pairs'

    -- jk加速
    use {
      'rhysd/accelerated-jk',
      config = function()
          vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
          vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
      end
    }

    -- 模糊搜索
    use {
        'liuchengxu/vim-clap',
        run = function()
            vim.call('clap#installer#download_binary')
        end,
        config = function()
            vim.g.clap_theme = 'material_design_dark'
        end
    }

    -- 成对编辑
    use 'tpope/vim-surround'

    -- 快速选中
    use 'gcmt/wildfire.vim'

    -- 终端
    -- use 'skywind3000/vim-terminal-help'
    use {
        "akinsho/toggleterm.nvim",
        opt = true,
        event = "BufRead",
        config = function ()
            require("toggleterm").setup {
                -- size can be a number or function which is passed the current terminal
                size = function(term)
                    if term.direction == "horizontal" then
                        return 15
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.40
                    end
                end,
                open_mapping = [[<M-=>]],
                hide_numbers = true, -- hide the number column in toggleterm buffers
                shade_filetypes = {},
                shade_terminals = false,
                shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
                start_in_insert = true,
                insert_mappings = true, -- whether or not the open mapping applies in insert mode
                persist_size = true,
                direction = "horizontal",
                close_on_exit = true, -- close the terminal window when the process exits
                shell = vim.o.shell -- change the default shell
            }
        end
    }

    -- markdown
    use {
        'iamcco/markdown-preview.nvim',
        ft = "markdown",
        run = function()
            vim.call('mkdp#util#install')
        end
    }

    -- 翻译
    use {
        'voldikss/vim-translator',
        config = function()
          vim.g.translator_default_engines = {'haici', 'bing'}
        end
    }

    -- 菜单
    use {
        'gelguy/wilder.nvim',
        event = "CmdlineEnter",
        config = function ()
            vim.call('wilder#setup', {modes = {':', '/', '?'}})
        end
    }

    -- 窗口选择
    use 't9md/vim-choosewin'

end
