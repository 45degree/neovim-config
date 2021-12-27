return function(use)
    vim.api.nvim_exec([[
        call add(g:coc_global_extensions, 'coc-pyright')
    ]], false)
end
