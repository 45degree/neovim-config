local component = require('lualine.component'):extend()
local highlights = require('lualine.highlight')
local utils = require('lualine.utils.utils')

function component:init(options)
  component.super.init(self, options)

  local normal = utils.extract_highlight_colors('lualine_a_normal', 'bg')
  local insert = utils.extract_highlight_colors('lualine_a_insert', 'bg')
  local command = utils.extract_highlight_colors('lualine_a_command', 'bg')
  local terminal = utils.extract_highlight_colors('lualine_a_terminal', 'bg')
  local inactive = utils.extract_highlight_colors('lualine_a_inactive', 'bg')
  local visual = utils.extract_highlight_colors('lualine_a_visual', 'bg')
  local replace = utils.extract_highlight_colors('lualine_a_replace', 'bg')

  self.hl = {}
  self.hl.normal = highlights.create_component_highlight_group({ fg = normal }, 'icon_mode_normal', options)
  self.hl.insert = highlights.create_component_highlight_group({ fg = insert }, 'icon_mode_insert', options)
  self.hl.command = highlights.create_component_highlight_group({ fg = command }, 'icon_mode_command', options)
  self.hl.terminal = highlights.create_component_highlight_group({ fg = terminal }, 'icon_mode_terminal', options)
  self.hl.inactive = highlights.create_component_highlight_group({ fg = inactive }, 'icon_mode_inactive', options)
  self.hl.visual = highlights.create_component_highlight_group({ fg = visual }, 'icon_mode_visual', options)
  self.hl.replace = highlights.create_component_highlight_group({ fg = replace }, 'icon_mode_replace', options)
  self.mode_color = {
    n = self.hl.normal,
    i = self.hl.insert,
    v = self.hl.visual,
    [''] = self.hl.visual,
    V = self.hl.visual,
    c = self.hl.command,
    no = self.hl.normal,
    s = self.hl.replace,
    S = self.hl.replace,
    [''] = self.hl.replace,
    ic = self.hl.insert,
    R = self.hl.visual,
    Rv = self.hl.visual,
    cv = self.hl.visual,
    ce = self.hl.visual,
    r = self.hl.replace,
    rm = self.hl.replace,
    ['r?'] = self.hl.replace,
    ['!'] = self.hl.terminal,
    t = self.hl.terminal,
  }
  self.icon = ''
end

function component:update_status()
  local mode = vim.fn.mode()
  local mode_color = self.mode_color[mode]
  if mode_color == nil then
    mode_color = self.hl.normal
  end

  return highlights.component_format_highlight(mode_color) .. self.icon
end

return component
