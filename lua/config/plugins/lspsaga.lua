local saga = require("lspsaga")
saga.setup({
  symbol_in_winbar = {
    enable = true,
    separator = " > ",
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
  rename = {
    quit = 'q',
    exec = '<CR>',
    mark = 'x',
    confirm = '<CR>',
    in_select = false,
  },
  ui = {
    -- Currently, only the round theme exists
    theme = "round",
    -- This option only works in Neovim 0.9
    title = true,
    -- Border type can be single, double, rounded, solid, shadow.
    border = "single",
    winblend = 0,
    expand = "",
    collapse = "",
    preview = " ",
    code_action = "💡",
    diagnostic = "🐞",
    incoming = " ",
    outgoing = " ",
    hover = ' ',
    kind = {},
  },
  diagnostic = {
    on_insert = false,
  },
})

vim.diagnostic.config{
  virtual_text = {
    prefix = '',
    sources = "always"
  },
  float = {
    sources = "always"
  },
  update_in_insert = false,
}

--- In lsp attach function
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions theme=dropdown<cr>', opts)
vim.api.nvim_set_keymap('n', 'K',  '<cmd>Lspsaga hover_doc<cr>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations theme=dropdown<cr>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>Telescope lsp_references theme=dropdown<cr>', opts)
vim.api.nvim_set_keymap('n', 'rn', '<cmd>Lspsaga rename<cr>', opts)
vim.api.nvim_set_keymap('n', 'ca', '<cmd>Lspsaga code_action<cr>', opts)
