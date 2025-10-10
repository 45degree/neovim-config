---@alias colorscheme
---| 'catppuccin' #[catppuccin]
---| 'catppuccin-latte'
---| 'catppuccin-frappe'
---| 'catppuccin-macchiato'
---| 'catppuccin-mocha'
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

---@alias AiCodeProvider 'codeium'|'copilot'|'fittencode'|'supermaven'|'none'

---@class CodeCompanionAdapter
---@field chat string
---@field inline string
---@field cmd string

---@alias GuiConfig {fonts: string[], widefonts: string[], font_opts: string?}

---@class CustomNvimConfig
---@field colorscheme? colorscheme
---@field ai? AiCodeProvider
---@field gui? GuiConfig
---@field codecompanion_adapter? CodeCompanionAdapter
---@field lang? table<string, boolean>
---@field lsp? {enabled?: string[], disabled?: string[]}
---@field formatter? table<string, string[]>
---@field linter? table<string, string[]>
---@field shell? string[]
---@field env? table<string, string>
---@field setup? fun(opts: CustomNvimConfig)

---@type CustomNvimConfig
local defaults = {
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

  ai = 'copilot',
  codecompanion_adapter = {
    chat = 'anthropic',
    inline = 'copilot',
    cmd = 'deepseek',
  },

  -- https://github.com/mfussenegger/nvim-lint/tree/master?tab=readme-ov-file#available-linters
  linter = {},

  formatter = {},

  -- lsp in lsp-config that want to use but can't be install by mason, for example: nushell
  lsp = { enabled = {}, disabled = { 'stylua' } },

  ---@type GuiConfig
  gui = {
    fonts = { 'Maple Mono' },
    widefonts = { 'Symbols Nerd Font', 'LXGW WenKai Mono' },
    font_opts = 'h10',

    goneovim = { widefonts = { 'Symbols Nerd Font', '霞鹜文楷等宽' } },
  },

  env = {},

  shell = nil,
}

---@type CustomNvimConfig
local M = {}
setmetatable(M, { __index = function(_, key) return defaults[key] end })

function M.setup(opts)
  defaults = vim.tbl_deep_extend('force', defaults, opts or {}) or {}
  for k, v in pairs(M.env) do
    vim.env[k] = v
  end
end

return M
