return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  -- https://github.com/kevinhwang91/nvim-ufo/issues/47#issuecomment-1460742987
  event = 'LazyFile',
  init = function()
    local set_foldcolumn_for_file = vim.api.nvim_create_augroup('set_foldcolumn_for_file', {
      clear = true,
    })
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      group = set_foldcolumn_for_file,
      callback = function()
        if vim.bo.buftype == '' then
          vim.wo.foldcolumn = '1'
        else
          vim.wo.foldcolumn = '0'
        end
      end,
    })
    vim.api.nvim_create_autocmd('OptionSet', {
      group = set_foldcolumn_for_file,
      pattern = 'buftype',
      callback = function()
        if vim.bo.buftype == '' then
          vim.wo.foldcolumn = '1'
        else
          vim.wo.foldcolumn = '0'
        end
      end,
    })
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  end,
  opts = {
    close_fold_kinds_for_ft = { default = { 'imports' } },
    provider_selector = function(bufnr, filetype, buftype)
      local ft_ignore = { 'neo-tree', 'toggleterm', 'Outline', 'alpha', 'NeogitStatus', 'snacks_dashboard', 'dashboard' }
      local bt_ignore = { 'nofile', 'prompt' }
      if vim.tbl_contains(ft_ignore, filetype) then return '' end
      if vim.tbl_contains(bt_ignore, buftype) then return '' end
      return { 'lsp', 'indent' }
    end,
  },
  enabled = function() return vim.fn.has('nvim-0.9') == 1 end,
}
