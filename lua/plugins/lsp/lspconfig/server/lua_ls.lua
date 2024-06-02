return function(opts)
  opts.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end

  opts.on_new_config = function(...)
    local ok, result = pcall(require, 'neodev.lsp')
    if ok then
      result.on_new_config(...)
    end
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
