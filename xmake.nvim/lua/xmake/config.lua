local xmake_executable = 'xmake'
if vim.fn.has('UNIX') == 1 then xmake_executable = vim.env.HOME .. '/.local/bin/xmake' end

local function default_dap_configuration(params)
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
end

local M = {}
M.opts = {
  xmake_executable = xmake_executable,
  quickfix_size = 10, -- cmake output window height
  quickfix_position = 'belowright', -- "belowright", "aboveleft", ...
  show_quickfix = 'always', -- "always", "only_on_error"
}
M.dap_configuration = default_dap_configuration

function M.setup(args) M.opts = vim.tbl_deep_extend('force', M.opts, args or {}) end

function M.set_dap_configuration(callback) M.dap_configuration = callback or default_dap_configuration end

return M
