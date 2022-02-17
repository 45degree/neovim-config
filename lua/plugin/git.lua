return function(use)

    -- git标记
    use {
        'airblade/vim-gitgutter',
        config = function()
            vim.g.gitgutter_sign_priority = 0
            vim.g.gitgutter_sign_added = '▍'
            vim.g.gitgutter_sign_modified = '▍'
            vim.g.gitgutter_sign_removed = '▍'
            vim.g.gitgutter_sign_removed_first_line = '▍'
            vim.g.gitgutter_sign_removed_above_and_below = '▍'
            vim.g.gitgutter_sign_modified_removed = '▍'
        end
    }

    -- 内置git命令
    use 'tpope/vim-fugitive'

    -- git log图
    use 'junegunn/gv.vim'
end
