require('which-key').add({
  { '<Leader>?p', '<cmd>MarkdownPreview<cr>', desc = 'preview markdown', buffer = 0 },
  { '<Leader>?s', '<cmd>MarkdownPreviewStop<cr>', desc = 'stop preview markdown', buffer = 0 },
})

vim.o.textwidth = 0
