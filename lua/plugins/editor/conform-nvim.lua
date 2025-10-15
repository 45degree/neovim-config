local ft_mapping = require('util.mason').lang_to_filetype

---@param pkg MasonPackage
---@param opts table<string, string[]>
---@param package_to_conform table<string, string[]>
local function registry_formatter_by_package(opts, pkg, package_to_conform)
  for _, lang in ipairs(pkg.lang) do
    local filetype = ft_mapping[lang]
    if filetype == nil then
      vim.notify(("can't find mapping from %s to filetype"):format(lang), vim.log.levels.WARN)
      goto continue
    end

    opts[filetype] = opts[filetype] or {}
    local package_name = package_to_conform[pkg.name]
    if package_name == nil then package_name = { pkg.name } end
    vim.list_extend(opts[filetype], package_name)
    ::continue::
  end
  return opts
end

return {
  'stevearc/conform.nvim',
  event = 'LazyFile',
  dependencies = { 'zapling/mason-conform.nvim', 'williamboman/mason.nvim' },
  config = function()
    local conform_to_package = require('mason-conform.mapping').conform_to_package
    local package_to_conform = {}
    for k, v in pairs(conform_to_package) do
      if package_to_conform[v] then
        table.insert(package_to_conform[v], k)
      else
        package_to_conform[v] = { k }
      end
    end

    local mason_wrapper = require('util.mason')

    ---@type MasonFilterOpt
    local formatter_opts = { categories = { 'Formatter' } }
    local pkgs = mason_wrapper.list_all_installed_package(formatter_opts)

    local opts = require('config').formatter
    for _, pkg in ipairs(pkgs) do
      if pkg.name == 'clang-format' then pkg.lang = { 'C', 'C++', 'C#' } end
      registry_formatter_by_package(opts, pkg, package_to_conform)
    end
    require('conform').setup({ formatters_by_ft = opts })
  end,
}
