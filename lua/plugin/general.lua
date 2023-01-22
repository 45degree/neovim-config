---@diagnostic disable: undefined-global

return function(use)

  use {
    'folke/which-key.nvim',
    config = function ()
      require("which-key").setup {
      }

      local chooseWin = function ()
        local picker = require('window-picker');
        local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end

      local wk = require("which-key")
      wk.register({
        f = {
          name = "+文件", -- optional group name
          s = {"<cmd>w<cr>", "保存当前文件"},
          S = {"<cmd>wa<cr>", "保存所有文件"},
          c = {"<cmd>e $MYVIMRC<cr>", "打开vim配置文件"},
        },
        s = {
          name = '+Search',
          f = {"<cmd>Telescope find_files<cr>", "文件夹内查找文件"},
          a = {"<cmd>Telescope live_grep<cr>", "文件夹内查找文件内容"},
          g = {"<cmd>Telescope git_files<cr>", "git项目内查找文件"},
          c = {"<cmd>Telescope colorscheme<cr>", "改变颜色"},
          h = {"<cmd>Telescope oldfiles<cr>", "查看历史"},
          p = {"<cmd>Telescope projects<cr>", "打开项目"},
          m = {"<cmd>Telescope marks<cr>", "Mark 查找"},
          b = {"<cmd>Telescope buffers<cr>", "查找所有buffer"},
          r = {"<cmd>lua require('spectre').open()<cr>", "查找并替换"}
        },
        c = {
          name = "+代码",
          ['2'] = {
            name = "+markdown",
            p = {"<Plug>MarkdownPreview", "markdown预览"},
            s = {"<Plug>MarkdownPreviewStop", "markdown停止预览"}
          },
          g = {
            name = '+git',
            c = { "<cmd>Gitsigns preview_hunk<cr>", "显示Git当前行更改"},
            N = { "<cmd>Gitsigns prev_hunk<cr>", "跳转到Git上一个更改处"},
            n = { "<cmd>Gitsigns next_hunk<cr>", "跳转到Git下一个更改处"},
            p = { "<cmd>DiffviewOpen<cr>", "显示Git项目更改" },
            h = { "<cmd>DiffviewFileHistory<cr>", "显示当前文件历史更改" },
          },
          t = {"<cmd>Lspsaga outline<cr>", '打开代码大纲'},
          T = {"<cmd>Trouble<cr>", '打开代码诊断'},
          d = {
            name = '+debug',
            c = {require 'dap'.terminate, '关闭调试'},
          },
          D = {require('neogen').generate, "生成代码文档注释" },
        },
        t = {'<cmd>Neotree toggle<cr>', "打开文件树"},
        w = {
          name = "+窗口",
          c = {chooseWin, '选择窗口'},
          d = {'<C-W>c', '删除当前窗口'},
          w = {'<C-W>w', '移动到其他窗口'},
          h = {'<C-W>h', '移动到左边窗口'},
          j = {'<C-W>j', '移动到下边窗口'},
          l = {'<C-W>l', '移动到右边窗口'},
          k = {'<C-W>k', '移动到上边窗口'},
          H = {'<C-W>5<', '窗口向左扩展'},
          J = {'<cmd>resize +5<cr>', '窗口向下扩展'},
          L = {'<C-W>5>', '窗口向右扩展'},
          K = {'<cmd>resize -5<cr>', '窗口向上扩展'},
          ['='] = {'<C-W>=', '平衡调整窗口'},
          s = {'<C-W>s', '上下分屏'},
          v = {'<C-W>v', '左右分屏'},
        },
        b = {
          name = '+Buffer',
          d = {
            name = '+delete',
            ['r'] = { '<cmd>BufferCloseBuffersLeft<cr>', '删除所有右边Buffer'},
            ['l'] = { '<cmd>BufferCloseBuffersRight<cr>',  '删除所有左边Buffer'},
            ['p'] = {'<cmd>BufferCloseAllButPinned<cr>', '删除所有未固定Buffer'},
            ['cp'] = {'<cmd>BufferCloseAllButCurrentOrPinned<cr>', '删除所有未固定和非当前Buffer'},
            ['c'] = { '<cmd>BufferCloseAllButCurrent<cr>', '只保留当前buffer'},
            ['v'] = { '<cmd>BufferCloseAllButVisible<cr>', '只保留可见buffer'}
          },
          ['p'] = { '<cmd>BufferPin<cr>', '固定Buffer'},
          ['j'] = { '<cmd>BufferPick<cr>', 'Buffer跳转'},
          ['1'] = { '<cmd>BufferGoto 1<cr>', '移动到buffer1' },
          ['2'] = { '<cmd>BufferGoto 2<cr>', '移动到buffer2' },
          ['3'] = { '<cmd>BufferGoto 3<cr>', '移动到buffer3' },
          ['4'] = { '<cmd>BufferGoto 4<cr>', '移动到buffer4' },
          ['5'] = { '<cmd>BufferGoto 5<cr>', '移动到buffer5' },
          ['6'] = { '<cmd>BufferGoto 6<cr>', '移动到buffer6' },
          ['7'] = { '<cmd>BufferGoto 7<cr>', '移动到buffer7' },
          ['8'] = { '<cmd>BufferGoto 8<cr>', '移动到buffer8' }
        }
      }, { prefix = "<space>" })
    end
  }

  -- 快速跳转
  use {
    'ggandor/leap.nvim',
    config = function ()
      require('leap').add_default_mappings()
    end
  }

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
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})

      require("neo-tree").setup({
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil , -- use a custom function for sorting files and directories in the tree 
        source_selector = {
          winbar = true,
          statusline = false
        },
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = false,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "",
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "",-- this can only be used in the git_status source
              renamed   = "",-- this can only be used in the git_status source
              -- Status type
              untracked = "★",
              ignored   = "",
              unstaged  = "✗",
              staged    = "✓",
              conflict  = "",
            }
          },
        },
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<2-LeftMouse>"] = "open_with_window_picker",
            ["<cr>"] = "open_with_window_picker",
            ["a"] = {
              "add",
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none" -- "none", "relative", "absolute"
              }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = {
             "copy",
             config = {
               show_path = "absolute" -- "none", "relative", "absolute"
             }
            },
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = false,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta"
            },
            always_show = { -- remains visible even if other settings would normally hide it
              ".gitignore",
              ".gitmodules",
              ".gitkeep",
              ".vscode",
              ".xmake",
              ".clang-format",
              ".clang-tidy",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              ".DS_Store",
            },
          },
          follow_current_file = false, -- This will find and focus the file in the active buffer every
                                       -- time the current file is changed while the tree is open.
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                -- "open_current",  -- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
            }
          }
        },
        buffers = {
          follow_current_file = true, -- This will find and focus the file in the active buffer every
                                       -- time the current file is changed while the tree is open.
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
            }
          }
        }
      })

      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
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
    "yamatsum/nvim-cursorline",
    config = function ()
      require('nvim-cursorline').setup {
        cursorline = {
          enable = false,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        }
      }
    end
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

  -- 模糊搜索
  use {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("telescope").setup {
          defaults = {
            prompt_prefix = "   ",
            selection_caret = "> ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
               horizontal = {
                  prompt_position = "top",
                  preview_width = 0.55,
                  results_width = 0.8,
               },
               vertical = {
                  mirror = false,
               },
               width = 0.87,
               height = 0.80,
               preview_cutoff = 120,
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            file_ignore_patterns = { "node_modules" },
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            path_display = { "truncate" },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            use_less = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            mappings = {
               n = { ["q"] = require("telescope.actions").close },
            },
          },
        }
        require('telescope').load_extension('projects')
      end
  }

  -- 成对编辑
  use 'tpope/vim-surround'

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

  -- 菜单
  use {
    'gelguy/wilder.nvim',
    event = "CmdlineEnter",
    config = function ()
      local wilder = require('wilder')
      vim.call('wilder#setup', {modes = {':', '/', '?'}})
      wilder.set_option('renderer', wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
          highlights = {
            border = 'Normal', -- highlight to use for the border
          },
          highlighter = wilder.basic_highlighter(),
          -- 'single', 'double', 'rounded' or 'solid'
          -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
          border = 'rounded',
          max_height = '20%', -- to set a fixed height, set max_height to the same value
          reverse = 0
        })
      ))
    end
  }

  -- 窗口选择
  use {
    -- only needed if you want to use the commands with "_with_window_picker" suffix
    's1n7ax/nvim-window-picker',
    config = function()
      require'window-picker'.setup({
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'neo-tree', "neo-tree-popup", "notify", "quickfix", "Trouble" },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { 'terminal' },
          },
        },
        other_win_hl_color = '#e35e4f',
      })
    end,
  }
end
