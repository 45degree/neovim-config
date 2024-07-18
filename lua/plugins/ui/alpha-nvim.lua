return {
  'goolord/alpha-nvim',
  dependencies = { 'luukvbaal/statuscol.nvim' }, -- should load alpha after load statuscol.nvim to enable the ft_ignore in statuscol.nvim
  lazy = true,
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

        require('lazy').load({ plugins = { 'alpha-nvim' } })
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function()
        local stats = require('lazy').stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        if package.loaded['alpha'] then
          local dashboard = require('alpha.themes.dashboard')
          dashboard.section.footer.val = '󱐋 Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
          require('alpha').start(true)
        end
      end,
    })
  end,
  config = function()
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == 'lazy' then
      vim.cmd.close()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'AlphaReady',
        callback = function() require('lazy').show() end,
      })
    end

    -- require'alpha'.setup(require'alpha.themes.dashboard'.config)
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    -- disable statuscol for alpha. see: https://github.com/luukvbaal/statuscol.nvim/issues/90
    dashboard.config.opts.noautocmd = false
    dashboard.section.header.val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }
    dashboard.section.buttons.val = {
      dashboard.button('f', '  file', '<cmd>Telescope find_files <cr>'),
      dashboard.button('p', '  project', '<cmd>Telescope projects<cr>'),
      dashboard.button('h', '  History', '<cmd>Telescope oldfiles <cr>'),
      dashboard.button('c', '  Color', '<cmd>Telescope colorscheme <cr>'),
      dashboard.button('m', '  marks', '<cmd>Telescope marks <cr>'),
      dashboard.button('w', '  word', '<cmd>Telescope live_grep <cr>'),
    }
    alpha.setup(dashboard.config)
  end,
}
