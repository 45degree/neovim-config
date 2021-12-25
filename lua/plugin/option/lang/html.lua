return function(use)
    -- html 插件
    vim.api.nvim_exec([[
        call add(g:coc_global_extensions, 'coc-html')
    ]], false)
end
