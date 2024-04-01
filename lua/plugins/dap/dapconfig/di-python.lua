local dap = require('dap')

dap.adapters.debugpy = {
  id = 'debugpy',
  type = 'executable',
  command = vim.fn.exepath('debugpy-adapter'),
  options = {
    source_filetype = 'python',
  },
}

dap.configurations.python = {
  {
    type = 'debugpy',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = vim.fn.exepath('python'),
  },
}
