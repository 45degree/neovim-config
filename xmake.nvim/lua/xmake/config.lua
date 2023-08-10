local dap_type = 'cpptool'
if vim.fn.has('WIN32') == 1 then
  dap_type = 'codelldb'
end

local xmake_executable = 'xmake'
if vim.fn.has('UNIX') == 1 then
  xmake_executable = vim.env.HOME .. '/.local/bin/xmake'
end

local config = {
  xmake_executable = xmake_executable,
  quickfix_size = 10, -- cmake output window height
  quickfix_position = 'belowright', -- "belowright", "aboveleft", ...
  show_quickfix = 'always', -- "always", "only_on_error"
  dap_configuration = function(params)
    return {
      name = 'xmake debug',
      type = 'codelldb',
      request = 'launch',
      stopOnEntry = false,
      program = params.program,
      args = params.args,
      cwd = params.cwd,
      env = params.env,
      externalConsole = false,
    }
  end,
}

function config:new(obj)
  return setmetatable(obj, {
    __index = self,
  })
end

return config
