if vim.version().minor < 7 then
  vim.notify('Neovim 0.7+ is required for xmake plugin', vim.log.levels.ERROR)
  return
end

local subcommands = require('xmake.subcommands')

vim.api.nvim_create_user_command('XMake', subcommands.run, { nargs = '*', complete = subcommands.complete, desc = 'Run XMake command' })
