return {
  'echasnovski/mini.indentscope',
  version = '*',
  event = 'LazyFile',
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'help', 'alpha', 'neo-tree', 'Trouble', 'lazy', 'mason', 'notify', 'toggleterm', 'Neogit*', 'snacks_dashboard' },
      callback = function() vim.b.miniindentscope_disable = true end,
    })
  end,
  opts = {
    symbol = '│',
    options = { try_as_border = true },
  },
  config = function(_, opts)
    opts.draw = opts.draw or {}
    opts.draw.animation = require('mini.indentscope').gen_animation.none()
    require('mini.indentscope').setup(opts)
  end,
}
