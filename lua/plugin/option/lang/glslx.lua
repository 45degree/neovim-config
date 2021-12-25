return function(use)
    use {
        'Eric-Song-Nop/vim-glslx',
        config = function()
            vim.api.nvim_exec([[
                call add(g:coc_global_extensions, 'coc-glslx')
                autocmd! BufNewFile,BufRead *.glsl set ft=glslx
            ]], false)
        end
    }
end
