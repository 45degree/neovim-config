return {
  'folke/sidekick.nvim',
  lazy = true,
  enabled = false,
  keys = {
    { '<leader>aa', function() require('sidekick.cli').send({ msg = '{this}' }) end, desc = 'Ask sidekick', mode = { 'n', 'v' } },
    { '<leader>at', function() require('sidekick.cli').toggle() end, desc = 'Toggle sidekick', mode = { 'n', 'v' } },
    { '<leader>ac', function() require('sidekick.cli').prompt() end, desc = 'Select sidekick prompt', mode = { 'n', 'v' } },
  },
  opts = {
    nes = { enabled = false },
    cli = {
      win = {
        keys = {
          buffers = { '<leader>ab', 'buffers', mode = 'nt', desc = 'open buffer picker' },
          files = { '<leader>af', 'files', mode = 'nt', desc = 'open file picker' },
          hide_n = { '<leader>aq', 'hide', mode = 'n', desc = 'hide the terminal window' },
          prompt = { '<leader>ap', 'prompt', mode = 't', desc = 'insert prompt or context' },
        },
      },
    },
  },
}
