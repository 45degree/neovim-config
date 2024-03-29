-- =============================================================
--           __  __             __     ___
--          |  \/  |_   _    __ \ \   / (_)_ __ ___
--          | |\/| | | | |  / _` \ \ / /| | '_ ` _ \
--          | |  | | |_| | | (_| |\ V / | | | | | | |
--          |_|  |_|\__, |  \__, | \_/  |_|_| |_| |_|
--                  |___/      |_|
--
-- =============================================================

-- 插件管理器

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local global_config_file = loadfile(vim.fn.stdpath('config') .. '/config.lua')
require('config').setup(global_config_file and global_config_file() or {})
