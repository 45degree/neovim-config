return {
  { 'Bilal2453/luvit-meta', lazy = true },
  { '45degree/xmake-luals-addon', lazy = true },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'lazy.nvim' },
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'xmake-luals-addon/library', files = { 'xmake.lua' } },
      },
    },
  },
}
