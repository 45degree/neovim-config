return {
  'p00f/clangd_extensions.nvim',
  ft = { 'c', 'cpp' },
  enabled = false,
  config = function()
    require('clangd_extensions').setup()

    local group = vim.api.nvim_create_augroup('clangd_extension', {
      clear = true,
    })

    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      desc = 'Setup clangd_extension scores for cmp',
      pattern = 'c,cpp',
      callback = function()
        local cmp = require('cmp')
        cmp.setup.buffer({
          sorting = {
            comparators = {
              cmp.config.compare.offset,
              cmp.config.compare.exact,
              cmp.config.compare.recently_used,
              require('clangd_extensions.cmp_scores'),
              cmp.config.compare.kind,
              cmp.config.compare.sort_text,
              cmp.config.compare.length,
              cmp.config.compare.order,
            },
          },
        })
      end,
    })
  end,
}
