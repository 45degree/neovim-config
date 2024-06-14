return function(opts)
  ---@diagnostic disable-next-line: unused-local
  opts.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
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
