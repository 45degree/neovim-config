return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'nvim-telescope/telescope.nvim', -- optional
    'sindrets/diffview.nvim', -- optional
  },
  cmd = 'Neogit',
  config = function()
    require('neogit').setup({
      disable_hint = true,
      graph_style = 'unicode',
      kind = 'tab',
      integrations = {
        diffview = true,
      },
      sections = {
        stashes = {
          folded = false,
        },
        recent = {
          folded = false,
        },
      },
      signs = {
        hunk = { '', '' },
        item = { '', '' },
        section = { '', '' },
      },
    })
  end,
}
