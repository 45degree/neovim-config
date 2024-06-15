local M = {}

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
  tabnine = false,
  -- https://github.com/mfussenegger/nvim-lint/tree/master?tab=readme-ov-file#available-linters
  linter = {},
  formatter = {},

  -- lsp in lsp-config that want to use but can't be install by mason, for example: nushell
  lsp = { 'nushell' },
}

local options = {}

function M.setup(opts)
  options = vim.tbl_deep_extend('force', defaults, opts or {}) or {}
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
