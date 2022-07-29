-- local dbg_path = require("dap-install.config.settings").options["installation_path"] .. "codelldb/"
local dbg_path = require("mason.settings").current.install_root_dir .. "/packages/codelldb/"
local codelldb_path = dbg_path .. "extension/adapter/codelldb"

local lldb_path;
if vim.fn.has("WIN32") == 1 then
  lldb_path = dbg_path .. "extension/lldb/lib/liblldb.lib"
elseif vim.fn.has("UNIX") == 1 then
  lldb_path = dbg_path .. "extension/lldb/lib/liblldb.so"
end

local M = {}

M.adapters = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = codelldb_path,
    args = {"--port", "${port}", "--liblldb", lldb_path},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

M.configurations = {}


return M
