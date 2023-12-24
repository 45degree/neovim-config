local M = {}

local defaults = {
  colorscheme = 'catppuccin',
  lang = {
    cpp = true,
    rust = false,
    vala = false,
    latex = false,
    glslx = false,
    html = false,
    csharp = false,
    vue = false,
    javascript = false,
    typst = false,
  },
}

local options

local function init()
  require('config.config-base')
  require('config.ime-config')

  local plugins = require('plugins')
  require('lazy').setup(plugins.plugins, plugins.opts)
  vim.cmd.colorscheme(M.colorscheme)
end

function M.setup(opts)
  options = vim.tbl_deep_extend('force', defaults, opts or {}) or {}
  init()
end

setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      return vim.deepcopy(defaults)[key]
    end
    return options[key]
  end,
})

return M
