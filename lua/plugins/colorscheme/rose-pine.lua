return {
  'rose-pine/neovim',
  lazy = true,
  name = 'rose-pine',
  opts = {
    dark_variant = 'moon', -- main, moon, or dawn
    dim_inactive_windows = true,
    extend_background_behind_borders = true,
    enable = {
      terminal = true,
      legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
      migrations = true, -- Handle deprecated options automatically
    },

    highlight_groups = {
      TelescopeBorder = { fg = 'overlay', bg = 'overlay' },
      TelescopeNormal = { fg = 'subtle', bg = 'overlay' },
      TelescopeSelection = { fg = 'text', bg = 'highlight_med' },
      TelescopeSelectionCaret = { fg = 'love', bg = 'highlight_med' },
      TelescopeMultiSelection = { fg = 'text', bg = 'highlight_high' },
      TelescopeTitle = { fg = 'base', bg = 'love' },
      TelescopePromptTitle = { fg = 'base', bg = 'pine' },
      TelescopePreviewTitle = { fg = 'base', bg = 'iris' },
      TelescopePromptNormal = { fg = 'text', bg = 'surface' },
      TelescopePromptBorder = { fg = 'surface', bg = 'surface' },
      NeoTreeTabSeparatorActive = { fg = 'overlay', bg = 'overlay' },
      NeoTreeTabSeparatorInactive = { fg = 'base', bg = 'base' },
      LspInlayHint = { fg = 'muted', bg = 'base' },
    },

    styles = {
      bold = true,
      italic = true,
      transparency = false,
    },
  },
}
