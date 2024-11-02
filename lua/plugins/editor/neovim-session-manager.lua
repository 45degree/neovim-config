return {
  'Shatur/neovim-session-manager',
  event = 'VeryLazy',
  opts = function()
    local config = require('session_manager.config')

    return {
      autoload_mode = { config.AutoloadMode.GitSession, config.AutoloadMode.CurrentDir },
    }
  end,
  config = function(_, opts)
    require('session_manager').setup(opts)

    -- Auto save session
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          -- Don't save while there's any 'nofile' buffer open.
          if vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'nofile' then return end
        end
        require('session_manager').save_current_session()
      end,
    })
  end,
}
