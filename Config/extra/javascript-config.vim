if luaeval('option_config.getLanguage("javascript")')
    " " javascript typescript 插件
    call add(g:coc_global_extensions, 'coc-tsserver')
end
