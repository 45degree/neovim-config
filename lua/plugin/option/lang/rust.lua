return function(use)
    use {
        'rust-lang/rust.vim'
    }

    use {
      'simrat39/rust-tools.nvim',
      after = {
        "nvim-dap",
        "DAPInstall.nvim"
      },
      config = function ()
        local adapterFunc = require('config.dap.di-codelldb').adapters

        local opts = {
          -- ... other configs
          dap = {
            adapter =adapterFunc
          }
        }

        -- Normal setup
        require('rust-tools').setup(opts)
      end
    }
end
