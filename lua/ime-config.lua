if vim.g.neovide ~= nil then
  local function set_ime(args)
    if args.event:match('Enter$') then
      vim.g.neovide_input_ime = true
    else
      vim.g.neovide_input_ime = false
    end
  end

  local ime_input = vim.api.nvim_create_augroup('ime_input', { clear = true })

  vim.api.nvim_create_autocmd({ 'InsertEnter', 'InsertLeave' }, {
    group = ime_input,
    pattern = '*',
    callback = set_ime,
  })

  vim.api.nvim_create_autocmd({ 'CmdlineEnter', 'CmdlineLeave' }, {
    group = ime_input,
    pattern = '[/\\?]',
    callback = set_ime,
  })

  return
end

if vim.fn.has('win32') ~= 1 and vim.fn.executable('fcitx5-remote') == 1 then
  vim.g.fcitx_version = vim.fn.system('command -v fcitx5')
  if vim.fn.empty(vim.g.fcitx_version) == 0 then
    vim.g.fcitx_version = 'fcitx5-remote'
  else
    vim.g.fcitx_version = 'fcitx-remote'
  end

  vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
    callback = function()
      local input_status = vim.fn.system(vim.g.fcitx_version)
      if tonumber(input_status) == 2 then
        vim.b.inputtoggle = 1
        vim.fn.system(vim.g.fcitx_version .. ' -c')
      end
    end,
  })

  vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
    callback = function()
      vim.cmd([[
      try
      if b:inputtoggle == 1
          call system(g:fcitx_version..' -o')
          let b:inputtoggle = 0
      endif
      catch /inputtoggle/
          let b:inputtoggle = 0
      endtry
    ]])
    end,
  })
  return
end

if vim.fn.executable('macism') == 1 and vim.fn.has('macunix') == 1 then
  local default_ime_select = 'com.apple.keylayout.ABC'

  vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
    callback = function()
      local ime_previous_states = vim.fn.system({ 'macism' }):match('^%s*(.-)%s*$')
      vim.api.nvim_set_var('ime_saved_states', ime_previous_states)
      vim.fn.system({ 'macism', default_ime_select })
    end,
  })

  vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
    callback = function()
      if vim.g['ime_saved_states'] ~= nil then vim.fn.system({ 'macism', vim.g['ime_saved_states'] }) end
    end,
  })
end
