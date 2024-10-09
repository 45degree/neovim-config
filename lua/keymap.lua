vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { noremap = true })
vim.keymap.set('i', 'jj', '<esc>', { noremap = true })
vim.keymap.set('n', '<c-m-l>', '<cmd>tabnext<cr>', { noremap = true })
vim.keymap.set('n', '<c-m-h>', '<cmd>tabprevious<cr>', { noremap = true })

local next_diagnostic, prev_diagnostic
if vim.fn.has('nvim-0.11') == 1 then
  next_diagnostic, prev_diagnostic = require('util').make_repeatable_move_pair(
    function() vim.diagnostic.jump({ count = vim.v.count1 }) end,
    function() vim.diagnostic.jump({ count = -vim.v.count1 }) end
  )
else
  next_diagnostic, prev_diagnostic = require('util').make_repeatable_move_pair(function()
    ---@diagnostic disable-next-line: deprecated
    vim.diagnostic.goto_next({ float = false })
  end, function()
    ---@diagnostic disable-next-line: deprecated
    vim.diagnostic.goto_prev({ float = false })
  end)
end

vim.keymap.set('n', ']d', next_diagnostic, { desc = 'Jump to the next diagnostic in the current buffer' })
vim.keymap.set('n', '[d', prev_diagnostic, { desc = 'Jump to the previous diagnostic in the current buffer' })
