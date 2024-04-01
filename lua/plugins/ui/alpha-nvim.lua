return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == 'lazy' then
      vim.cmd.close()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'AlphaReady',
        callback = function()
          require('lazy').show()
        end,
      })
    end

    -- require'alpha'.setup(require'alpha.themes.dashboard'.config)
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
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
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function()
        local stats = require('lazy').stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = '󱐋 Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
