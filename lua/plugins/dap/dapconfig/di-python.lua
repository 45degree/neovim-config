local dap = require('dap')

dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    local port = (config.connect or config).port
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
    return
  end

  local python_path = config.pythonPath
  if not python_path then python_path = vim.fn.executable('python') and vim.fn.exepath('python') or vim.fn.exepath('python3') end

  cb({
    type = 'executable',
    command = python_path,
    args = { '-m', 'debugpy.adapter' },
    options = {
      source_filetype = 'python',
    },
  })
end

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = vim.fn.exepath('python'),
  },
}
