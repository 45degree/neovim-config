local M = {}

---@alias colorscheme
---| 'catppuccin' #[catppuccin]
---| 'catppuccin-latte'
---| 'catppuccin-frappe'
---| 'catppuccin-macchiato'
---| 'tokyonight' #[tokyonight]
---| 'tokyonight-day'
---| 'tokyonight-night'
---| 'tokyonight-moon'
---| 'tokyonight-storm'
---| 'kanagawa' #[kanagawa]
---| 'kanagawa-dragon'
---| 'kanagawa-lotus'
---| 'kanagawa-wave'
---| 'github_dark' #[github-theme]
---| 'github_light'
---| 'github_dark_dimmed'
---| 'github_dark_default'
---| 'github_light_default'
---| 'github_dark_high_contrast'
---| 'github_light_high_contrast'
---| 'github_dark_colorblind'
---| 'github_light_colorblind'
---| 'github_dark_tritanopia'
---| 'github_light_tritanopia'
---| 'rose-pine' #[rose-pine]
---| 'rose-pine-dawn'
---| 'rose-pine-main'
---| 'rose-pine-moon'
---| 'nightfox' #[nightfox]
---| 'dayfox'
---| 'dawnfox'
---| 'duskfox'
---| 'nordfox'
---| 'terafox'
---| 'carbonfox'
---| 'onedark' #[onedark]
---| 'onelight'
---| 'onedark_dark'
---| 'onedark_vivid'

---@class CustomNvimConfig
local defaults = {
  ---@type colorscheme
  colorscheme = 'catppuccin',
  border = 'single',
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

  ---@type 'codeium' | 'copilot' | 'fittencode' | 'none'
  ai = 'copilot',

  -- https://github.com/mfussenegger/nvim-lint/tree/master?tab=readme-ov-file#available-linters
  linter = {},

  formatter = {},

  -- lsp in lsp-config that want to use but can't be install by mason, for example: nushell
  lsp = { 'nushell' },
}

local options = {}

function M.setup(opts) options = vim.tbl_deep_extend('force', defaults, opts or {}) or {} end

setmetatable(M, {
  __index = function(_, key)
    if options == nil then return vim.deepcopy(defaults)[key] end
    return options[key]
  end,
})

return M
