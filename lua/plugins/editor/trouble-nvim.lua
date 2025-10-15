return {
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
  },

  {
    'folke/edgy.nvim',
    optional = true,
    opts = function(_, opts)
      opts.bottom = opts.bottom or {}
      table.insert(opts.bottom, { ft = 'trouble', title = 'Trouble' })
    end,
  },
}
