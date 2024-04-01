local opts = {
  cursorline = {
    enable = false,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  },
}

return {
  'yamatsum/nvim-cursorline',
  event = 'VeryLazy',
  config = function()
    require('nvim-cursorline').setup(opts)
  end,
}
