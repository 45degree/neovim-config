return {
  'olimorris/onedarkpro.nvim',
  lazy = true,
  opts = {
    highlights = {
      NeoTreeTabActive = { fg = '${green}' },
      NeoTreeTabInactive = { fg = '${green}', bg = '${gray}' },
      NeoTreeTabSeparatorInactive = { fg = '${gray}', bg = '${gray}' },
      BufferCurrentWARN = { fg = '${yellow}', bg = 'NONE' },
      BufferCurrentERROR = { fg = '${red}', bg = 'NONE' },
      BufferInactiveSign = { fg = '${gray}' },
    },
    styles = {
      types = 'NONE',
      methods = 'NONE',
      numbers = 'NONE',
      strings = 'NONE',
      comments = 'italic',
      keywords = 'bold,italic',
      constants = 'NONE',
      functions = 'bold',
      operators = 'NONE',
      variables = 'NONE',
      parameters = 'NONE',
      conditionals = 'NONE',
      virtual_text = 'NONE',
    },
    options = {
      highlight_inactive_windows = false,
    },
  },
}
