return {
  'luozhiya/fittencode.nvim',
  config = function()
    require('fittencode').setup({
      keymaps = { inline = { ['<M-l>'] = 'accept_all_suggestions' } },
    })
    vim.opt.updatetime = 200
  end,
  event = 'InsertEnter',
  cond = require('config').ai == 'fittencode',
}
