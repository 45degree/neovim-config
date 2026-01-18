local opts = { backend = 'vim' }
if vim.fn.executable('delta') == 1 then opts.backend = 'delta' end

return {
  'rachartier/tiny-code-action.nvim',
  lazy = true,
  opts = opts,
}
