if not vim.g.goneovim then return end

local config = require('config')

---@param opts GuiConfig
local function set_goneovim(opts)
  if opts.font_opts then
    local fonts = {}
    local widefonts = {}
    for _, font in ipairs(opts.fonts) do
      table.insert(fonts, string.format('%s:%s', font, opts.font_opts))
    end
    for _, font in ipairs(opts.widefonts) do
      table.insert(widefonts, string.format('%s:%s', font, opts.font_opts))
    end
    vim.o.guifont = table.concat(fonts, ',')
    vim.o.guifontwide = table.concat(widefonts, ',')
  else
    vim.o.guifont = table.concat(opts.fonts, ',')
    vim.o.guifontwide = table.concat(opts.widefonts, ',')
  end
end

---@type GuiConfig
local gui_config = {}
gui_config.fonts = config.gui.fonts or {}
gui_config.widefonts = config.gui.widefonts or {}
gui_config.font_opts = config.gui.font_opts

if config.gui.goneovim then gui_config = vim.tbl_deep_extend('force', gui_config, config.gui.goneovim or {}) end
set_goneovim(gui_config)
