return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  cond = require('config').ai == 'copilot',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('copilot').setup({
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
    })
  end,
}
