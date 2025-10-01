return {
  dir = vim.fn.stdpath('config') .. '/xmake.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'XMake',
  config = true,
}
