return {
  'supermaven-inc/supermaven-nvim',
  event = 'InsertEnter',
  cond = require('config').ai == 'supermaven',
  cmd = {
    'SupermavenStart',
    'SupermavenStop',
    'SupermavenRestart',
    'SupermavenToggle',
    'SupermavenStatus',
    'SupermavenUseFree',
    'SupermavenUsePro',
    'SupermavenLogout',
    'SupermavenShowLog',
    'SupermavenClearLog',
  },
  opts = {
    keymaps = {
      accept_suggestion = '<M-l>',
      clear_suggestion = '<C-]>',
      accept_word = nil,
    },
  },
}
