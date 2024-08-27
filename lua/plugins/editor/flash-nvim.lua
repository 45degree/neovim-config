return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  init = function()
    vim.keymap.set('n', 's', function() require('flash').jump() end, {})
  end,
  config = function() require('flash').setup({ modes = { char = { enabled = true, jump_labels = true } } }) end,
}
