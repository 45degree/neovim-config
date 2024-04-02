---@class MasonWrapper
local M = {}

M.lang_to_filetype = {
  ['C++'] = 'cpp',
  ['C'] = 'c',
  ['Lua'] = 'lua',
  ['Luau'] = 'luau',
  ['Python'] = 'python',
  ['C#'] = 'csharp',
  ['JSON'] = 'json',
  ['Java'] = 'java',
  ['JavaScript'] = 'javascript',
  ['Angular'] = 'javascript',
  ['Flow'] = 'javascript',
  ['CSS'] = 'css',
  ['HTML'] = 'html',
  ['JSX'] = 'javascript',
  ['LESS'] = 'less',
  ['Markdown'] = 'markdown',
  ['SCSS'] = 'scss',
  ['TypeScript'] = 'typescript',
  ['Vue'] = 'vue',
  ['YAML'] = 'yaml',
  ['GraphQL'] = 'query'
}

---@class MasonPackage
---@field name string
---@field lang string[]
---@field categories string[]

---@param name string
---@param elements string[]
local function is_element_in_array(name, elements)
  for _, v in ipairs(elements) do
    if name == v then
      return true
    end
  end
  return false
end

---@class MasonFilterOpt
---@field lang Array<string>?
---@field categorie Array<string>?

---@param pkg Package
---@param opts MasonFilterOpt
---@return boolean
local function is_satisfiy(pkg, opts)
  local pkg_lang = pkg.spec.languages
  local is_lang_satisfly = true
  if opts.lang ~= nil then
    for _, lang in ipairs(opts.lang) do
      if not is_element_in_array(lang, pkg_lang) then
        is_lang_satisfly = false
        break
      end
    end
  end

  local pkg_cat = pkg.spec.categories
  local is_categorie_satisfly = true
  if opts.categorie ~= nil then
    for _, cat in ipairs(opts.categorie) do
      if not is_element_in_array(cat, pkg_cat) then
        is_categorie_satisfly = false
      end
    end
  end

  return is_lang_satisfly and is_categorie_satisfly
end

--- list all installed package from mason
---@param opts MasonFilterOpt
---@return Array<MasonPackage>
function M.list_all_installed_package(opts)
  local pkgs = require('mason-registry').get_installed_packages()
  local filterd_pkgs = {}
  for _, pkg in ipairs(pkgs) do
    if is_satisfiy(pkg, opts) then
      ---@type MasonPackage
      local package = { name = pkg.name, lang = pkg.spec.languages, categories = pkg.spec.categories }
      table.insert(filterd_pkgs, package)
    end
  end

  return filterd_pkgs
end

---@param name string
---@return boolean
function M.is_mason_package_installed(name)
  return require('mason-registry').is_installed(name)
end

---@param name string
function M.install_mason_package(name)
  local server_name, version = require('mason-core.package').Parse(name)
  local pkg = require('mason-registry').get_package(server_name)

  local notify_ok, notify = pcall(require, 'notify')
  if not notify_ok then
    vim.notify('[mason package] begin to automatically install: ' .. name, vim.log.levels.INFO)
  else
    notify('[mason package] begin to automatically install: ' .. name, vim.log.levels.INFO)
  end

  pkg:install({ version = version }):once(
    'closed',
    vim.schedule_wrap(function()
      if pkg:is_installed() then
        vim.notify('[mason package]' .. name .. ' automatically installed', vim.log.levels.INFO)
      else
        vim.notify('[mason package]' .. name .. ' failed to automatically install', vim.log.levels.ERROR)
      end
    end)
  )
end

return M
