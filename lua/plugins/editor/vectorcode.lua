local config = require('config')

return {
  'Davidyz/VectorCode',
  version = '*',
  build = 'uv tool upgrade vectorcode',
  enabled = function() return vim.fn.executable('vectorcode') == 1 and config.ai_code_agent.name == 'codecompanion' end,
  lazy = true,
}
