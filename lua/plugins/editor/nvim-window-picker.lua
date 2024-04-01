return {
  -- only needed if you want to use the commands with "_with_window_picker" suffix
  's1n7ax/nvim-window-picker',
  event = 'VeryLazy',
  config = function()
    require('window-picker').setup({
      filter_rules = {
        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { 'neo-tree*', 'notify', 'quickfix', 'Trouble', 'edgy', 'Outline', 'Overseer*' },
          -- if the buffer type is one of following, the window will be ignored
          buftype = { 'terminal', 'nofile' },
        },
      },
      -- other_win_hl_color = '#e35e4f',
    })
  end,
}
