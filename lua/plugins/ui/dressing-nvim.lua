return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  config = function()
    require('dressing').setup({
      input = {
        enabled = true,
        insert_only = false,
        win_options = {
          winhighlight = 'FloatBorder:Normal',
        },
      },
      select = {
        -- Set to false to disable the vim.ui.select implementation
        enabled = true,

        -- Priority list of preferred vim.select implementations
        backend = { 'telescope', 'builtin', 'nui' },
      },
    })
  end,
}
