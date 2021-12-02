if luaeval('option_config.getLanguage("csharp")')

    call coc#config('languageserver', {
    \     "csharp": {
    \         "command": "csharp-ls",
    \         "trace.server": "verbose",
    \         "filetypes": ["cs"]
    \     }
    \ })

end
