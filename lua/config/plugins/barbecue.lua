local icons = require('config.icon')
require('barbecue').setup({
  create_autocmd = false, -- prevent barbecue from updating itself automatically
  kinds = icons.kind,
})

vim.api.nvim_create_autocmd({
  'WinScrolled', -- or WinResized on NVIM-v0.9 and higher
  'BufWinEnter',
  'CursorHold',
  'InsertLeave',

  -- include this if you have set `show_modified` to `true`
  'BufModifiedSet',
}, {
  group = vim.api.nvim_create_augroup('barbecue.updater', {}),
  callback = function()
    require('barbecue.ui').update()
  end,
})
