return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',
  event = 'LspAttach',
  dependencies = {
    { 'SmiteshP/nvim-navic', event = 'LspAttach' },
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
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
  end,
  config = function()
    local icons = require('icons')
    require('barbecue').setup({
      create_autocmd = false, -- prevent barbecue from updating itself automatically
      kinds = icons.kind,
    })
  end,
}
