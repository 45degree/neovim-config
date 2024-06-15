return {
  'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  config = function()
    require('nvim-web-devicons').setup({
      override_by_extension = {
        ['template'] = {
          icon = '󰘓',
          color = '#3b484e',
          name = 'Template',
        },
      },
    })
  end,
}
