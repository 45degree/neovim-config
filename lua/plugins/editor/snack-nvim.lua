return {
  {
    'folke/snacks.nvim',
    event = 'VeryLazy',
    opts = {
      bigfile = { enabled = true },
      input = { enabled = true },
      styles = { input = { relative = 'cursor', row = -3, col = 0, width = 40 } },
    },
    config = function(_, opts)
      require('snacks').setup(opts)

      if vim.fn.executable('lazygit') == 1 then
        vim.api.nvim_create_user_command('Lazygit', function() require('snacks').lazygit.open() end, { nargs = 0 })
        vim.keymap.set('n', '<leader>gl', '<cmd>Lazygit<cr>', { desc = 'Open Lazygit' })
      end
    end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = function(_, opts)
      local function on_move(data)
        vim.print(1)
        require('snacks').rename.on_rename_file(data.source, data.destination)
      end
      local events = require('neo-tree.events')
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
    end,
  },
}
