return {
  'nvim-mini/mini.cursorword',
  version = '*',
  event = 'VeryLazy',
  config = function() require('mini.cursorword').setup() end,
}
