local saga = require('lspsaga')
saga.setup({
  symbol_in_winbar = {
    enable = true,
    separator = ' > ',
    hide_keyword = true,
    show_file = true,
    folder_level = 2,
    respect_root = false,
    color_mode = true,
  },
  code_action = {
    num_shortcut = true,
    keys = {
      -- string |table type
      quit = 'q',
      exec = '<CR>',
    },
  },
  implement = {
    enable = false,
  },
  lightbulb = {
    sign = false,
  },
  ui = {
    -- Currently, only the round theme exists
    theme = 'round',
    -- This option only works in Neovim 0.9
    title = true,
    -- Border type can be single, double, rounded, solid, shadow.
    border = 'single',
    winblend = 0,
    expand = '',
    collapse = '',
    preview = ' ',
    code_action = '',
    diagnostic = '',
    incoming = '',
    outgoing = '',
    hover = ' ',
    kind = {},
  },
  diagnostic = {
    on_insert = false,
  },
  outline = {
    auto_preview = false,
  },
})
