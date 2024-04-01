return {
  'nvimdev/template.nvim',
  cmd = { 'Template', 'TemProject' },
  config = function()
    require('template').setup({
      temp_dir = vim.fn.stdpath('config') .. '/template',
    })
  end,
}
