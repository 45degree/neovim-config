return {
  dir = vim.fn.stdpath('config') .. '/xmake.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = "XMake",
  config = function()
    -- MSBuild:
    vim.opt.errorformat:append([[\ %#%f(%l\,%c):\ %m]])
    -- cl.exe:
    vim.opt.errorformat:append([[\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %m]])
    -- clang / gcc
    vim.opt.errorformat:append([[%E%f:%l:%c:\ %trror:\ %m,%-Z%p^,%+C%.%#]])

    require('xmake').setup({
      dap_configuration = function(params)
        print(vim.inspect(params.env))
        local cpptools_env = {}
        for k, v in pairs(params.env) do
          table.insert(cpptools_env, { name = k, value = v })
        end
        return {
          {
            name = 'xmake debug with codelldb',
            type = 'codelldb',
            request = 'launch',
            stopOnEntry = false,
            program = params.program,
            args = params.args,
            cwd = params.cwd,
            env = params.env,
            externalConsole = false,
          },
          {
            name = 'xmake debug with cpptools(lldb)',
            type = 'cppdbg',
            request = 'launch',
            stopOnEntry = true,
            MIMode = 'lldb',
            miDebuggerPath = vim.fn.exepath('lldb'),
            program = params.program,
            args = params.args,
            cwd = params.cwd,
            environment = cpptools_env,
          },
          {
            name = 'xmake debug with cpptools(gdb)',
            type = 'cppdbg',
            request = 'launch',
            stopOnEntry = true,
            MIMode = 'gdb',
            miDebuggerPath = vim.fn.exepath('gdb'),
            program = params.program,
            args = params.args,
            cwd = params.cwd,
            environment = cpptools_env,
          },
        }
      end,
    })
  end,
}
