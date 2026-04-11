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
  local current_im = vim.fn.system('fcitx5-remote -n'):gsub('%s+', '')

  local function rime_is_ascii_mode()
    local result = vim.fn.system({
      'dbus-send',
      '--session',
      '--print-reply',
      '--dest=org.fcitx.Fcitx5',
      '/rime',
      'org.fcitx.Fcitx.Rime1.IsAsciiMode',
    })
    return result:match('boolean (%a+)') == 'true'
  end

  local function rime_set_ascii_mode(enabled)
    vim.fn.system({
      'dbus-send',
      '--session',
      '--type=method_call',
      '--dest=org.fcitx.Fcitx5',
      '/rime',
      'org.fcitx.Fcitx.Rime1.SetAsciiMode',
      'boolean:' .. tostring(enabled),
    })
  end

  if current_im == 'rime' and vim.fn.executable('dbus-send') == 1 and pcall(rime_is_ascii_mode) then
    vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
      callback = function()
        if not rime_is_ascii_mode() then
          vim.b.inputtoggle = 1
          rime_set_ascii_mode(true)
        end
      end,
    })

    vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
      callback = function()
        if vim.b.inputtoggle == 1 then
          rime_set_ascii_mode(false)
          vim.b.inputtoggle = 0
        end
      end,
    })
    return
  end

  vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
    callback = function()
      local input_status = vim.fn.system('fcitx5-remote')
      if tonumber(input_status) == 2 then
        vim.b.inputtoggle = 1
        vim.fn.system('fcitx5-remote -c')
      end
    end,
  })

  vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
    callback = function()
      if vim.b.inputtoggle == 1 then
        vim.fn.system('fcitx5-remote -o')
        vim.b.inputtoggle = 0
      end
    end,
  })
end

-- if vim.fn.executable('macism') == 1 and vim.fn.has('macunix') == 1 then
--   local default_ime_select = 'com.apple.keylayout.ABC'
--
--   vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
--     callback = function()
--       local ime_previous_states = vim.fn.system({ 'macism' }):match('^%s*(.-)%s*$')
--       vim.api.nvim_set_var('ime_saved_states', ime_previous_states)
--       vim.fn.system({ 'macism', default_ime_select })
--     end,
--   })
--
--   vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
--     callback = function()
--       if vim.g['ime_saved_states'] ~= nil then vim.fn.system({ 'macism', vim.g['ime_saved_states'] }) end
--     end,
--   })
-- end
