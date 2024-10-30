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
    custom_highlights = {},
    integrations = {
      aerial = false,
      barbar = true,
      beacon = false,
      cmp = true,
      coc_nvim = false,
      dashboard = false,
      diffview = true,
      dropbar = { enabled = true, color_mode = true },
      fern = false,
      fidget = false,
      gitgutter = false,
      gitsigns = true,
      harpoon = false,
      hop = false,
      illuminate = true,
      leap = false,
      lightspeed = false,
      lsp_saga = false,
      lsp_trouble = false,
      markdown = true,
      mason = true,
      mini = { enabled = true },
      neogit = false,
      neotest = false,
      neotree = true,
      noice = true,
      notify = true,
      nvimtree = false,
      overseer = true,
      pounce = false,
      semantic_tokens = true,
      symbols_outline = true,
      telekasten = false,
      telescope = { enabled = true },
      treesitter = true,
      treesitter_context = false,
      ts_rainbow = false,
      vim_sneak = false,
      vimwiki = false,
      which_key = true,
      window_picker = true,
      -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
      dap = true,
      dap_ui = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      native_lsp = {
        enabled = true,
        inlay_hints = { background = false },
      },
    },
  },
}