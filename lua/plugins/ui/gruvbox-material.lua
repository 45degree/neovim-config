return {
  'sainnhe/gruvbox-material',
  lazy = true,
  init = function()
    --  Set contrast.
    -- This configuration option should be placed before `colorscheme gruvbox-material`.
    --Available values: 'hard', 'medium'(default), 'soft'
    vim.g.gruvbox_material_background = 'hard'
    -- For better performance
    vim.g.gruvbox_material_better_performance = 1
  end,
}
