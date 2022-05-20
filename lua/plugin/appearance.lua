---@diagnostic disable: undefined-global

return function(use)
  -- 颜色主题
  use "rebelot/kanagawa.nvim"
  use 'ellisonleao/gruvbox.nvim'
  use 'sainnhe/edge'
  use 'folke/tokyonight.nvim'
  use 'sainnhe/everforest'
  use 'sainnhe/sonokai'

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

  use {
    "SmiteshP/nvim-gps",
    config = function ()
      -- Default config
      require("nvim-gps").setup()
    end
  }

  -- 状态栏
  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    after = "nvim-gps",
    config = function ()
      local gps = require("nvim-gps")
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {'NvimTree','vista','dbui','packer', 'coc-explorer'},
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename', { gps.get_location, cond = gps.is_available }},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      }
    end
  }

  -- tab栏
  use {
    'romgrk/barbar.nvim',
    config = function ()
      -- Set barbar's options
      vim.g.bufferline = {
        -- Enable/disable animations
        animation = true,

        -- Enable/disable auto-hiding the tab bar when there is a single buffer
        auto_hide = false,

        -- Enable/disable current/total tabpages indicator (top right corner)
        tabpages = true,

        -- Enable/disable close button
        closable = true,

        -- Enables/disable clickable tabs
        --  - left-click: go to buffer
        --  - middle-click: delete buffer
        clickable = true,

        -- Excludes buffers from the tabline
        exclude_ft = {'javascript'},
        exclude_name = {'package.json'},

        -- Enable/disable icons
        -- if set to 'numbers', will show buffer index in the tabline
        -- if set to 'both', will show buffer index and icons in the tabline
        icons = true,

        -- If set, the icon color will follow its corresponding buffer
        -- highlight group. By default, the Buffer*Icon group is linked to the
        -- Buffer* group (see Highlighting below). Otherwise, it will take its
        -- default value as defined by devicons.
        icon_custom_colors = false,

        -- Configure icons on the bufferline.
        icon_separator_active = '▎',
        icon_separator_inactive = '▎',
        icon_close_tab = '',
        icon_close_tab_modified = '●',
        icon_pinned = '車',

        -- If true, new buffers will be inserted at the start/end of the list.
        -- Default is to insert after current buffer.
        insert_at_end = false,
        insert_at_start = false,

        -- Sets the maximum padding width with which to surround each tab
        maximum_padding = 1,

        -- Sets the maximum buffer name length.
        maximum_length = 30,

        -- If set, the letters for each buffer in buffer-pick mode will be
        -- assigned based on their name. Otherwise or in case all letters are
        -- already assigned, the behavior is to assign letters in order of
        -- usability (see order below)
        semantic_letters = true,

        -- New buffer letters are assigned in this order. This order is
        -- optimal for the qwerty keyboard layout but might need adjustement
        -- for other layouts.
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

        -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
        -- where X is the buffer number. But only a static string is accepted here.
        no_name_title = nil,
      }
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
        filetype_exclude = { "dashboard", "coc-explorer", "NvimTree"},
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
end
