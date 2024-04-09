return {
  'folke/neodev.nvim',
  lazy = true,
  config = function()
    require('neodev').setup({
      -- add any options here, or leave empty to use the default settings
      library = { plugins = { 'plenary.nvim', 'neodev.nvim', 'mason.nvim' } },
      override = function(root_dir, opts)
        local path = require('plenary.path')
        local root = path:new({ root_dir })

        if root:joinpath('.nvim.lua'):exists() then
          opts.enabled = true
        end
      end,
    })
  end,
}
