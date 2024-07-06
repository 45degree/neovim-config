local filename = require('lualine.components.filename'):extend()
local highlight = require('lualine.highlight')
local utils = require('lualine.utils.utils')

function filename:init(options)
  self.super.init(self, options)
  self.icon_hl_cache = {}
end

function filename:update_status()
  local name = vim.fn.expand('%:t')
  local icon, highlight_group = self:get_icon_and_highlight_group()
  if vim.bo.modified and self.icon_hl_cache[highlight_group] then
    name = highlight.component_format_highlight(self.icon_hl_cache[highlight_group]) .. name
  end

  if not icon then
    return name
  end
  return icon .. name
end

--- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/components/filetype.lua
function filename:get_icon_and_highlight_group()
  local devicons = require('nvim-web-devicons')
  local icon, icon_highlight_group = devicons.get_icon(vim.fn.expand('%:t'))
  if icon == nil then
    icon, icon_highlight_group = devicons.get_icon_by_filetype(vim.bo.filetype)
  end

  if icon == nil and icon_highlight_group == nil then
    icon = ''
    icon_highlight_group = 'DevIconDefault'
  end

  if icon then
    icon = icon .. ' '
  end

  local highlight_color = utils.extract_highlight_colors(icon_highlight_group, 'fg')
  if highlight_color then
    local default_highlight = self:get_default_hl()
    local icon_highlight = self.icon_hl_cache[highlight_color]
    if not icon_highlight or not highlight.highlight_exists(icon_highlight.name .. '_normal') then
      icon_highlight = self:create_hl({ fg = highlight_color }, icon_highlight_group)
      self.icon_hl_cache[highlight_color] = icon_highlight
    end

    icon = self:format_hl(icon_highlight) .. icon .. default_highlight
  end

  return icon, highlight_color
end

return filename
