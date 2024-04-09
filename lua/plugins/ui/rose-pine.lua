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

    styles = {
      bold = true,
      italic = true,
      transparency = false,
    },

    groups = {
      border = 'muted',
      link = 'iris',
      panel = 'surface',

      error = 'love',
      hint = 'iris',
      info = 'foam',
      note = 'pine',
      todo = 'rose',
      warn = 'gold',

      git_add = 'foam',
      git_change = 'rose',
      git_delete = 'love',
      git_dirty = 'rose',
      git_ignore = 'muted',
      git_merge = 'iris',
      git_rename = 'pine',
      git_stage = 'iris',
      git_text = 'rose',
      git_untracked = 'subtle',

      h1 = 'iris',
      h2 = 'foam',
      h3 = 'rose',
      h4 = 'gold',
      h5 = 'pine',
      h6 = 'foam',
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
    },
  },
}
