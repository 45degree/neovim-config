return function(use)
    vim.api.nvim_exec([[
        call coc#config('languageserver', {
        \   "csharp": {
        \       "command": "csharp-ls",
        \       "trace.server": "verbose",
        \       "filetypes": ["cs"]
        \   }
        \ })
    ]], false)
end
