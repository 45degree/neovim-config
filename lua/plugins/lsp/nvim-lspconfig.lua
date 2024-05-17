return {
  'neovim/nvim-lspconfig',
  event = 'Filetype',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  lazy = true,
  config = function()
    require('mason-lspconfig').setup()

    local lspinstaller = require('mason-lspconfig')
    local lspconfig = require('lspconfig')

    for _, server in ipairs(lspinstaller.get_installed_servers()) do
      local config = require('plugins.lsp.lspconfig.server-config')(server)
      lspconfig[server].setup(config)
    end

    require('plugins.lsp.lspconfig.config')
  end,
}
