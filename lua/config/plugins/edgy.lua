---@diagnostic disable: undefined-doc-name

require('edgy').setup({
  right = {}, ---@type (Edgy.View.Opts|string)[]
  top = {}, ---@type (Edgy.View.Opts|string)[]
  bottom = {
    -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
    { ft = 'toggleterm', size = { height = 10 } },
    { ft = 'Trouble', size = { height = 10 } },
    { ft = 'qf', title = 'QuickFix', size = { height = 10 } },
    { ft = 'help', size = { height = 10 } },
  },
  left = {
    -- Neo-tree filesystem always takes half the screen height
    {
      ft = 'lspsagaoutline',
      title = 'Outline',
      pinned = true,
      size = { height = 0.3 },
      open = 'Lspsaga outline',
    },
    -- any other neo-tree windows
    'neo-tree',
  },

  ---@type table<Edgy.Pos, {size:integer, wo?:vim.wo}>
  options = {
    left = { size = 35 },
    bottom = { size = 10 },
    right = { size = 30 },
    top = { size = 10 },
  },
  -- edgebar animations
  animate = {
    enabled = false,
  },
  -- global window options for sidebar windows
  ---@type vim.wo
  wo = {
    -- Setting to `true`, will add an edgy winbar.
    -- Setting to `false`, won't set any winbar.
    -- Setting to a string, will set the winbar to that string.
    winbar = true,
    winfixwidth = true,
    winfixheight = false,
    winhighlight = 'WinBar:EdgyWinBar,Normal:EdgyNormal',
    spell = false,
    signcolumn = 'no',
  },
  -- buffer-local keymaps to be added to sidebar buffers.
  -- Existing buffer-local keymaps will never be overridden.
  -- Set to false to disable a builtin.
  ---@type table<string, fun(win:Edgy.Window)|false>
  keys = {
    -- close window
    ['q'] = function(win)
      win:close()
    end,
    -- hide window
    ['<c-q>'] = function(win)
      win:hide()
    end,
    -- close sidebar
    ['Q'] = function(win)
      win.view.edgebar:close()
    end,
    -- next open window
    [']w'] = function(win)
      win:next({ visible = true, focus = true })
    end,
    -- previous open window
    ['[w'] = function(win)
      win:prev({ visible = true, focus = true })
    end,
    -- next loaded window
    [']W'] = function(win)
      win:next({ pinned = false, focus = true })
    end,
    -- prev loaded window
    ['[W'] = function(win)
      win:prev({ pinned = false, focus = true })
    end,
  },
  icons = {
    closed = '',
    open = '',
  },

  -- enable this on Neovim <= 0.10.0 to properly fold sidebar windows.
  -- Not needed on a nightly build >= June 5, 2023.
  fix_win_height = vim.fn.has('nvim-0.10.0') == 0,
})
