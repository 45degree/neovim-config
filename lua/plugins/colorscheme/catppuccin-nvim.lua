return {
  'catppuccin/nvim',
  lazy = true,
  name = 'catppuccin',
  build = ':CatppuccinCompile',
  opts = {
    flavour = 'frappe', -- latte, frappe, macchiato, mocha
    background = {
      -- :h background
      light = 'latte',
      dark = 'frappe',
    },
    compile_path = vim.fn.stdpath('cache') .. '/catppuccin',
    term_colors = true,
    dim_inactive = { enabled = true },
    float = { solid = true, transparent = true },
    styles = {
      comments = { 'italic' },
      conditionals = { 'italic' },
      loops = { 'italic' },
      functions = { 'bold' },
      keywords = { 'italic', 'bold' },
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    custom_highlights = function(color)
      return {
        BufferCurrentWARN = { fg = color.yellow, bg = color.surface1 },
        BufferCurrentERROR = { fg = color.red, bg = color.surface1 },
        BufferCurrentINFO = { fg = color.sky, bg = color.surface1 },
        BufferCurrentHINT = { fg = color.teal, bg = color.surface1 },
      }
    end,
    color_overrides = {},
    auto_integrations = true,
    integrations = {
      dropbar = { color_mode = true },
      native_lsp = { inlay_hints = { background = false } },
    },
  },
}
