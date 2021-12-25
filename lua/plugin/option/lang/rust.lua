return function(use)
    use {
        'rust-lang/rust.vim',
        config = function()
            vim.api.nvim_exec([[
                call add(g:coc_global_extensions, "coc-rls")
                call add(g:coc_global_extensions, "coc-rust-analyzer")
            ]], false)
        end
    }
end
