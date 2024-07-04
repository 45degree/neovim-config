return {
  'LhKipp/nvim-nu',
  ft = 'nu',
  config = function()
    require('nu').setup({ use_lsp_features = false })
  end,
  cond = vim.fn.executable('nu') == 1
}
