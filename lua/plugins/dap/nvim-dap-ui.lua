return {
  'rcarriga/nvim-dap-ui',
  lazy = true,
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap, dapui = require('dap'), require('dapui')
    local config = require('config')

    dapui.setup({
      icons = { expanded = '', collapsed = '', current_frame = '' },
      layouts = {
        {
          -- You can change the order of elements in the sidebar
          elements = {
            { id = 'scopes', size = 0.35 },
            { id = 'stacks', size = 0.35 },
            { id = 'watches', size = 0.15 },
            { id = 'breakpoints', size = 0.15 },
          },
          size = 40,
          position = 'left', -- Can be "left", "right", "top", "bottom"
        },
        {
          elements = { 'repl', 'console' },
          size = 0.25,
          position = 'bottom', -- Can be "left", "right", "top", "bottom"
        },
      },
      floating = { border = config.border },
      windows = { indent = 1 },
    })

    local debug_open = function() require('dapui').open({ reset = true }) end

    local debug_close = function()
      dap.repl.close()
      dapui.close()
    end

    dap.listeners.after.event_initialized['dapui_config'] = function() debug_open() end

    dap.listeners.before.event_terminated['dapui_config'] = function()
      debug_close()
      print(1)
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      debug_close()
      print(2)
    end

    dap.listeners.before.disconnect['dapui_config'] = function()
      debug_close()
      print(2)
    end
  end,
}
