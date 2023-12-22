local cpp = require('plugins.lang.cpp')
local lua = require('plugins.lang.lua')
local python = require('plugins.lang.python')
local vala = require('plugins.lang.vala')
local rust = require('plugins.lang.rust')
local latex = require('plugins.lang.latex')
local glslx = require('plugins.lang.glslx')
local javascript = require('plugins.lang.javascript')
local csharp = require('plugins.lang.csharp')
local vue = require('plugins.lang.vue')
local html = require('plugins.lang.html')
local typst = require('plugins.lang.typst')

local function mergePlugins(mergedPlugins, newPlugins)
  for _, v in ipairs(newPlugins) do
    table.insert(mergedPlugins, v)
  end
end

local plugins = {}
mergePlugins(plugins, cpp)
mergePlugins(plugins, lua)
mergePlugins(plugins, python)
mergePlugins(plugins, vala)
mergePlugins(plugins, rust)
mergePlugins(plugins, latex)
mergePlugins(plugins, glslx)
mergePlugins(plugins, javascript)
mergePlugins(plugins, csharp)
mergePlugins(plugins, vue)
mergePlugins(plugins, html)
mergePlugins(plugins, typst)

return plugins
