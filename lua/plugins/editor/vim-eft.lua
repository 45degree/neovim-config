return {
  'hrsh7th/vim-eft',
  event = 'BufReadPre',
  config = function()
    vim.api.nvim_set_keymap('n', ';', '<Plug>(eft-repeat)', {})
    vim.api.nvim_set_keymap('x', ';', '<Plug>(eft-repeat)', {})
    vim.api.nvim_set_keymap('o', ';', '<Plug>(eft-repeat)', {})

    vim.api.nvim_set_keymap('n', 'f', '<Plug>(eft-f)', {})
    vim.api.nvim_set_keymap('x', 'f', '<Plug>(eft-f)', {})
    vim.api.nvim_set_keymap('o', 'f', '<Plug>(eft-f)', {})

    vim.api.nvim_set_keymap('n', 'F', '<Plug>(eft-F)', {})
    vim.api.nvim_set_keymap('x', 'F', '<Plug>(eft-F)', {})
    vim.api.nvim_set_keymap('o', 'F', '<Plug>(eft-F)', {})

    vim.api.nvim_set_keymap('n', 't', '<Plug>(eft-t)', {})
    vim.api.nvim_set_keymap('x', 't', '<Plug>(eft-t)', {})
    vim.api.nvim_set_keymap('o', 't', '<Plug>(eft-t)', {})

    vim.api.nvim_set_keymap('n', 'T', '<Plug>(eft-T)', {})
    vim.api.nvim_set_keymap('x', 'T', '<Plug>(eft-T)', {})
    vim.api.nvim_set_keymap('o', 'T', '<Plug>(eft-T)', {})
  end,
}
