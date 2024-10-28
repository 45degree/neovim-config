return {
  'folke/tokyonight.nvim',
  lazy = true,
  config = function()
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_lualine_bold = true

    require('tokyonight').setup({})
  end,
}
