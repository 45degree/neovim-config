return {
  'nvim-neotest/neotest',
  cmd = 'Neotest',
  dependencies = { 'nvim-neotest/nvim-nio', 'nvim-lua/plenary.nvim' },
  opts = {
    summary = {
      mappings = {
        jumpto = 'o',
        output = 'p',
        short = 'P',
      },
    },
  },
  config = function(_, opts)
    require('neotest').setup(opts)

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('neotest_close_with_q', { clear = true }),
      pattern = { 'neotest-summary', 'neotest-output', 'neotest-output-panel' },
      callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
      end,
    })
  end,
}
