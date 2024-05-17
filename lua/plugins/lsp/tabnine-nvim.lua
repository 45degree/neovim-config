local function tabnine_build_path()
  if vim.loop.os_uname().sysname == 'Windows_NT' then
    return 'powershell.exe -file .\\dl_binaries.ps1'
  else
    return './dl_binaries.sh'
  end
end

return {
  'codota/tabnine-nvim',
  event = 'VeryLazy',
  build = tabnine_build_path(),
  config = function()
    local opts = {
      disable_auto_comment = true,
      accept_keymap = '<M-l>',
      dismiss_keymap = '<M-]>',
      debounce_ms = 800,
      suggestion_color = { gui = '#808080', cterm = 244 },
      exclude_filetypes = { 'TelescopePrompt', 'neo-tree' },
      log_file_path = nil, -- absolute path to Tabnine log file
    }
    require('tabnine').setup(opts)

    -- set color group when load tabnine
    local const = require('tabnine.consts')
    vim.api.nvim_set_hl(0, const.tabnine_hl_group, {
      fg = opts.suggestion_color.gui,
      ctermfg = opts.suggestion_color.cterm,
    })
    vim.api.nvim_set_hl(0, const.tabnine_codelens_hl_group, {
      fg = opts.suggestion_color.gui,
      ctermfg = opts.suggestion_color.cterm,
    })
  end,
  cond = require('config').tabnine,
}
