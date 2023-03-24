local dbg_path = require('mason.settings').current.install_root_dir .. '/packages/codelldb/'
local codelldb_path = dbg_path .. 'extension/adapter/codelldb'

local M = {}

M.adapters = {
  type = 'server',
  port = '${port}',
  executable = {
    -- CHANGE THIS to your path!
    command = codelldb_path,
    args = { '--port', '${port}' },
    -- On windows you may have to uncomment this:
    detached = false,
  },
}

M.configurations = {}

return M
