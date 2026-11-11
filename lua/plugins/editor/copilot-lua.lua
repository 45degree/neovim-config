return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  cond = require('config').edit_prediction_provider.name == 'copilot',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    suggestion = {
      auto_trigger = true,
      hide_during_completion = true,
      keymap = {
        accept = '<M-l>',
        accept_word = false,
        accept_line = false,
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
    },
  },
}
