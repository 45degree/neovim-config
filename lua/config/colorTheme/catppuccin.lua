require('catppuccin').setup {
  flavour = 'frappe', -- latte, frappe, macchiato, mocha
  background = {
    -- :h background
    light = 'latte',
    dark = 'frappe',
  },
  compile_path = vim.fn.stdpath 'cache' .. '/catppuccin',
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
    loops = {},
    functions = {},
    keywords = {},
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
    dashboard = true,
    fern = false,
    fidget = true,
    gitgutter = false,
    gitsigns = true,
    harpoon = false,
    hop = false,
    illuminate = false,
    leap = false,
    lightspeed = false,
    lsp_saga = false,
    lsp_trouble = false,
    markdown = true,
    mason = true,
    mini = false,
    neogit = false,
    neotest = false,
    neotree = true,
    noice = false,
    notify = true,
    nvimtree = false,
    overseer = false,
    pounce = false,
    semantic_tokens = false,
    symbols_outline = false,
    telekasten = false,
    telescope = true,
    treesitter = true,
    treesitter_context = false,
    ts_rainbow = false,
    vim_sneak = false,
    vimwiki = false,
    which_key = false,
    -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
    dap = {
      enabled = true,
      enable_ui = true,
    },
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
    },
    navic = {
      enabled = false,
      custom_bg = 'NONE',
    },
  },
}
