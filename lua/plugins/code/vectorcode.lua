return {
  'Davidyz/VectorCode',
  version = '*',
  build = 'uv tool upgrade vectorcode',
  cond = function() return vim.fn.executable('vectorcode') == 1 end,
  lazy = true,
}
