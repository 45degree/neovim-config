return {
  'folke/tokyonight.nvim',
  lazy = true,
  priority = 1000,
  config = function()
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_lualine_bold = true

    require('tokyonight').setup({})
  end,
}
