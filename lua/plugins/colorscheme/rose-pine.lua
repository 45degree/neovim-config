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
  },
}