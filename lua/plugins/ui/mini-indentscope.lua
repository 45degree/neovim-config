return {
  'echasnovski/mini.indentscope',
  version = '*',
  event = 'VeryLazy',
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'help', 'alpha', 'neo-tree', 'Trouble', 'lazy', 'mason', 'notify', 'toggleterm', 'Neogit*' },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
  config = function()
    require('mini.indentscope').setup({
      symbol = '│',
      options = { try_as_border = true },
      draw = {
        animation = require('mini.indentscope').gen_animation.none(),
      },
    })
  end,
}
