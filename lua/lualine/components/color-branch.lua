local branch = require('lualine.components.branch'):extend()
local highlights = require('lualine.highlight')
local utils = require('lualine.utils.utils')

function branch:init(options)
  branch.super.init(self, options)
  self.options = options
  local branch_color = utils.extract_highlight_colors('ModeMsg', 'fg')
  local highlight_group = { gui = 'bold' }
  if branch_color then
    highlight_group.fg = branch_color
  end
  self.hl = highlights.create_component_highlight_group(highlight_group, 'lualine_branch', options)
end

function branch:apply_icon()
  self.status =  highlights.component_format_highlight(self.hl) .. ' ' .. self.status
end

return branch
