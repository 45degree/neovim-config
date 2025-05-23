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
    transparent_background = false,
    term_colors = true,
    dim_inactive = {
      enabled = true,
      shade = 'dark',
      percentage = 0.15,
    },
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
    color_overrides = {},
    custom_highlights = function(color)
      return {
        BufferCurrentWARN = { fg = color.yellow, bg = color.surface1 },
        BufferCurrentERROR = { fg = color.red, bg = color.surface1 },
        BufferCurrentINFO = { fg = color.sky, bg = color.surface1 },
        BufferCurrentHINT = { fg = color.teal, bg = color.surface1 },
      }
    end,
    integrations = {
      barbar = true,
      blink_cmp = true,
      dashboard = true,
      diffview = true,
      dropbar = { enabled = true, color_mode = true },
      gitsigns = true,
      grug_far = true,
      markdown = true,
      mason = true,
      mini = { enabled = true },
      neotest = true,
      neotree = true,
      snacks = { enabled = true },
      noice = true,
      notify = true,
      overseer = true,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = { enabled = true, style = 'nvchad' },
      treesitter = true,
      which_key = true,
      window_picker = true,
      dap = true,
      dap_ui = true,
      native_lsp = {
        enabled = true,
        inlay_hints = { background = false },
      },
    },
  },
}
