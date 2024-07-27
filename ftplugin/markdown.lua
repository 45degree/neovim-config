vim.keymap.set('n', '<localleader>p', '<cmd>MarkdownPreview<cr>', { buffer = 0, desc = 'preview markdown' })
vim.keymap.set('n', '<localleader>s', '<cmd>MarkdownPreviewStop<cr>', { buffer = 0, desc = 'stop preview markdown' })

vim.o.textwidth = 0
