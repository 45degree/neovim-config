return {
  'ahmedkhalf/project.nvim',
  event = 'VeryLazy',
  opts = {
    detection_methods = { 'pattern', 'lsp' },
    patterns = { '.git', '*.sln' },
    ignore_lsp = { 'null-ls', 'efm' },
  },
  enable = false,
  config = function(_, opts)
    require('project_nvim').setup(opts)
  end
}
