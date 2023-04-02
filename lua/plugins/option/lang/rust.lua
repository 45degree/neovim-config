return {
  {
    'rust-lang/rust.vim',
    ft = 'rust',
  },

  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'nvim-dap',
      'mason.nvim',
    },
    ft = 'rust',
    config = function()
      local adapterFunc = require('config.dap.di-codelldb').adapters

      local opts = {
        -- ... other configs
        dap = {
          adapter = adapterFunc,
        },
      }

      -- Normal setup
      require('rust-tools').setup(opts)
    end,
  },
}
