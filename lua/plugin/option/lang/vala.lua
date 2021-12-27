return function(use)
    use {
        'arrufat/vala.vim',
        config = function()
            vim.api.nvim_exec([[
                call coc#config('languageserver', {
                \   "vala": {
                \       "command": "vala-language-server",
                \       "filetypes": ["vala", "genie"]
                \   }
                \ })
            ]], false)
        end
    }
end
