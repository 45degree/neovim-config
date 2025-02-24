local ft_mapping = require('util.mason').lang_to_filetype

---@param pkg MasonPackage
---@param package_to_conform table<string, string>
local function registry_formatter_by_package(opts, pkg, package_to_conform)
  for _, lang in ipairs(pkg.lang) do
    local filetype = ft_mapping[lang]
    if filetype == nil then
      vim.notify(("can't find mapping from %s to filetype"):format(lang), vim.log.levels.WARN)
    else
      if opts[filetype] then goto continue end

      opts[filetype] = {}
      local package_name = package_to_conform[pkg.name]
      if package_name == nil then package_name = pkg.name end
      table.insert(opts[filetype], package_name)
    end
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
    conform_to_package['ruff_fix'] = nil
    local package_to_conform = {}
    for k, v in pairs(conform_to_package) do
      package_to_conform[v] = k
    end

    local mason_wrapper = require('util.mason')

    ---@type MasonFilterOpt
    local formatter_opts = { categories = { 'Formatter' } }
    local pkgs = mason_wrapper.list_all_installed_package(formatter_opts)

    local opts = {}
    for ft, formatters in ipairs(require('config').formatter) do
      for _, formatter in ipairs(formatters) do
        table.insert(opts[ft], formatter)
        if type(formatter) == 'string' and vim.fn.executable(formatter) ~= 0 then goto continue end
      end
      ::continue::
    end

    for _, pkg in ipairs(pkgs) do
      registry_formatter_by_package(opts, pkg, package_to_conform)
    end

    require('conform').setup({ formatters_by_ft = opts })
  end,
}
