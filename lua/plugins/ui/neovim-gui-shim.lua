return {
  'equalsraf/neovim-gui-shim',
  cond = function()
    if vim.fn.has('gui_running') ~= 1 then return false end
    if vim.g.neovide == nil then return false end
    return true
  end,
}
