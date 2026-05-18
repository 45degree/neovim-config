---@diagnostic disable: undefined-global

local M = {}

function M.setup()
  require('config.dap.di-cpp')
  require('config.dap.di-python')
end

return M
