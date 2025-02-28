-- refresh the buffer if the file is modified external
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  desc = 'Reload buffer on focus',
  callback = function()
    if vim.o.buftype ~= 'nofile' then vim.cmd('checktime') end
  end,
})

-- exrc
vim.api.nvim_create_autocmd('DirChanged', {
  callback = function()
    for _, file in ipairs({ '.nvim.lua', '.nvimrc', '.exrc' }) do
      local stat = vim.uv.fs_stat(file)
      if stat and stat.type == 'file' then vim.cmd('source ' .. file) end
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  -- group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  -- group = augroup('highlight_yank'),
  callback = function() (vim.hl or vim.highlight).on_yank() end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  -- group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- set filetype for slang
vim.filetype.add({ extension = { hx = 'haxe', slang = 'slang' } })
