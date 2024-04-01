local opts = {
  view = {
    default = {
      -- Config for changed files, and staged files in diff views.
      layout = 'diff2_horizontal',
      winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
    },
    merge_tool = {
      -- Config for conflicted files in diff views during a merge or rebase.
      layout = 'diff3_mixed',
      disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
      winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
    },
    file_history = {
      -- Config for changed files in file history views.
      layout = 'diff2_horizontal',
      winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
    },
  },
}

return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('diffview').setup(opts)
  end,
}
