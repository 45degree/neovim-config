vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  desc = 'Reload buffer on focus',
  callback = function()
    if vim.fn.getcmdwintype() == '' then
      vim.cmd('checktime')
    end
  end,
})

-- Disable treesitter highlight after semantic tokens are applied
_G.semantic_highlight_inited = {}

vim.api.nvim_create_autocmd('LspTokenUpdate', {
  callback = function(args)
    local buf = args.buf
    if _G.semantic_highlight_inited[buf] then
      vim.treesitter.stop(buf)
      return
    end
    _G.semantic_highlight_inited[buf] = true
  end,
})
