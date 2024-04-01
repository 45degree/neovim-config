return {
  'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  config = function()
    local web_devicons_ok, web_devicons = pcall(require, 'nvim-web-devicons')
    if not web_devicons_ok then
      return
    end
    web_devicons.setup({
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
