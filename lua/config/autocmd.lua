vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = {
    '*.vert',
    '*.tesc',
    '*.tese',
    '*.geom',
    '*.comp',
    '*.frag',
    '*.comp',
    '*.mesh',
    '*.task',
    '*.rgen',
    '*.rint',
    '*.rahit',
    '*.rchit',
    '*.rmiss',
    '*.rcall',
    '*.glsl',
  },
  callback = function()
    vim.cmd('set filetype=glsl')
  end,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  desc = 'Reload buffer on focus',
  callback = function()
    if vim.fn.getcmdwintype() == '' then
      vim.cmd('checktime')
    end
  end,
})
