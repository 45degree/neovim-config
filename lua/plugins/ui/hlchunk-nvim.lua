return {
  'shellRaining/hlchunk.nvim',
  event = 'LazyFile',
  opts = {
    indent = { enable = true, exclude_filetypes = { aerial = true, dashboard = true } },
    chunk = { enable = true, delay = 0 },
  },
}
