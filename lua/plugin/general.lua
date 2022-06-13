---@diagnostic disable: undefined-global

return function(use)

  use {
    'folke/which-key.nvim',
    config = function ()
      require("which-key").setup {
      }

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
          t = {"<cmd>Vista!!<cr>", '打开代码大纲'},
          T = {"<cmd>Trouble<cr>", '打开代码诊断'},
          d = {
            name = '+debug',
            g = { require('config.vimspectorTemplate').GenTemplate, "生成调试模板"},
            s = {'<Plug>VimspectorBalloonEval', '显示变量值'},
            c = {'<cmd>VimspectorReset<cr>', '关闭调试'}
          },
          D = {"<cmd>DogeGenerate<cr>", "生成代码文档注释" },
        },
        t = {'<cmd>NvimTreeToggle<cr>', "打开文件树"},
        w = {
          name = "+窗口",
          c = {'<Plug>(choosewin)', '选择窗口'},
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
            ['c']= { '<cmd>BufferCloseAllButCurrent<cr>', '删除所有未显示Buffer'},
            ['p']= { '<cmd>BufferCloseAllButPinned<cr>',  '删除所有未固定Buffer'},
          },
          ['p'] = { '<cmd>BufferPin<cr>',    '固定Buffer'},
          ['j'] = { '<cmd>BufferPick<cr>',   'Buffer跳转'},
          ['1'] = { '<cmd>BufferGoto 1<cr>', '移动到buffer1' },
          ['2'] = { '<cmd>BufferGoto 2<cr>', '移动到buffer2' },
          ['3'] = { '<cmd>BufferGoto 3<cr>', '移动到buffer3' },
          ['4'] = { '<cmd>BufferGoto 4<cr>', '移动到buffer4' },
          ['5'] = { '<cmd>BufferGoto 5<cr>', '移动到buffer5' },
          ['6'] = { '<cmd>BufferGoto 6<cr>', '移动到buffer6' },
          ['7'] = { '<cmd>BufferGoto 7<cr>', '移动到buffer7' },
          ['8'] = { '<cmd>BufferGoto 8<cr>', '移动到buffer8' }
        }
      }, { prefix = "<leader>" })
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
    "kyazdani42/nvim-tree.lua",
    after = "project.nvim",
    config = function ()
      require'nvim-tree'.setup {
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = true
        },
        auto_reload_on_write = true,
        disable_netrw = false,
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
        renderer = {
          add_trailing = false,
          group_empty = false,
          highlight_git = true,
          highlight_opened_files = "none",
          root_folder_modifier = ":~",
          indent_markers = {
            enable = false,
            icons = {
              corner = "└ ",
              edge = "│ ",
              none = "  ",
            },
          },
          icons = {
            webdev_colors = true,
            git_placement = "signcolumn",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
          special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" }
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
          ignore = false,
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
  use 't9md/vim-choosewin'

  -- 局部配哦
  use {
    "klen/nvim-config-local",
    config = function()
      require('config-local').setup {
        -- Default configuration (optional)
        config_files = { ".vimrc.lua", ".vimrc" },  -- Config file patterns to load (lua supported)
        hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
        autocommands_create = true,                 -- Create autocommands (VimEnter, DirectoryChanged)
        commands_create = true,                     -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
        silent = false,                             -- Disable plugin messages (Config loaded/ignored)
        lookup_parents = false,                     -- Lookup config files in parent directories
      }
    end
  }

end
