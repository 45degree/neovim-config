return {
  'folke/tokyonight.nvim',
  lazy = true,
  config = function()
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_lualine_bold = true

    require('tokyonight').setup({
      on_highlights = function(hl, c)
        hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
        hl.TelescopeBorder = { bg = c.bg_popup, fg = c.bg_popup }
        hl.TelescopePromptNormal = { bg = c.dark3 }
        hl.TelescopePromptBorder = { bg = c.dark3, fg = c.dark3 }
        hl.TelescopePromptTitle = { bg = c.green, fg = c.bg_dark }
        hl.TelescopePreviewTitle = { bg = c.orange, fg = c.bg_dark }
        hl.TelescopeResultsTitle = { bg = c.cyan, fg = c.bg_dark }
      end,
    })
  end,
}
