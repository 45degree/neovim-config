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

local global_config_file = loadfile(vim.fn.stdpath('config') .. '/config.lua')
require('config').setup(global_config_file and global_config_file() or {})
require('init')

-- default enabled lsp
local lsp = { 'clangd', 'nushell', 'lua_ls', 'jsonls', 'ruff', 'pyright', 'wgsl_analyzer', 'rust_analyzer', 'ts_ls', 'slang', 'neocmake' }
vim.lsp.enable(lsp)
