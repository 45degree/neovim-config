return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  cond = require('config').ai == 'copilot',
  config = function()
    require('copilot').setup({
      suggestion = {
        auto_trigger = false,
        hide_during_completion = false,
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
