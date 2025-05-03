return {
  'echasnovski/mini.icons',
  lazy = true,
  opts = {
    default = { file = { glyph = '' } },
    file = { ['.clang-format'] = { glyph = '' }, ['.clang-tidy'] = { glyph = '' } },
    extension = {
      h = { glyph = '󰠩', hl = 'MiniIconsPurple' },
      hpp = { glyph = '󰜖', hl = 'MiniIconsPurple' },
      nu = { glyph = '>', hl = 'MiniIconsGreen' },
      slang = { glyph = '󰸱', hl = 'MiniIconsAzure' },
      hlsl = { glyph = '󰸱', hl = 'MiniIconsBlue' },
      glsl = { glyph = '󰸱', hl = 'MiniIconsGreen' },
      hx = { glyph = '', hl = 'MiniIconsOrange' },
    },
  },
  init = function()
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
}
