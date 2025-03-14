return {
  'rebelot/kanagawa.nvim',
  lazy = true,
  build = ':KanagawaCompile',
  opts = {
    compile = true, -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = { bold = true },
    keywordStyle = { italic = true, bold = true },
    statementStyle = { italic = true },
    typeStyle = {},
    transparent = false, -- do not set background color
    dimInactive = true, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = { -- add/modify theme and palette colors
      theme = { all = { ui = { bg_gutter = 'none' } } },
    },
    overrides = function(colors)
      local theme = colors.theme
      return {
        TelescopeTitle = { fg = theme.ui.special, bold = true },
        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        TelescopePromptTitle = { fg = theme.ui.bg_p1, bg = theme.ui.special },
        TelescopePreviewTitle = { fg = theme.ui.bg_p1, bg = theme.ui.special },
        TelescopeResultsTitle = { fg = theme.ui.special, bg = theme.ui.bg_m3 },
        BlinkCmpMenu = { fg = theme.ui.fg_dim },
        BlinkCmpMenuBorder = { fg = theme.ui.fg_dim, bg = 'NONE' },
      }
    end,
  },
}
