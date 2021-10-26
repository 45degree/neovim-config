if luaeval('option_config.getLanguage("rust")')

    let coc_global_extensions = get(g:, 'coc_global_extensions', {})
    " " rust插件
    call add(coc_global_extensions, 'coc-rls')
    call add(coc_global_extensions, 'coc-rust-analyzer')
end
