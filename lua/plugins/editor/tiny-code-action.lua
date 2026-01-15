local opts = {}
if vim.fn.executable('delta') then opts.backend = 'delta' end

return {
  'rachartier/tiny-code-action.nvim',
  lazy = true,
  opts = opts,
}
