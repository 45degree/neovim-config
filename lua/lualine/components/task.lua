local M = require('lualine.component'):extend()
local utils = require('lualine.utils.utils')

function M:init(options)
  M.super.init(self, options)
end

function M:update_colors()
  if not package.loaded['overseer'] then return end
  if self.icons and self.highlight_groups then return end

  self.highlight_groups = {}
  local default_color = utils.extract_highlight_colors('Normal', 'fg')
  assert(type(default_color) == 'string')
  local overseer_status = require('overseer.constants').STATUS

  for _, status in ipairs(overseer_status.values) do
    local hl = string.format('Overseer%s', status)
    local color = { fg = utils.extract_color_from_hllist('fg', { hl }, default_color) }
    self.highlight_groups[status] = self:create_hl(color, status)
  end

  self.icons = {
    [overseer_status.FAILURE] = '󰅚 ',
    [overseer_status.CANCELED] = ' ',
    [overseer_status.SUCCESS] = '󰄴 ',
    [overseer_status.RUNNING] = '󰑮 ',
  }
end

function M:update_status()
  if not package.loaded['overseer'] then return end
  self:update_colors()

  local pieces = {}
  local tasks = require('overseer.task_list').list_tasks()
  local tasks_by_status = require('overseer.util').tbl_group_by(tasks, 'status')
  for _, status in ipairs(require('overseer.constants').STATUS.values) do
    local status_tasks = tasks_by_status[status]
    if self.icons[status] and status_tasks then
      local hl_start = self:format_hl(self.highlight_groups[status])
      table.insert(pieces, string.format('%s%s%s', hl_start, self.icons[status], #status_tasks))
    end
  end
  if #pieces > 0 then return table.concat(pieces, ' ') end
end

return M
