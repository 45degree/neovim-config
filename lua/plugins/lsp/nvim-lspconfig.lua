return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- 'folke/neoconf.nvim',
    -- 'folke/neodev.nvim',
  },
  lazy = true,
  config = function()
    -- require('neoconf').setup()

    require('mason-lspconfig').setup()

    local lspinstaller = require('mason-lspconfig')
    local lspconfig = require('lspconfig')
    local lsp = require('config').lsp

    -- for _, server in ipairs(lsp) do
    --   local config = require('plugins.lsp.lspconfig.server-config')(server)
    --   lspconfig[server].setup(config)
    -- end

    for _, server in ipairs(lspinstaller.get_installed_servers()) do
      local config = require('plugins.lsp.lspconfig.server-config')(server)
      lspconfig[server].setup(config)
    end

    require('plugins.lsp.lspconfig.config')
  end,
}
