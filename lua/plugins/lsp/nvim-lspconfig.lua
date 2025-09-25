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
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
  },
  config = function()
    require('neoconf').setup()
    require('mason-lspconfig').setup()

    local lspinstaller = require('mason-lspconfig')

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
      local config = require('plugins.lsp.lspconfig.server-config')(server)

      vim.lsp.config(server, config)
      table.insert(enabled_server, server)
      ::continue::
    end

    vim.lsp.enable(enabled_server)

    vim.keymap.set('n', 'gd', function() require('snacks.picker').lsp_definitions({ layout = 'ivy' }) end, { noremap = true, silent = true })
    vim.keymap.set('n', 'gi', function() require('snacks.picker').lsp_implementations({ layout = 'ivy' }) end, { noremap = true, silent = true })
    vim.keymap.set('n', 'gr', function() require('snacks.picker').lsp_references({ layout = 'ivy' }) end, { noremap = true, silent = true })
    vim.keymap.set('n', 'K', function(...) vim.lsp.buf.hover(...) end, { noremap = true, silent = true })
    vim.keymap.set('n', 'rn', function(...) vim.lsp.buf.rename(...) end, { noremap = true, silent = true })
    vim.keymap.set('n', 'ca', function(...) vim.lsp.buf.code_action(...) end, { noremap = true, silent = true })
  end,
}
