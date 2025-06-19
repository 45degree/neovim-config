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
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (' 󰁂 %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth) end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, 'MoreMsg' })
      return newVirtText
    end,
  },
  enabled = function() return vim.fn.has('nvim-0.9') == 1 end,
}
