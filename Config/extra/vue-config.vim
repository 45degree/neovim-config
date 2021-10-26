if luaeval('option_config.getLanguage("vue")')
    " " Vue 插件
    call add(g:coc_global_extensions, 'coc-vetur')
end
