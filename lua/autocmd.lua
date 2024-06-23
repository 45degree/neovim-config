-- refresh the buffer if the file is modified external
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  desc = 'Reload buffer on focus',
  callback = function()
    if vim.fn.getcmdwintype() == '' then
      vim.cmd('checktime')
    end
  end,
})

-- disable treesitter if lsp support semantic highlight
vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  callback = function(opt)
    local buf = opt.buf
    local client = vim.lsp.get_client_by_id(opt.data.client_id)
    if client and client.server_capabilities['semanticTokensProvider'] then
      vim.treesitter.stop(buf)
    end
  end,
})

-- exrc
vim.api.nvim_create_autocmd('DirChanged', {
  callback = function()
    for _, file in ipairs({ '.nvim.lua', '.nvimrc', '.exrc' }) do
      local stat = vim.loop.fs_stat(file)
      if stat and stat.type == 'file' then
        vim.cmd('source ' .. file)
      end
    end
  end,
})

-- highlight group

local set_custom_highlight = function()
  local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
  local normal_float = vim.api.nvim_get_hl(0, { name = 'NormalFloat' })
  local title = vim.api.nvim_get_hl(0, { name = 'Title' })
  local cursor_line = vim.api.nvim_get_hl(0, {name = 'CursorLine'})
  local telescope_prompt_prefix = vim.api.nvim_get_hl(0, { name = 'TelescopePromptPrefix' })

  -- treesitter
  vim.api.nvim_set_hl(0, 'TelescopeNormal', {
    fg = normal_float.fg,
    bg = normal_float.bg,
  })
  vim.api.nvim_set_hl(0, 'TelescopeBorder', {
    fg = normal_float.bg,
    bg = normal_float.bg,
  })
  vim.api.nvim_set_hl(0, 'TelescopePromptNormal', {
    bg = cursor_line.bg,
  })
  vim.api.nvim_set_hl(0, 'TelescopePromptBorder', {
    fg = cursor_line.bg,
    bg = cursor_line.bg,
  })
  vim.api.nvim_set_hl(0, 'TelescopePromptTitle', {
    fg = normal.bg,
    bg = normal.fg,
  })
  vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', {
    fg = telescope_prompt_prefix.fg,
    bg = cursor_line.bg,
  })
  vim.api.nvim_set_hl(0, 'TelescopeSelection', {
    bg = cursor_line.bg,
  })
  vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', {
    bg = title.fg,
  })
  vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', {
    bg = title.fg,
  })

  -- nvim-cmp
  local cmp_abbr = vim.api.nvim_get_hl(0, {name = 'CmpItemAbbr'})
  vim.api.nvim_set_hl(0, 'CmpItemAbbr', {
    fg = cmp_abbr.fg,
    bg = 'NONE'
  })

  -- neotree
  vim.api.nvim_set_hl(0, 'NeoTreeTabInactive', {
    bg = cursor_line.bg,
  })
  vim.api.nvim_set_hl(0, 'NeoTreeTabSeparatorInactive', {
    fg = cursor_line.bg,
    bg = cursor_line.bg,
  })
end

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = set_custom_highlight,
})
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = set_custom_highlight,
})
