return function (use)

  use {
    'p00f/clangd_extensions.nvim',
    after = {
      "nvim-lsp-installer",
      "nvim-lspconfig"
    },
    config = function ()
      require("clangd_extensions").setup()
    end
  }

end
