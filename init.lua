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

require('config.config-base')

local plugins = require('plugins')
require('lazy').setup(plugins.plugins, plugins.opts)

-- local option_config = require('option_config')
-- option_config.read(vim.api.nvim_eval('stdpath("config")') .. '/option_config.json')
-- vim.cmd('colorscheme '.. option_config.getColorTheme())
if vim.fn.has('win32') ~= 1 then
  require('config.fcitx-config')
end
require('config.dap.dap-config').setup()

if vim.fn.exists('g:gonvim_running') == 1 then
  vim.opt.guifont = 'Maple Mono:h10:sb'
  vim.opt.guifontwide = 'Symbols Nerd Font,Sarasa Fixed SC:h10:sb'
elseif vim.fn.exists('g:neovide') == 1 then
  if vim.fn.has('win32') == 1 then
    vim.opt.guifont = 'Maple Mono,Sarasa Fixed SC,Symbols Nerd Font 2048-em:h10:sb'
  else
    vim.opt.guifont = 'Maple Mono,Sarasa Fixed SC,Symbols Nerd Font:h10:sb'
  end
end
