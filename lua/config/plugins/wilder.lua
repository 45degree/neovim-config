local wilder = require('wilder')
vim.call('wilder#setup', {modes = {':', '/', '?'}})
wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlights = {
      border = 'Normal', -- highlight to use for the border
    },
    highlighter = wilder.basic_highlighter(),
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    border = 'rounded',
    max_height = '20%', -- to set a fixed height, set max_height to the same value
    reverse = 0
  })
))
