return {
  'romgrk/barbar.nvim',
  event = 'LazyFile',
  opts = {
    -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
    hide = { extensions = false, inactive = false },
    icons = {
      -- Enables / disables diagnostic symbols
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = require('icons').diagnostic.error },
        [vim.diagnostic.severity.WARN] = { enabled = true, icon = require('icons').diagnostic.warn },
        [vim.diagnostic.severity.INFO] = { enabled = false, icon = require('icons').diagnostic.info },
        [vim.diagnostic.severity.HINT] = { enabled = false, icon = require('icons').diagnostic.hint },
      },
      gitsigns = {
        added = { enabled = false, icon = require('icons').gitsigns.added },
        changed = { enabled = false, icon = require('icons').gitsigns.modified },
        deleted = { enabled = false, icon = require('icons').gitsigns.deleted },
      },
      modified = { button = '' },
      pinned = { button = '', filename = true },
    },
    auto_hide = 0,
    exclude_ft = { 'alpha', 'snacks_dashboard' },
  },
}
