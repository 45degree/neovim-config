return {
  'echasnovski/mini.icons',
  lazy = true,
  opts = {
    default = { file = { glyph = '' } },
    file = { ['.clang-format'] = { glyph = '' }, ['.clang-tidy'] = { glyph = '' } },
    extension = {
      h = { glyph = '󰠩', hl = 'MiniIconsPurple' },
      hpp = { glyph = '󰜖', hl = 'MiniIconsPurple' },
      nu = { glyph = '>', hl = 'MiniIconsGreen' },
    },
  },
  init = function()
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
}
