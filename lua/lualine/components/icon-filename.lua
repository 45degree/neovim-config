local filetype = require('lualine.components.filetype'):extend()

function filetype:init(options) self.super.init(self, options) end

function filetype:update_status()
  local name = vim.fn.expand('%:t')
  return name
end

function filetype:apply_icon() self.super.apply_icon(self) end

return filetype
