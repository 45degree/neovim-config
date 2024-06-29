vim.diagnostic.config({
  virtual_text = {
    prefix = '',
    sources = 'always',
  },
  float = {
    sources = 'always',
  },
  update_in_insert = false,
})

local config = require('config')
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = config.border, max_height = 20 })

--- In lsp attach function
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions theme=dropdown<cr>', opts)
vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations theme=dropdown<cr>', opts)
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references theme=dropdown<cr>', opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, opts)
