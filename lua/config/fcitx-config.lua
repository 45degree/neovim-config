vim.g.fcitx_version = vim.fn.system('command -v fcitx5')
if vim.fn.empty(vim.g.fcitx_version) == 0 then
  vim.g.fcitx_version = 'fcitx5-remote'
else
  vim.g.fcitx_version = 'fcitx-remote'
end

vim.api.nvim_create_autocmd({"InsertLeave"}, {
  callback = function ()
    local input_status = vim.fn.system(vim.g.fcitx_version)
    if tonumber(input_status) == 2 then
      vim.b.inputtoggle = 1
      vim.fn.system(vim.g.fcitx_version .. ' -c')
    end
  end
})

vim.api.nvim_create_autocmd({"InsertEnter"}, {
  callback = function ()
    vim.cmd [[
      try
      if b:inputtoggle == 1
          call system(g:fcitx_version..' -o')
          let b:inputtoggle = 0
      endif
      catch /inputtoggle/
          let b:inputtoggle = 0
      endtry
    ]]
  end
})
