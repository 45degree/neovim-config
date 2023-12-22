return {
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    enabled = GLOBAL_CONFIG.lang.rust
  },

  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'nvim-dap',
      'mason.nvim',
    },
    ft = 'rust',
    enabled = GLOBAL_CONFIG.lang.rust,
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
