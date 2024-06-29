vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreview<cr>', { desc = 'markdown预览', buffer = 0 })
vim.keymap.set('n', '<leader>ms', '<cmd>MarkdownPreviewStop<cr>', { desc = 'markdown停止预览', buffer = 0 })

vim.o.textwidth = 0
