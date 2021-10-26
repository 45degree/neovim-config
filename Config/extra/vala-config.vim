if luaeval('option_config.getLanguage("vala")')
    call coc#config('languageserver', {
    \     "vala": {
    \         "command": "vala-language-server",
    \         "filetypes": ["vala", "genie"]
    \     }
    \ })
end
