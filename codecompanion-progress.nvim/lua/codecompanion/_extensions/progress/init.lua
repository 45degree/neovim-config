---@class CodeCompanion.Extension.Progress.Config
---@field spinner? CodeCompanion.Extension.Progress.SpinnerConfig
---@field notify? CodeCompanion.Extension.Progress.NotifyConfig

local M = {}

---@param opts? CodeCompanion.Extension.Progress.Config
function M.setup(opts)
  if opts == nil or vim.tbl_isempty(opts) then
    require('codecompanion-progress.spinner').setup()
    require('codecompanion-progress.notify').setup()
    return
  end

  require('codecompanion-progress.spinner').setup(opts.spinner or {})
  require('codecompanion-progress.notify').setup(opts.notify or {})
end

return M
