return {
  -- 'Exafunction/codeium.vim',
  'monkoose/neocodeium',
  event = 'InsertEnter',
  config = function()
    local codeium = require('neocodeium')
    codeium.setup({ show_label = false })

    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set('i', '<M-l>', function() codeium.accept() end, { expr = true, silent = true })
    vim.keymap.set('i', '<M-]>', function() codeium.cycle(1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<M-[>', function() codeium.cycle(-1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<C-]>', function() codeium.clear() end, { expr = true, silent = true })
    --
    -- if vim.fn.has('win32') then
    --   vim.g.codeium_os = 'Windows'
    -- elseif vim.fn.has('mac') then
    --   vim.g.codeium_os = 'Darwin'
    -- elseif vim.fn.has('unix') then
    --   vim.g.codeium_os = 'Linux'
    -- end
    --
    -- vim.g.codeium_arch = vim.uv.os_uname().machine
  end,
  cond = require('config').edit_prediction_provider == 'codeium',
}
