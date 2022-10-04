return function(use)
  use {
    'mfussenegger/nvim-dap',
    config = function ()
      vim.fn.sign_define("DapBreakpoint", {text=' ', texthl='', linehl='', numhl=''})
      vim.fn.sign_define("DapBreakpointCondition", {text=' ', texthl='', linehl='', numhl=''})
      vim.fn.sign_define("DapStopped", { text = " ", texthl = "", linehl = "", numhl = ""})
      vim.fn.sign_define("DapBreakpointRejected", { text = "⭐️", texthl = "", linehl = "", numhl = ""})

      -- local dap = require "dap"
      -- TODO: wait dap-ui for fixing temrinal layout
      -- the "30" of "30vsplit: doesn't work
      -- dap.defaults.fallback.terminal_win_cmd = '30vsplit new' -- this will be overrided by dapui
      -- dap.set_log_level("DEBUG")
    end
  }

  use {
    'rcarriga/nvim-dap-ui',
    config = function ()
      local status_ok, dapui = pcall(require, 'dapui')
      if not status_ok then
        vim.notify("dapui not found")
        return
      end

      dapui.setup ({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<2-LeftMouse>", "<CR>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            -- You can change the order of elements in the sidebar
            elements = {
              -- Provide as ID strings or tables with "id" and "size" keys
              {
                id = "scopes",
                size = 0.35, -- Can be float or integer > 1
              },
              { id = "stacks", size = 0.35 },
              { id = "watches", size = 0.15 },
              { id = "breakpoints", size = 0.15 },
            },
            size = 40,
            position = "left", -- Can be "left", "right", "top", "bottom"
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 5,
            position = "bottom", -- Can be "left", "right", "top", "bottom"
          }
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
      })
    end
  }

  use {
    'theHamsta/nvim-dap-virtual-text',
    after = "nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup {
          enabled = true,                     -- enable this plugin (the default)
          enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_new_as_changed = true,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          show_stop_reason = true,            -- show stop reason when stopped for exceptions
          commented = false,                  -- prefix virtual text with comment string
          -- experimental features:
          virt_text_pos = 'eol',              -- position of virtual text, see `:h nvim_buf_set_extmark()`
          all_frames = false,                 -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
          virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
          virt_text_win_col = nil             -- position the virtual text at a fixed window column (starting from the first text column) ,
                                              -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      }
    end
  }

  use {
    'nvim-telescope/telescope-dap.nvim',
    after = "telescope.nvim",
    config = function ()
      require('telescope').load_extension('dap')
    end
  }

  use {
    'rcarriga/cmp-dap',
    after = 'nvim-cmp',
    config = function ()
      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
    end
  }
end
