return {
  'ofseed/project.nvim',
  event = 'VeryLazy',
  opts = {
    detection_methods = { 'pattern', 'lsp' },
    patterns = { '.git', '*.sln', '.obsidian', '.project' },
    ignore_lsp = { 'null-ls', 'efm' },
  },
  config = function(_, opts)
    require('project_nvim').setup(opts)
  end
}
