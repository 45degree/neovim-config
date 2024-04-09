return function(opts)
  opts.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end

  opts.on_new_config = function(...)
    require('neodev.lsp').on_new_config(...)
  end

  opts.settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      hint = {
        enable = true,
        setType = true,
      },
      codeLens = {
        enable = true,
      },
      completion = {
        callSnippet = 'Replace',
        postfix = '.',
        showWord = 'Disable',
        workspaceWord = false,
      },
    },
  }
  return opts
end
