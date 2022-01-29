return function(use)
    vim.api.nvim_exec([[
        call add(g:coc_global_extensions, 'coc-sumneko-lua')
    ]], false)
end
