local default_icons = require('config.icon')

-- Set barbar's options
require('barbar').setup({
  -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
  hide = { extensions = false, inactive = false },
  icons = {
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = default_icons.diagnostic.error },
      [vim.diagnostic.severity.WARN] = { enabled = true, icon = default_icons.diagnostic.warn },
      [vim.diagnostic.severity.INFO] = { enabled = false, icon = default_icons.diagnostic.info },
      [vim.diagnostic.severity.HINT] = { enabled = false, icon = default_icons.diagnostic.hint },
    },
    gitsigns = {
      added = { enabled = false, icon = default_icons.gitsigns.added },
      changed = { enabled = false, icon = default_icons.gitsigns.modified },
      deleted = { enabled = false, icon = default_icons.gitsigns.deleted },
    },
    modified = { button = '' },
  },
})
