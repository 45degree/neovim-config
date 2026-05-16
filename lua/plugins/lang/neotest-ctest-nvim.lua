return {
  {
    'orjangj/neotest-ctest',
    lazy = true,
    opts = {},
  },

  {
    'nvim-neotest/neotest',
    dependencies = 'alfaix/neotest-gtest',
    opts = function(_, opts)
      opts = opts or {}
      opts.adapters = opts.adapters or {}
      opts.adapters = vim.tbl_deep_extend('force', opts.adapters, { require('neotest-ctest') })
    end,
  },
}
