return {
  'nvimdev/template.nvim',
  cmd = { 'Template', 'TemProject' },
  opts = { temp_dir = vim.fn.stdpath('config') .. '/template' },
}
