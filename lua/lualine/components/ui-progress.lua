local component = require('lualine.component'):extend()
local utils = require('lualine.utils.utils')
local highlights = require('lualine.highlight')

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
  self.hl.normal = highlights.create_component_highlight_group({ fg = normal }, 'ui_progress_normal', options)
  self.hl.insert = highlights.create_component_highlight_group({ fg = insert }, 'ui_progress_insert', options)
  self.hl.command = highlights.create_component_highlight_group({ fg = command }, 'ui_progress_command', options)
  self.hl.terminal = highlights.create_component_highlight_group({ fg = terminal }, 'ui_progress_terminal', options)
  self.hl.inactive = highlights.create_component_highlight_group({ fg = inactive }, 'ui_progress_inactive', options)
  self.hl.visual = highlights.create_component_highlight_group({ fg = visual }, 'ui_progress_visual', options)
  self.hl.replace = highlights.create_component_highlight_group({ fg = replace }, 'ui_progress_replace', options)

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
end

function component:update_status()
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')
  local chars = { '_', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
  local index = 1

  if current_line == 1 then
    index = 1
  elseif current_line == total_lines then
    index = #chars
  else
    local line_no_fraction = vim.fn.floor(current_line) / vim.fn.floor(total_lines)
    index = vim.fn.float2nr(line_no_fraction * #chars)
    if index == 0 then
      index = 1
    end
  end


  local mode = vim.fn.mode()
  local mode_color = self.mode_color[mode]
  if mode_color == nil then
    mode_color = self.hl.normal
  end
  return highlights.component_format_highlight(mode_color) .. chars[index]
end

return component
