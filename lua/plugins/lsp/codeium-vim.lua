return {
  'Exafunction/codeium.vim',
  event = 'InsertEnter',
  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set('i', '<M-l>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    vim.keymap.set('i', '<M-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<M-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-]>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })

    if vim.fn.has('win32') then
      vim.g.codeium_os = 'Windows'
    elseif vim.fn.has('mac') then
      vim.g.codeium_os = 'Darwin'
    elseif vim.fn.has('unix') then
      vim.g.codeium_os = 'Linux'
    end

    vim.g.codeium_arch = vim.uv.os_uname().machine
  end,
  cond = require('config').ai == 'codeium',
}
