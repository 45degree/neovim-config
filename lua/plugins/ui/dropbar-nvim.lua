local ignore_bf = { 'nofile' }
local ignore_ft = { 'dap-repl', 'dapui_scopes', 'dapui_breakpoints', 'snacks_terminal' }

return {
  'Bekaboo/dropbar.nvim',
  event = 'LazyFile',
  opts = {
    bar = {
      enable = function(buf, win, _)
        if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then return false end
        if vim.fn.win_gettype(win) ~= '' or vim.wo[win].winbar ~= '' then return false end

        local ft = vim.bo[buf].ft
        local bt = vim.bo[buf].bt

        if ft == 'help' then return false end
        if vim.list_contains(ignore_bf, bt) or vim.list_contains(ignore_ft, ft) then return false end

        local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
        if stat and stat.size > 1024 * 1024 then return false end

        if ft == 'markdown' then return true end
        if pcall(vim.treesitter.get_parser, buf) then return true end

        return not vim.tbl_isempty(vim.lsp.get_clients({
          bufnr = buf,
          method = 'textDocument/documentSymbol',
        }))
      end,
    },
    icons = { kinds = { symbols = require('icons').kind_with_space } },
  },
}
