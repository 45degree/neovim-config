return {
  'NickvanDyke/opencode.nvim',
  lazy = true,
  cond = vim.fn.executable('opencode') == 1 and vim.fn.executable('lsof') == 1,
  keys = {
    { '<leader>aoa', function() require('opencode').ask('@this: ', { submit = true }) end, mode = { 'n', 'x' }, desc = 'Ask opencode' },
    { '<leader>aot', function() require('opencode').toggle() end, mode = { 'n', 'x' }, desc = 'Toggle opencode' },
    { '<leader>aox', function() require('opencode').select() end, mode = { 'n', 'x' }, desc = 'Execute opencode action' },
    { '<leader>aog', function() require('opencode').prompt('@this') end, mode = { 'n', 'x' }, desc = 'Add to opencode' },
  },
  init = function() vim.o.autoread = true end,
  ---@type opencode.Opts
  opts = {},
  config = function(_, opts) vim.g.opencode_opts = opts end,
}
