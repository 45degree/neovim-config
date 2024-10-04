return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    require('mason-lspconfig').setup()

    local lspinstaller = require('mason-lspconfig')
    local lspconfig = require('lspconfig')

    for _, server in ipairs(lspinstaller.get_installed_servers()) do
      local config = require('plugins.lsp.lspconfig.server-config')(server)
      lspconfig[server].setup(config)
    end

    for _, server in ipairs(require('config').lsp) do
      local config = require('plugins.lsp.lspconfig.server-config')(server)
      lspconfig[server].setup(config)
    end

    require('plugins.lsp.lspconfig.config')
  end,
}
