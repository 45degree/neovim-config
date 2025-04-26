return {
  'luozhiya/fittencode.nvim',
  init = function() vim.opt.updatetime = 200 end,
  opts = { keymaps = { inline = { ['<M-l>'] = 'accept_all_suggestions' } } },
  event = 'InsertEnter',
  cond = require('config').ai == 'fittencode',
}
