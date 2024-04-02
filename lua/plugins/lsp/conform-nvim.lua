local ft_mapping = require('util.mason').lang_to_filetype

---@param pkg MasonPackage
---@param package_to_conform table<string, string>
local function registry_formatter_by_package(opts, pkg, package_to_conform)
  for _, lang in ipairs(pkg.lang) do
    local filetype = ft_mapping[lang]
    if filetype == nil then
      vim.notify(("can't find mapping from %s to filetype"):format(lang), vim.log.levels.WARN)
    else
      if opts[filetype] == nil then
        opts[filetype] = {}
      end
      table.insert(opts[filetype], package_to_conform[pkg.name])
    end
  end
end

return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  dependencies = { "zapling/mason-conform.nvim", 'williamboman/mason.nvim' },
  config = function()
    local conform_to_package = require("mason-conform.mapping").conform_to_package
    local package_to_conform = {}
    for k, v in pairs(conform_to_package) do
      package_to_conform[v] = k
    end

    local mason_wrapper = require('util.mason')

    ---@type MasonFilterOpt
    local formatter_opts = { categorie = { 'Formatter' } }
    local pkgs = mason_wrapper.list_all_installed_package(formatter_opts)

    local formatters_by_ft = require('config').formatter
    for _, pkg in ipairs(pkgs) do
      registry_formatter_by_package(formatters_by_ft, pkg, package_to_conform)
    end

    require('conform').setup({
      formatters_by_ft = formatters_by_ft,
    })
  end
}
