local config = require('config')

return {
  'ravitemer/mcphub.nvim',
  lazy = true,
  cmd = 'MCPHub',
  dependencies = { 'nvim-lua/plenary.nvim' },
  build = 'bun install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
  opts = {
    cmd = vim.fn.exepath('mcp-hub'),
    config = vim.fn.stdpath('config') .. '/mcphub/servers.json',
    auto_approve = true,
    global_env = config.env
  },
}
