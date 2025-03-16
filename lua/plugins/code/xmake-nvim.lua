return {
  dir = vim.fn.stdpath('config') .. '/xmake.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'XMake',
  event = 'VeryLazy',
  config = function()
    -- MSBuild:
    vim.opt.errorformat:append([[\ %#%f(%l\,%c):\ %m]])
    -- cl.exe:
    vim.opt.errorformat:append([[\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %m]])
    -- clang / gcc
    vim.opt.errorformat:append([[%E%f:%l:%c:\ %trror:\ %m,%-Z%p^,%+C%.%#]])

    require('xmake').setup({})
  end,
}
