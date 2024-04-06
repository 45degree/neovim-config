return {
  'rcarriga/nvim-dap-ui',
  lazy = true,
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap, dapui = require('dap'), require('dapui')

    dapui.setup({
      icons = { expanded = '', collapsed = '' },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { '<2-LeftMouse>', '<CR>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
      },
      layouts = {
        {
          -- You can change the order of elements in the sidebar
          elements = {
            -- Provide as ID strings or tables with "id" and "size" keys
            {
              id = 'scopes',
              size = 0.35, -- Can be float or integer > 1
            },
            { id = 'stacks',      size = 0.35 },
            { id = 'watches',     size = 0.15 },
            { id = 'breakpoints', size = 0.15 },
          },
          size = 40,
          position = 'left', -- Can be "left", "right", "top", "bottom"
        },
        {
          elements = {
            'repl',
            'console',
          },
          size = 0.25,
          position = 'bottom', -- Can be "left", "right", "top", "bottom"
        },
      },
      floating = {
        max_height = nil,  -- These can be integers or a float between 0 and 1.
        max_width = nil,   -- Floats will be treated as percentage of your screen.
        border = 'single', -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      windows = { indent = 1 },
    })

    local debug_open = function()
      require('dapui').open({ reset = true })
      vim.api.nvim_command('DapVirtualTextEnable')
    end

    local debug_close = function()
      dap.repl.close()
      dapui.close()
      vim.api.nvim_command('DapVirtualTextDisable')
    end

    dap.listeners.after.event_initialized['dapui_config'] = function()
      debug_open()
    end

    dap.listeners.before.event_terminated['dapui_config'] = function()
      debug_close()
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      debug_close()
    end

    dap.listeners.before.disconnect['dapui_config'] = function()
      debug_close()
    end
  end,
}
