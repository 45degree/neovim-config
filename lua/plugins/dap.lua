return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'williamboman/mason.nvim',
    },
    event = 'VeryLazy',
    config = function()
      vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = ' ', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '⭐️', texthl = '', linehl = '', numhl = '' })
      require('config.dap.dap-config').setup()
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('config.plugins.dap-ui-nvim')
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('nvim-dap-virtual-text').setup({
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        -- experimental features:
        virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      })
    end,
  },

  {
    'nvim-telescope/telescope-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
      'telescope.nvim',
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('telescope').load_extension('dap')
    end,
  },

  {
    'rcarriga/cmp-dap',
    dependencies = {
      'nvim-cmp',
      'mfussenegger/nvim-dap',
    },
    event = 'LspAttach',
    config = function()
      require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
        sources = {
          { name = 'dap' },
        },
      })
    end,
  },
}
