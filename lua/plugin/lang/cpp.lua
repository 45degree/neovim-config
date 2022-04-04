return function(use)
    -- Doxygen
    use {
        'vim-scripts/DoxygenToolkit.vim',
        config = function()
            vim.api.nvim_exec([[
                autocmd FileType c set syntax=cpp.doxygen
                autocmd FileType cpp set syntax=cpp.doxygen
            ]], false)

            -- -- Setup lspconfig.
            -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            -- require('lspconfig')['clangd'].setup {
            --   capabilities = capabilities
            -- }
        end
    }
end
