return {
  'echasnovski/mini.ai',
  version = '*',
  enabled = false,
  event = 'VeryLazy',
  config = function() require('mini.ai').setup() end,
}
