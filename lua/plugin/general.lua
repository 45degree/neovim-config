---@diagnostic disable: undefined-global

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

    use {
        "kyazdani42/nvim-tree.lua",
        after = "project.nvim",
        config = function ()
            vim.g.nvim_tree_indent_markers = 0
            vim.g.nvim_tree_git_hl = 1
            vim.g.nvim_tree_highlight_opened_files = 0
            vim.g.nvim_tree_root_folder_modifier = ':~'
            vim.g.nvim_tree_add_trailing = 0
            vim.g.nvim_tree_group_empty = 0
            vim.g.nvim_tree_icon_padding = ' '
            vim.g.nvim_tree_symlink_arrow = '➛ '
            vim.g.nvim_tree_respect_buf_cwd = 0
            vim.g.nvim_tree_create_in_closed_folder = 0
            vim.g.nvim_tree_special_files = {
                ["Cargo.toml"] = true,
                Makefile = true,
                ["README.md"] = true,
                ["readme.md"] = true,
            }
            vim.g.nvim_tree_show_icons = { git = 1, folders = 1, files = 1, folder_arrows = 1 }
            vim.g.nvim_tree_icons = {
                default = "",
                symlink = "",
                git = {
                   unstaged = "",
                   staged = "",
                   unmerged =  "",
                   renamed = "",
                   untracked = "",
                   deleted = "",
                   ignored = ""
                },
                folder = {
                   arrow_open = "",
                   arrow_closed = "",
                   default = "",
                   open = "",
                   empty = "",
                   empty_open = "",
                   symlink = "",
                   symlink_open ="",
                }
            }
            require'nvim-tree'.setup {
                update_cwd = true,
                update_focused_file = {
                  enable = true,
                  update_cwd = true
                },
                auto_reload_on_write = true,
                disable_netrw = false,
                hide_root_folder = false,
                hijack_cursor = false,
                hijack_netrw = true,
                hijack_unnamed_buffer_when_opening = false,
                ignore_buffer_on_setup = false,
                open_on_setup = false,
                open_on_setup_file = false,
                open_on_tab = false,
                sort_by = "name",
                view = {
                  width = 40,
                  height = 30,
                  side = "left",
                  preserve_window_proportions = false,
                  number = false,
                  relativenumber = false,
                  signcolumn = "yes",
                  mappings = {
                    custom_only = false,
                    list = {
                      -- user mappings go here
                        { key = {"<CR>", "<2-LeftMouse>"},      action = "edit" },
                        { key = "<C-e>",                        action = "" },
                        { key = {"O"},                          action = "" },
                        { key = {"<2-RightMouse>", "<C-]>"},    action = "" },
                        { key = "<C-v>",                        action = "" },
                        { key = "<C-x>",                        action = "" },
                        { key = "<C-t>",                        action = "" },
                        { key = "<",                            action = "" },
                        { key = ">",                            action = "" },
                        { key = "P",                            action = "" },
                        { key = "<BS>",                         action = "parent_node" },
                        { key = "<Tab>",                        action = "" },
                        { key = "K",                            action = "" },
                        { key = "J",                            action = "" },
                        { key = "I",                            action = "" },
                        { key = ".",                            action = "toggle_dotfiles" },
                        { key = "R",                            action = "refresh" },
                        { key = "a",                            action = "create" },
                        { key = "d",                            action = "" },
                        { key = "D",                            action = "trash" },
                        { key = "r",                            action = "rename" },
                        { key = "<C-r>",                        action = "" },
                        { key = "dd",                           action = "cut" },
                        { key = "yy",                           action = "copy" },
                        { key = "p",                            action = "paste" },
                        { key = "yn",                           action = "copy_name" },
                        { key = "yp",                           action = "copy_path" },
                        { key = "gy",                           action = "copy_absolute_path" },
                        { key = "[c",                           action = "" },
                        { key = "]c",                           action = "" },
                        { key = "-",                            action = "" },
                        { key = "s",                            action = "" },
                        { key = "q",                            action = "" },
                        { key = "g?",                           action = "" },
                        { key = "W",                            action = "" },
                        { key = "S",                            action = "" },
                        { key = "K",                            action = "toggle_file_info" },
                        { key = "H",                            action = "" }
                    },
                  },
                },
                hijack_directories = {
                  enable = true,
                  auto_open = true,
                },
                ignore_ft_on_setup = {},
                system_open = {
                  cmd = nil,
                  args = {},
                },
                diagnostics = {
                  enable = false,
                  show_on_dirs = false,
                  icons = {
                    hint = "",
                    info = "",
                    warning = "",
                    error = "",
                  },
                },
                filters = {
                  dotfiles = true,
                  custom = {},
                  exclude = {},
                },
                git = {
                  enable = true,
                  ignore = true,
                  timeout = 400,
                },
                actions = {
                  change_dir = {
                    enable = true,
                    global = false,
                  },
                  open_file = {
                    quit_on_open = false,
                    resize_window = false,
                    window_picker = {
                      enable = true,
                      chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                      exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                      },
                    },
                  },
                },
                trash = {
                  cmd = "trash",
                  require_confirm = true,
                },
                log = {
                  enable = false,
                  truncate = false,
                  types = {
                    all = false,
                    config = false,
                    copy_paste = false,
                    git = false,
                    profile = false,
                  },
                },
            }
        end
    }

    -- Lua
    use {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
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
    use {
        'windwp/nvim-autopairs',
        config = function ()
            require('nvim-autopairs').setup{}
        end
    }

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
    use {
        "akinsho/toggleterm.nvim",
        opt = true,
        event = "BufRead",
        config = function ()
            require("toggleterm").setup {
                -- size can be a number or function which is passed the current terminal
                size = function(term)
                    if term.direction == "horizontal" then
                        return 10
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
