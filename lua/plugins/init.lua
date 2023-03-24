local gitPlugin = require('plugins.git')
local generalPlugin = require('plugins.general')
local dapPlugin = require('plugins.dap')
local lspPlugin = require('plugins.lsp')
local codePlugin = require('plugins.code')
local appearancePlugin = require('plugins.appearance')
local cppPlugin = require('plugins.lang.cpp')
local luaPlugin = require('plugins.lang.lua')
local pythonPlugin = require('plugins.lang.python')

local vala = require('plugins.option.lang.vala')
local rust = require('plugins.option.lang.rust')
local latex = require('plugins.option.lang.latex')
local glslx = require('plugins.option.lang.glslx')
local javascript = require('plugins.option.lang.javascript')
local csharp = require('plugins.option.lang.csharp')
local vue = require('plugins.option.lang.vue')
local html = require('plugins.option.lang.html')

local option_config = require('option_config')
option_config.read(vim.api.nvim_eval('stdpath("config")') .. '/option_config.json')

local plugins = {}

local function mergePlugins(mergedPlugins, newPlugins)
  for _, v in ipairs(newPlugins) do
    table.insert(mergedPlugins, v)
  end
end

mergePlugins(plugins, gitPlugin)
mergePlugins(plugins, generalPlugin)
mergePlugins(plugins, dapPlugin)
mergePlugins(plugins, lspPlugin)
mergePlugins(plugins, codePlugin)
mergePlugins(plugins, appearancePlugin)
mergePlugins(plugins, cppPlugin)
mergePlugins(plugins, luaPlugin)
mergePlugins(plugins, pythonPlugin)

if option_config.getLanguage('vala') then
  mergePlugins(plugins, vala)
end

if option_config.getLanguage('glslx') then
  mergePlugins(plugins, glslx)
end

if option_config.getLanguage('rust') then
  mergePlugins(plugins, rust)
end

if option_config.getLanguage('latex') then
  mergePlugins(plugins, latex)
end

if option_config.getLanguage('javascript') then
  mergePlugins(plugins, javascript)
end

if option_config.getLanguage('html') then
  mergePlugins(plugins, html)
end

if option_config.getLanguage('csharp') then
  mergePlugins(plugins, csharp)
end

if option_config.getLanguage('vue') then
  mergePlugins(plugins, vue)
end

return {
  plugins = plugins,
  opts = require('config.plugins.lazy'),
}
