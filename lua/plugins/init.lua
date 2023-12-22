local gitPlugin = require('plugins.git')
local generalPlugin = require('plugins.general')
local dapPlugin = require('plugins.dap')
local lspPlugin = require('plugins.lsp')
local codePlugin = require('plugins.code')
local appearancePlugin = require('plugins.appearance')
local lang = require('plugins.lang')

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
mergePlugins(plugins, lang)

return {
  plugins = plugins,
  opts = require('config.plugins.lazy'),
}
