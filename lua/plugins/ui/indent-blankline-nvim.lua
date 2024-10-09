return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  opts = {
    indent = { char = '│' },
    exclude = {
      filetypes = { 'neo-tree', 'alpha', 'help', 'lazy', 'mason', 'Neogit*' },
      buftypes = { 'terminal', 'nofile', 'prompt' },
    },
    scope = { enabled = false },
  },
  config = function(_, opts) require('ibl').setup(opts) end,
}
