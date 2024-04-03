return {
  'stevearc/overseer.nvim',
  cmd = { 'OverseerBuild', 'OverseerRun', 'OverseerToggle' },
  config = function()
    require('overseer').setup({
      -- strategy = 'toggleterm',
      task_list = { direction = 'bottom' },
      default_vscode = {
        'default',
        { 'on_result_diagnostics_quickfix', set_empty_results = true },
      },
    })
  end,
}
