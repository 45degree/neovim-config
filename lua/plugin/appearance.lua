---@diagnostic disable: undefined-global

return function(use)
  -- 颜色主题
  use "rebelot/kanagawa.nvim"
  use 'ellisonleao/gruvbox.nvim'
  use 'sainnhe/edge'
  use 'sainnhe/everforest'
  use 'rmehri01/onenord.nvim'
  use 'sainnhe/sonokai'
  use 'glepnir/zephyr-nvim'
  use 'olimorris/onedarkpro.nvim'
  use {'kartikp10/noctis.nvim', requires = { 'rktjmp/lush.nvim' }}
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function ()
      require("catppuccin").setup()
    end
  }

  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_transparent = true
      vim.g.tokyonight_transparent_sidebar = true
      vim.g.tokyonight_lualine_bold = true
    end
  }

  -- 图标
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'

  -- 开始面板
  use {
    "goolord/alpha-nvim",
    config = function ()
      -- require'alpha'.setup(require'alpha.themes.dashboard'.config)
      local alpha = require'alpha'
      local dashboard = require'alpha.themes.dashboard'
      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }
      dashboard.section.buttons.val = {
        dashboard.button( "f", "  file", "<cmd>Telescope find_files <cr>"),
        dashboard.button( "p", "  project", "<cmd>Telescope projects<cr>"),
        dashboard.button( "h", "  History", "<cmd>Telescope oldfiles <cr>"),
        dashboard.button( "c", "  Color" , "<cmd>Telescope colorscheme <cr>"),
        dashboard.button( "m", "  marks" , "<cmd>Telescope marks <cr>"),
        dashboard.button( "w", "  word" , "<cmd>Telescope live_grep <cr>"),
      }
      alpha.setup(dashboard.config)
    end
  }

  -- 状态栏
  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function ()
      require('config.lualine')
    end
  }

  -- tab栏
  use {
    'romgrk/barbar.nvim',
    config = function ()
      require('config.barbar')
    end
  }

  -- 缩进线
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.list = true
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#666666 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#666666 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#666666 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#666666 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#666666 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=#666666 gui=nocombine]]

      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true,
        buftype_exclude = { "terminal", "nofile", "prompt"},
        filetype_exclude = { "dashboard", "coc-explorer", "NvimTree", "neo-tree"},
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
      }
    end
  }

  -- 提示
  use {
    'rcarriga/nvim-notify',
    config = function ()
      vim.notify = require("notify")
      require("telescope").load_extension("notify")
    end
  }

  -- 显示颜色
  use 'NvChad/nvim-colorizer.lua'

  -- 显示图片
  use 'samodostal/image.nvim'

  -- mark
  use {
    'chentoast/marks.nvim',
    config= function ()
      require'marks'.setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions. 
        -- higher values will have better performance but may cause visual lag, 
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {}
      }
    end
  }
end
