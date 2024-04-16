vim.api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>', { noremap = true })
vim.api.nvim_set_keymap('i', 'jj', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-m-l>', '<cmd>tabnext<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-m-h>', '<cmd>tabprevious<cr>', { noremap = true })
