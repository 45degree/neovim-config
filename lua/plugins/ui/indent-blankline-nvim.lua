return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('ibl').setup({
      indent = { char = '│' },
      exclude = {
        filetypes = { 'neo-tree', 'alpha', 'help', 'lazy', 'mason', 'Neogit*' },
        buftypes = { 'terminal', 'nofile', 'prompt' },
      },
      scope = { enabled = false },
    })
  end,
}
