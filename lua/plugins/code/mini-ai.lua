return {
  'echasnovski/mini.ai',
  version = '*',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('mini.ai').setup()
  end,
}
