local function has_plugin(name)
  for _, plugin in ipairs(require('lazy').plugins()) do
    if plugin.name == name then return true end
  end
  return false
end

return {
  'neovim/nvim-lspconfig',
  event = { 'LazyFile', 'BufReadPre' },
  dependencies = {
    'folke/neoconf.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    require('neoconf').setup()
    require('mason-lspconfig').setup()

    local lspinstaller = require('mason-lspconfig')
    local lspconfig = require('lspconfig')

    -- Set global defaults for all servers
    lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
      capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('lsp-file-operations').default_capabilities()),
    })

    local enabled_server = {}
    for _, server in ipairs(lspinstaller.get_installed_servers()) do
      if server == 'rust_analyzer' and has_plugin('rustaceanvim') then goto continue end
      local config = require('plugins.lsp.lspconfig.server-config')(server)
      vim.lsp.config(server, config)
      table.insert(enabled_server, server)
      ::continue::
    end

    for _, server in ipairs(require('config').lsp) do
      if server == 'rust_analyzer' and has_plugin('rustaceanvim') then goto continue end
      table.insert(enabled_server, server)
      local config = require('plugins.lsp.lspconfig.server-config')(server)
      vim.lsp.config(server, config)
      ::continue::
    end

    vim.lsp.enable(enabled_server)

    require('plugins.lsp.lspconfig.config')
  end,
}
