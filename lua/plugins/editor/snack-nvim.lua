return {
  'folke/snacks.nvim',
  event = 'VeryLazy',
  opts = {
    bigfile = { enabled = true },
    input = { enabled = true },
    styles = {
      input = { relative = 'cursor', row = -3, col = 0 },
    },
  },
  config = function(_, opts)
    require('snacks').setup(opts)

    if vim.fn.executable('lazygit') == 1 then
      vim.api.nvim_create_user_command('Lazygit', function() require('snacks').lazygit.open() end, { nargs = 0 })
      vim.keymap.set('n', '<leader>gl', '<cmd>Lazygit<cr>', { desc = 'Open Lazygit' })
    end
  end,
}
