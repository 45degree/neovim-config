if luaeval('option_config.getLanguage("python")')
    " " python 插件
    call add(g:coc_global_extensions, 'coc-pyright')
end
