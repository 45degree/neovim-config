local function toggle_snacks_terminal()
  ---@type snacks.terminal.Opts
  local terminal_opts = { win = { height = 10, position = 'bottom', wo = { winbar = '' } } }
  require('snacks.terminal').toggle(require('config').shell, terminal_opts)
end

local terminal_style = {
  bo = { filetype = 'snacks_terminal' },
  wo = {},
  stack = true,
  keys = {
    term_normal = { '<esc>', function() vim.cmd('stopinsert') end, mode = 't', expr = true },
  },
}

return {
  'folke/snacks.nvim',
  keys = { { '<M-=>', toggle_snacks_terminal, mode = { 'n', 't' } } },
  opts = {
    terminal = { enabled = true, win = { style = terminal_style } },
  },
}
