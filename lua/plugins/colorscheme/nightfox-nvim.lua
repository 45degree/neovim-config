return {
  'EdenEast/nightfox.nvim',
  lazy = true,
  build = ':NightfoxCompile',
  opts = {
    groups = {
      all = {
        TelescopeBorder = { fg = 'palette.bg2', bg = 'palette.bg2' },
        TelescopePromptBorder = { fg = 'palette.bg3', bg = 'palette.bg3' },
        TelescopePromptNormal = { fg = 'palette.fg3', bg = 'palette.bg3' },
        TelescopePromptPrefix = { fg = 'palette.red', bg = 'palette.bg3' },
        TelescopeNormal = { bg = 'palette.bg2' },
        TelescopePreviewTitle = { fg = 'palette.sel0', bg = 'palette.orange' },
        TelescopePromptTitle = { fg = 'palette.sel0', bg = 'palette.green' },
        TelescopeResultsTitle = { fg = 'palette.sel0', bg = 'palette.cyan' },
        TelescopeMatching = { fg = 'diag.error' },
        NeoTreeTabActive = { fg = 'palette.fg3' },
        NeoTreeTabInactive = { fg = 'palette.fg1', bg = 'palette.bg0' },
        NeoTreeTabSeparatorInactive = { fg = 'palette.bg0', bg = 'palette.bg0' },
      },
    },
    options = {
      styles = {
        -- Style to be applied to different syntax groups
        comments = 'italic', -- Value is any valid attr-list value `:help attr-list`
        conditionals = 'italic',
        constants = 'NONE',
        functions = 'bold',
        keywords = 'bold,italic',
        numbers = 'NONE',
        operators = 'NONE',
        strings = 'NONE',
        types = 'NONE',
        variables = 'NONE',
      },
      modules = { -- List of various plugins and additional options
        alpha = true,
        barbar = true,
        cmp = true,
        dap_ui = true,
        diagnostic = {
          -- This is linked to so much that is needs to be enabled. This is here primarily
          -- for the extra options that can be added with modules
          enable = true,
          background = true,
        },
        gitsigns = true,
        indent_blankline = true,
        lazy = true,
        lsp_semantic_tokens = true,
        lsp_trouble = true,
        navic = true,
        native_lsp = {
          enable = true,
          background = true,
        },
        neogit = true,
        neotree = true,
        notify = true,
        symbol_outline = true,
        telescope = true,
        treesitter = true,
        whichkey = true,
      },
    },
  },
}
