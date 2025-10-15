---@param opts table<string, string[]>
---@param pkg MasonPackage
local function registry_linter_by_package(opts, pkg, package_to_nvimlint)
  local ft_mapping = require('util.mason').lang_to_filetype

  local function set_linter_for_filetype(filetype)
    if opts[filetype] == nil then opts[filetype] = {} end

    local package_name = package_to_nvimlint[pkg.name]
    if package_name == nil then return end
    table.insert(opts[filetype], package_name)
  end

  if #pkg.lang == 0 then
    for _, filetype in pairs(ft_mapping) do
      set_linter_for_filetype(filetype)
    end
  else
    for _, lang in ipairs(pkg.lang) do
      local filetype = ft_mapping[lang]
      if filetype == nil then
        vim.notify(("can't find mapping from %s to filetype"):format(lang), vim.log.levels.WARN)
      else
        set_linter_for_filetype(filetype)
      end
    end
  end
end

return {
  'mfussenegger/nvim-lint',
  event = 'LazyFile',
  dependencies = { 'rshkarin/mason-nvim-lint', 'mason-org/mason.nvim' },
  config = function()
    local mason_wrapper = require('util.mason')

    ---@type MasonFilterOpt
    local filter_opts = { categories = { 'Linter' } }
    local pkgs = mason_wrapper.list_all_installed_package(filter_opts)

    local nvimlint_to_package = require('mason-nvim-lint.mapping').nvimlint_to_package
    nvimlint_to_package['typos'] = 'typos'
    local package_to_nvimlint = {}
    for k, v in pairs(nvimlint_to_package) do
      package_to_nvimlint[v] = k
    end

    ---@type table<string, string[]>
    local opts_kv = {}
    for _, pkg in ipairs(pkgs) do
      registry_linter_by_package(opts_kv, pkg, package_to_nvimlint)
    end

    for filetype, linters in pairs(require('config').linter) do
      if filetype == 'all' then
        local ft_mapping = require('util.mason').lang_to_filetype
        for _, ft in pairs(ft_mapping) do
          opts_kv[ft] = opts_kv[ft] or {}
          for _, linter in ipairs(linters) do
            table.insert(opts_kv[ft], linter)
          end
        end
      else
        opts_kv[filetype] = {}
        for _, linter in ipairs(linters) do
          table.insert(opts_kv[filetype], linter)
        end
      end
    end

    require('lint').linters_by_ft = opts_kv
  end,
  init = function()
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      callback = function() require('lint').try_lint() end,
    })
  end,
}
