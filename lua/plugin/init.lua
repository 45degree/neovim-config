---@diagnostic disable: undefined-global

local appearance = require('plugin.appearance')
local code = require('plugin.code')
local lsp = require('plugin.lsp')
local dap = require('plugin.dap')
local general = require('plugin.general')
local git = require('plugin.git')
local cpp = require('plugin.lang.cpp')
local python = require('plugin.lang.python')
local lua = require('plugin.lang.lua')

-- option extra plugins
local vala = require('plugin.option.lang.vala')
local rust = require('plugin.option.lang.rust')
local latex = require('plugin.option.lang.latex')
local glslx = require('plugin.option.lang.glslx')
local javascript = require('plugin.option.lang.javascript')
local csharp = require('plugin.option.lang.csharp')
local vue = require('plugin.option.lang.vue')
local html = require('plugin.option.lang.html')

local option_config = require('option_config')
option_config.read(vim.api.nvim_eval('stdpath("config")') .. '/option_config.json')


vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    appearance(use)
    code(use)
    lsp(use)
    dap(use)
    general(use)
    git(use)
    cpp(use)
    python(use)
    lua(use)

    if option_config.getLanguage("vala") then
      vala(use)
    end

    if option_config.getLanguage("glslx") then
      glslx(use)
    end

    if option_config.getLanguage("rust") then
      rust(use)
    end

    if option_config.getLanguage("latex") then
      latex(use)
    end

    if option_config.getLanguage("javascript") then
      javascript(use)
    end

    if option_config.getLanguage("html") then
      html(use)
    end

    if option_config.getLanguage("csharp") then
      csharp(use)
    end

    if option_config.getLanguage("vue") then
      vue(use)
    end

end)

vim.cmd('colorscheme '.. option_config.getColorTheme())
