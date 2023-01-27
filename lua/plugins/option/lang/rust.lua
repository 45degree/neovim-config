return {
  'rust-lang/rust.vim',

  'simrat39/rust-tools.nvim',
  dependencies = {
    "nvim-dap",
    "mason.nvim"
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
