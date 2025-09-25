local doom_config = {
  vertical_center = true,
  center = {
    { icon = ' ', key = 'f', desc = 'Find File', action = function() require('snacks.picker').files() end },
    { icon = ' ', key = 'g', desc = 'Find Text', action = function() require('snacks.picker').grep() end },
    { icon = ' ', key = 'r', desc = 'Recent Files', action = function() require('snacks.picker').recent() end },
    {
      icon = ' ',
      key = 'c',
      desc = 'Config',
      action = function() require('snacks.picker').files({ cwd = vim.fn.stdpath('config') }) end,
    },
    { icon = ' ', key = 's', desc = 'Restore Session', action = function() require('session_manager').load_session(false) end },
    { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
    { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
  },
  footer = function()
    local stats = require('lazy').stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
  end,
}

local format_center = function(config)
  for _, button in ipairs(config.center) do
    button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
    button.key_format = '  %s'
  end
  return config
end

return {
  'nvimdev/dashboard-nvim',
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

        require('lazy').load({ plugins = { 'dashboard-nvim' } })
      end,
    })
  end,
  opts = {
    theme = 'doom',
    config = format_center(doom_config),
  },
}
