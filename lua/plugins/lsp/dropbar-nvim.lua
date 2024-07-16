local icons = require('icons')

return {
  'Bekaboo/dropbar.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = function()
    require('dropbar').setup({
      icons = { kinds = { symbols = icons.kind_with_space } },
    })
  end,
}
