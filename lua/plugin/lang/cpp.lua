return function(use)
    -- Doxygen
    use {
      'vim-scripts/DoxygenToolkit.vim',
      config = function()
        vim.api.nvim_exec([[
          autocmd FileType c set syntax=cpp.doxygen
          autocmd FileType cpp set syntax=cpp.doxygen
        ]], false)
      end
    }
end
