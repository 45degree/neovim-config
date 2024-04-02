vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  desc = 'Reload buffer on focus',
  callback = function()
    if vim.fn.getcmdwintype() == '' then
      vim.cmd('checktime')
    end
  end,
})

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  callback = function(opt)
    local buf = opt.buf
    local client = vim.lsp.get_client_by_id(opt.data.client_id)
    if client.server_capabilities['semanticTokensProvider'] then
      vim.treesitter.stop(buf)
    end
  end,
})
