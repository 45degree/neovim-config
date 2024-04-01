return {
  'willothy/flatten.nvim',
  config = function()
    require('flatten').setup({
      nest_if_no_args = true,
      window = {
        open = 'alternate',
      },
    })
  end,
}
