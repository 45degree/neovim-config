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
