---@class MasonWrapper
local M = {}

M.lang_to_filetype = {
  ['Angular'] = 'javascript',
  ['C'] = 'c',
  ['C++'] = 'cpp',
  ['C#'] = 'csharp',
  ['CMake'] = 'cmake',
  ['CSS'] = 'css',
  ['Flow'] = 'javascript',
  ['GraphQL'] = 'query',
  ['HTML'] = 'html',
  ['Lua'] = 'lua',
  ['Luau'] = 'luau',
  ['JSON'] = 'json',
  ['Java'] = 'java',
  ['JavaScript'] = 'javascript',
  ['JSX'] = 'javascript',
  ['LESS'] = 'less',
  ['Markdown'] = 'markdown',
  ['Matlab'] = 'matlab',
  ['Python'] = 'python',
  ['Rust'] = 'rust',
  ['SCSS'] = 'scss',
  ['TypeScript'] = 'typescript',
  ['Typst'] = 'typst',
  ['VimScript'] = 'vim',
  ['Vue'] = 'vue',
  ['XML'] = 'xml',
  ['YAML'] = 'yaml',
  ['Zig'] = 'zig',
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
---@field categories Array<string>?

---@param pkg Package
---@param opts MasonFilterOpt
---@return boolean
local function is_satisfy(pkg, opts)
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
  local is_categories_satisfly = true
  if opts.categories ~= nil then
    for _, cat in ipairs(opts.categories) do
      if not is_element_in_array(cat, pkg_cat) then
        is_categories_satisfly = false
      end
    end
  end

  return is_lang_satisfly and is_categories_satisfly
end

--- list all installed package from mason
---@param opts MasonFilterOpt
---@return Array<MasonPackage>
function M.list_all_installed_package(opts)
  local pkgs = require('mason-registry').get_installed_packages()
  local filtered_pkgs = {}
  for _, pkg in ipairs(pkgs) do
    if is_satisfy(pkg, opts) then
      ---@type MasonPackage
      local package = { name = pkg.name, lang = pkg.spec.languages, categories = pkg.spec.categories }
      table.insert(filtered_pkgs, package)
    end
  end

  return filtered_pkgs
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
