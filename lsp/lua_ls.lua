return {
  ---@diagnostic disable-next-line: unused-local
  on_attach = function(client, bufnr) client.server_capabilities.documentFormattingProvider = false end,

  settings = {
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
  },
}
