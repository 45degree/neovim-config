vim.api.nvim_buf_set_keymap(0, 'n', '<leader>mp', '<cmd>MarkdownPreview<cr>', { desc = 'markdown预览' })
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ms', '<cmd>MarkdownPreviewStop<cr>', { desc = 'markdown停止预览' })
