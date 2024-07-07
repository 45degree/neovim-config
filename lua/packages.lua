local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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

local icons = require('icons')
local config = require('config')
local lazy_config = {
  defaults = { lazy = true },
  spec = { { import = 'plugins' } },
  ui = {
    border = config.border,
    icons = {
      cmd = icons.widgets.cmd,
      config = icons.widgets.config,
      event = icons.widgets.event,
      ft = icons.widgets.ft,
      init = icons.widgets.init,
      import = icons.widgets.import,
      keys = icons.widgets.keys,
      lazy = icons.widgets.lazy,
      loaded = icons.widgets.loaded,
      not_loaded = icons.widgets.not_loaded,
      plugin = icons.widgets.plugin,
      runtime = icons.widgets.runtime,
      require = icons.widgets.require,
      source = icons.widgets.source,
      start = icons.widgets.start,
      task = icons.widgets.task,
      list = icons.widgets.list,
    },
  },
}

require('lazy').setup(lazy_config)
