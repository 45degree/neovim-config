return {
  {
    'folke/snacks.nvim',
    lazy = true,
    event = 'LazyFile',
    init = function()
      -- modified from https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/alpha.lua
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          local function should_skip(lines)
            if vim.fn.argc() > 0 then return true end

            if #lines > 1 or (#lines == 1 and lines[1]:len() > 0) then return true end

            local listed_buffers = vim.tbl_filter(function(bufnr) return vim.bo[bufnr].buflisted end, vim.api.nvim_list_bufs())
            if #listed_buffers > 1 or not vim.o.modifiable then return true end

            for _, arg in pairs(vim.v.argv) do
              if arg == '-b' or arg == '-c' or vim.startswith(arg, '+') or arg == '-S' then return true end
            end

            return false
          end

          local lines = vim.api.nvim_buf_get_lines(0, 0, 2, false)
          if should_skip(lines) then return end

          require('lazy').load({ plugins = { 'snacks.nvim' } })
        end,
      })
    end,
    opts = {
      indent = {
        enabled = true,
        filter = function(buf)
          local disabled_filetype = { 'neo-tree', 'alpha', 'help', 'lazy', 'mason', 'Neogit*', 'snacks_dashboard' }
          local disabled_buftypes = { 'terminal', 'nofile', 'prompt' }

          for _, ft in ipairs(disabled_filetype) do
            if string.match(vim.bo[buf].filetype, ft) then return false end
          end

          for _, bt in ipairs(disabled_buftypes) do
            if string.match(vim.bo[buf].buftype, bt) then return false end
          end

          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false
        end,
      },
      input = { enabled = false },
      scroll = { enabled = false },
      bigfile = { enabled = false },
      notifier = { enabled = true },
      quickfile = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      dashboard = {
        preset = {
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
            { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = ' ', key = 's', desc = 'Restore Session', action = '<cmd>SessionManager load_session<cr>' },
            { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1, padding = 2 },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 2 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 2 },
          { section = 'startup' },
        },
      },
    },
    config = function(_, opts)
      require('snacks').setup(opts)
      if vim.fn.executable('lazygit') == 1 then
        local config = { win = { border = require('config').border } }
        vim.api.nvim_create_user_command('Lazygit', function() require('snacks').lazygit(config) end, { nargs = 0 })
        vim.keymap.set('n', '<leader>gl', '<cmd>Lazygit<cr>', { desc = 'Open Lazygit' })
      end
    end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = function(_, opts)
      local function on_move(data) Snacks.rename.on_rename_file(data.source, data.destination) end
      local events = require('neo-tree.events')
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
    end,
  },
}
