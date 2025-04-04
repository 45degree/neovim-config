return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  opts = {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == 'horizontal' then
        return 10
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.40
      end
    end,
    open_mapping = [[<M-=>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    autochdir = true,
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = 'horizontal',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = function()
      local shell = require('config').shell
      if shell == nil or not vim.islist(shell) then return vim.o.shell end
      return shell[1]
    end,
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    local float_opts = {
      border = 'single',
    }

    local on_create = function(t)
      local bufnr = t.bufnr
      vim.keymap.set('t', '<Esc>', '<Nop>', { buffer = bufnr })
    end

    if vim.fn.executable('yazi') == 1 then
      local yazi = require('toggleterm.terminal').Terminal:new({
        cmd = 'yazi',
        hidden = true,
        direction = 'float',
        float_opts = float_opts,
        on_create = on_create,
      })

      vim.api.nvim_create_user_command('Yazi', function() yazi:toggle() end, { nargs = 0 })
    end

    -- if vim.fn.executable('lazygit') == 1 then
    --   local lazygit = require('toggleterm.terminal').Terminal:new({
    --     cmd = 'lazygit',
    --     hidden = true,
    --     direction = 'float',
    --     float_opts = float_opts,
    --     on_create = on_create,
    --   })
    --
    --   vim.api.nvim_create_user_command('Lazygit', function() lazygit:toggle() end, { nargs = 0 })
    --
    --   vim.keymap.set('n', '<leader>gl', '<cmd>Lazygit<cr>', { desc = 'Open Lazygit' })
    -- end

    vim.api.nvim_create_user_command('TermSelect', function()
      local shell = require('config').shell
      if type(shell) == 'string' then
        local terminal = require('toggleterm.terminal').Terminal:new({ cmd = shell })
        terminal:toggle()
        return
      end

      if not vim.islist(shell) then
        vim.notify('config of shell must be string or list', vim.log.levels.ERROR, {})
        return
      end

      vim.ui.select(shell, { prompt = 'Select shell' }, function(choice)
        local terminal = require('toggleterm.terminal').Terminal:new({ cmd = choice })
        terminal:toggle()
      end)
    end, { nargs = 0 })
  end,
}
