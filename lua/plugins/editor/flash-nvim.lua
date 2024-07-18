return {
  'folke/flash.nvim',
  lazy = true,
  init = function()
    vim.keymap.set('n', 's', function() require('flash').jump() end, {})
  end,
  config = function()
    require('flash').setup({
      modes = { char = { enabled = false } },
    })
    require('flash').toggle(false)
  end,
}
