if luaeval('option_config.getLanguage("glslx")')
    call add(g:coc_global_extensions, 'coc-glslx')
    autocmd! BufNewFile,BufRead *.glsl set ft=glslx
end
