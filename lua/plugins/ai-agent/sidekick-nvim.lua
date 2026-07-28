return {
  'folke/sidekick.nvim',
  cond = require('config').ai_code_agent.name == 'sidekick',
  ---@type sidekick.Config
  opts = {
    cli = {
      win = {
        keys = {
          files = { '~', 'files', mode = 'nt', desc = 'open file picker' },
        },
      },
      tools = {
        qoder = {
          cmd = { 'qoderclicn' },
          url = 'https://docs.qoder.com/cli/installation',
        },
      },
    },
  },
  keys = {
    { '<leader>at', function() require('sidekick.cli').toggle() end, desc = 'Toggle Sidekick' },
    { '<leader>av', function() require('sidekick.cli').send({ msg = '{selection}' }) end, desc = 'Add visual selection', mode = { 'x' } },
  },
}
