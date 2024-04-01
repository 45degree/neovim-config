return {
  'kosayoda/nvim-lightbulb',
  event = 'LspAttach',
  config = function()
    require('nvim-lightbulb').setup({
      autocmd = { enabled = true },
      virtual_text = {
        enabled = true,
        text = '',
      },
    })
  end,
}
