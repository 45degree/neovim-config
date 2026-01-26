return {
  'NickvanDyke/opencode.nvim',
  cond = require('config').ai_code_agent.name == 'opencode',
  lazy = true,
  opts = {},
  keys = {
    { '<leader>aa', function() require('opencode').ask('@this: ', { submit = true }) end, desc = 'Opencode Inline', mode = { 'n', 'v' } },
    { '<leader>at', function() require('opencode').toggle() end, desc = 'Toggle Opencode', mode = { 'n', 'v' } },
    { '<leader>as', function() require('opencode').select() end, desc = 'Execute opencode action', mode = { 'n', 'v' } },
  },
  config = function(_, opts) vim.g.opencode_opts = opts end,
}
