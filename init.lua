-- =============================================================
--           __  __             __     ___
--          |  \/  |_   _    __ \ \   / (_)_ __ ___
--          | |\/| | | | |  / _` \ \ / /| | '_ ` _ \
--          | |  | | |_| | | (_| |\ V / | | | | | | |
--          |_|  |_|\__, |  \__, | \_/  |_|_| |_| |_|
--                  |___/      |_|
--
-- =============================================================

vim.loader.enable()

if vim.env.PROF then
  local snacks = vim.fn.stdpath('data') .. '/lazy/snacks.nvim'
  vim.opt.rtp:append(snacks)
  require('snacks.profiler').startup({ startup = { event = 'VimEnter' } })
end

local global_config_file = loadfile(vim.fn.stdpath('config') .. '/config.lua')
require('config').setup(global_config_file and global_config_file() or {})
require('init')
