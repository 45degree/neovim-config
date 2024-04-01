return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',         -- required
    'nvim-telescope/telescope.nvim', -- optional
    'sindrets/diffview.nvim',        -- optional
  },
  cmd = 'Neogit',
  config = function()
    require('neogit').setup({
      signs = {
        -- { CLOSED, OPENED }
        hunk = { '', '' },
        item = { '', '' },
        section = { '', '' },
      },
    })
  end,
}
