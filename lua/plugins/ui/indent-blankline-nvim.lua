return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'LazyFile',
  opts = {
    indent = { char = '│' },
    exclude = {
      filetypes = { 'neo-tree', 'alpha', 'help', 'lazy', 'mason', 'Neogit*', 'snacks_dashboard' },
      buftypes = { 'terminal', 'nofile', 'prompt' },
    },
    scope = { enabled = false },
  },
  config = function(_, opts) require('ibl').setup(opts) end,
}
