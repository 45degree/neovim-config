return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  config = function()
    require('flash').setup({
      modes = { char = { enabled = false } },
    })
    require('flash').toggle(false)
    vim.api.nvim_set_keymap('n', 's', "<cmd>lua require('flash').jump()<cr>", {})
  end,
}
