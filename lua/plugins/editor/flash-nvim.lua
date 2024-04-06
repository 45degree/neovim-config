return {
  'folke/flash.nvim',
  lazy = true,
  init = function ()
    vim.api.nvim_set_keymap('n', 's', "<cmd>lua require('flash').jump()<cr>", {})
  end,
  config = function()
    require('flash').setup({
      modes = { char = { enabled = false } },
    })
    require('flash').toggle(false)
  end,
}
