return {
  'williamboman/mason-lspconfig.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    -- 'folke/neodev.nvim',
  },
  config = function()
    require('mason-lspconfig').setup()

    local lspinstaller = require('mason-lspconfig')
    local lspconfig = require('lspconfig')
    local lsp = require('config').lsp

    for _, server in ipairs(lsp) do
      local config = require('plugins.lsp.lspconfig.server-config')(server)
      lspconfig[server].setup(config)
    end

    for _, server in ipairs(lspinstaller.get_installed_servers()) do
      local config = require('plugins.lsp.lspconfig.server-config')(server)
      lspconfig[server].setup(config)
    end

    require('plugins.lsp.lspconfig.config')
  end,
}
