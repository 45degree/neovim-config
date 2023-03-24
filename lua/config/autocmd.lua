vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.frag', '*.vert', '*.glsl' },
  callback = function()
    vim.cmd 'set filetype=glsl'
  end,
})
