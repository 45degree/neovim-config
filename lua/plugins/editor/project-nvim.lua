return {
  'ahmedkhalf/project.nvim',
  event = 'VeryLazy',
  config = function()
    require('project_nvim').setup({
      detection_methods = { 'pattern', 'lsp' },
      patterns = { '.git', '*.sln' },
      ignore_lsp = { 'null-ls', 'efm' },
    })
  end,
}
