return {
  'luukvbaal/statuscol.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = 'kevinhwang91/nvim-ufo',
  config = function()
    local builtin = require('statuscol.builtin')
    require('statuscol').setup({
      relculright = true,
      ft_ignore = { 'neo-tree', 'toggleterm', 'Outline', 'alpha' },
      bt_ignore = { 'nofile', 'prompt' },
      segments = {
        { sign = { name = { '.*' } },                                        click = 'v:lua.ScSa' },
        { text = { builtin.lnumfunc },                                       click = 'v:lua.ScLa' },
        { sign = { namespace = { 'gitsign*' }, maxwidth = 1, colwidth = 1 }, click = 'v:lua.ScSa' },
        { text = { builtin.foldfunc },                                       click = 'v:lua.ScFa' },
        { text = { ' ' } },
      },
    })
  end,
  enabled = function()
    return vim.fn.has('nvim-0.9') == 1
  end,
}