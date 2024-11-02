vim.keymap.set('n', '<localleader>p', '<cmd>Markview splitToggle<cr>', { buffer = 0, desc = 'toggle preview markdown' })
vim.keymap.set('n', '<localleader>b', '<cmd>MarkdownPreviewToggle<cr>', { buffer = 0, desc = 'toggle preview markdown in browser' })

vim.o.textwidth = 0
