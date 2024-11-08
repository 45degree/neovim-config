local function has_plugin(name)
  for _, plugin in ipairs(require('lazy').plugins()) do
    if plugin.name == name then return true end
  end
  return false
end

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
      if server == 'rust_analyzer' and has_plugin('rustaceanvim') then goto continue end
      local config = require('plugins.lsp.lspconfig.server-config')(server)
      lspconfig[server].setup(config)
      ::continue::
    end

    for _, server in ipairs(require('config').lsp) do
      if server == 'rust_analyzer' and has_plugin('rustaceanvim') then goto continue end
      local config = require('plugins.lsp.lspconfig.server-config')(server)
      if not require('lspconfig.configs')[server] then require('lspconfig.configs')[server] = { default_config = config } end
      lspconfig[server].setup(config)
      ::continue::
    end

    require('plugins.lsp.lspconfig.config')
  end,
}
