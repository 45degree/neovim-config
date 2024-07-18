return {
  'lambdalisue/suda.vim',
  event = 'VeryLazy',
  config = function() vim.g.suda_smart_edit = 1 end,
  enabled = function() return vim.fn.has('WIN32') == 0 end,
}
