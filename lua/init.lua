require('vim._core.ui2').enable({ msg = { targets = 'msg', msg = { height = 0.2, timeout = 2000 } } })

require('options')
require('ime-config')
require('keymap')
require('packages')
require('autocmd')
require('gui')

vim.cmd.colorscheme(require('config').colorscheme)
