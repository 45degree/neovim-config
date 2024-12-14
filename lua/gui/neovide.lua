if not vim.g.neovide then return end

local config = require('config')

---@param opts GuiConfig
local function set_neovide(opts)
  local fonts = table.concat(opts.fonts, ',')
  local widefonts = table.concat(opts.widefonts, ',')
  if opts.font_opts then
    vim.o.guifont = string.format('%s,%s:%s', fonts, widefonts, opts.font_opts)
  else
    vim.o.guifont = string.format('%s,%s', fonts, widefonts)
  end
end

---@type GuiConfig
local gui_config = {}
gui_config.fonts = config.gui.fonts or {}
gui_config.widefonts = config.gui.widefonts or {}
gui_config.font_opts = config.gui.font_opts

if config.gui.neovide then gui_config = vim.tbl_deep_extend('force', gui_config, config.gui.neovide or {}) end
set_neovide(gui_config)
