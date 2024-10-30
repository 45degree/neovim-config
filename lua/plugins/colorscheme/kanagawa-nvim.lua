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
  },
}
