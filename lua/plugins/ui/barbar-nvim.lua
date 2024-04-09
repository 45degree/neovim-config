local icons = require("icons")
local opts = {
  -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
  hide = { extensions = false, inactive = false },
  icons = {
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = icons.diagnostic.error },
      [vim.diagnostic.severity.WARN] = { enabled = true, icon = icons.diagnostic.warn },
      [vim.diagnostic.severity.INFO] = { enabled = false, icon = icons.diagnostic.info },
      [vim.diagnostic.severity.HINT] = { enabled = false, icon = icons.diagnostic.hint },
    },
    gitsigns = {
      added = { enabled = false, icon = icons.gitsigns.added },
      changed = { enabled = false, icon = icons.gitsigns.modified },
      deleted = { enabled = false, icon = icons.gitsigns.deleted },
    },
    modified = { button = '' },
    pinned = { button = '', filename = true },
  },
}

return {
  'romgrk/barbar.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('barbar').setup(opts)
  end,
}
