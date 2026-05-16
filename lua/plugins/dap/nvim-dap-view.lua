return {
  'igorlfs/nvim-dap-view',
  lazy = true,
  opts = {
    winbar = {
      show = true,
      sections = { 'watches', 'scopes', 'exceptions', 'breakpoints', 'threads', 'repl' },
      default_section = 'watches',
    },
    auto_toggle = true,
    virtual_text = { enabled = true },
    switchbuf = function(bufnr, winnr)
      local wins = vim.api.nvim_tabpage_list_wins(0)
      for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].buftype == '' then return win end
      end
    end,
  },
  keys = { { 'DK', function() require('dap-view').hover() end, desc = 'DAP eval' } },
}
