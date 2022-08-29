---@diagnostic disable: undefined-global

return function(use)

  -- 代码提纲
  use {
    'liuchengxu/vista.vim',
    config = function()
      vim.g.vista_default_executive = 'nvim_lsp'
    end
  }

  -- 快速注释
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- 快速文档
  use {
    "danymat/neogen",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('neogen').setup {}
    end,
  }

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
      local ignoreLang = {}
      if vim.fn.has("WIN32") then
        table.insert(ignoreLang, "rnoweb")
      end

      require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
        -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
        ignore_install = ignoreLang, -- List of parsers to ignore installing
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

  -- 搜粟替换
  use 'nvim-pack/nvim-spectre'

  -- 格式化
  use 'editorconfig/editorconfig-vim'
end
