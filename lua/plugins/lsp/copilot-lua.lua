return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    cond = require('config').ai == 'copilot',
    dependencies = {
      { 'CopilotC-Nvim/CopilotChat.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
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
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    cond = require('config').ai == 'copilot',
    lazy = true,
    config = function() require('CopilotChat').setup({}) end,
  },
}
