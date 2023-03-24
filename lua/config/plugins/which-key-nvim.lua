require('which-key').setup {}

local chooseWin = function()
  local picker = require 'window-picker'
  local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end

local wk = require 'which-key'
wk.register({
  f = {
    name = '+文件', -- optional group name
    s = { '<cmd>w<cr>', '保存当前文件' },
    S = { '<cmd>wa<cr>', '保存所有文件' },
    c = { '<cmd>e $MYVIMRC<cr>', '打开vim配置文件' },
  },
  s = {
    name = '+Search',
    f = { '<cmd>Telescope find_files<cr>', '文件夹内查找文件' },
    a = { '<cmd>Telescope live_grep<cr>', '文件夹内查找文件内容' },
    g = { '<cmd>Telescope git_files<cr>', 'git项目内查找文件' },
    c = { '<cmd>Telescope colorscheme<cr>', '改变颜色' },
    h = { '<cmd>Telescope oldfiles<cr>', '查看历史' },
    p = { '<cmd>Telescope projects<cr>', '打开项目' },
    m = { '<cmd>Telescope marks<cr>', 'Mark 查找' },
    b = { '<cmd>Telescope buffers<cr>', '查找所有buffer' },
    r = { "<cmd>lua require('spectre').open()<cr>", '查找并替换' },
  },
  c = {
    name = '+代码',
    ['2'] = {
      name = '+markdown',
      p = { '<Plug>MarkdownPreview', 'markdown预览' },
      s = { '<Plug>MarkdownPreviewStop', 'markdown停止预览' },
    },
    g = {
      name = '+git',
      c = { '<cmd>Gitsigns preview_hunk<cr>', '显示Git当前行更改' },
      N = { '<cmd>Gitsigns prev_hunk<cr>', '跳转到Git上一个更改处' },
      n = { '<cmd>Gitsigns next_hunk<cr>', '跳转到Git下一个更改处' },
      p = { '<cmd>DiffviewOpen<cr>', '显示Git项目更改' },
      h = { '<cmd>DiffviewFileHistory<cr>', '显示当前文件历史更改' },
    },
    t = { '<cmd>Lspsaga outline<cr>', '打开代码大纲' },
    T = { '<cmd>Trouble<cr>', '打开代码诊断' },
    d = {
      name = '+debug',
      c = { require('dap').terminate, '关闭调试' },
      w = { require('dapui').toggle, '切换调试窗口' },
    },
    D = { require('neogen').generate, '生成代码文档注释' },
  },
  t = { '<cmd>Neotree toggle<cr>', '打开文件树' },
  w = {
    name = '+窗口',
    c = { chooseWin, '选择窗口' },
    d = { '<C-W>c', '删除当前窗口' },
    w = { '<C-W>w', '移动到其他窗口' },
    h = { '<C-W>h', '移动到左边窗口' },
    j = { '<C-W>j', '移动到下边窗口' },
    l = { '<C-W>l', '移动到右边窗口' },
    k = { '<C-W>k', '移动到上边窗口' },
    H = { '<C-W>5<', '窗口向左扩展' },
    J = { '<cmd>resize +5<cr>', '窗口向下扩展' },
    L = { '<C-W>5>', '窗口向右扩展' },
    K = { '<cmd>resize -5<cr>', '窗口向上扩展' },
    ['='] = { '<C-W>=', '平衡调整窗口' },
    s = { '<C-W>s', '上下分屏' },
    v = { '<C-W>v', '左右分屏' },
  },
  b = {
    name = '+Buffer',
    d = {
      name = '+delete',
      ['r'] = { '<cmd>BufferCloseBuffersLeft<cr>', '删除所有右边Buffer' },
      ['l'] = { '<cmd>BufferCloseBuffersRight<cr>', '删除所有左边Buffer' },
      ['p'] = { '<cmd>BufferCloseAllButPinned<cr>', '删除所有未固定Buffer' },
      ['cp'] = { '<cmd>BufferCloseAllButCurrentOrPinned<cr>', '删除所有未固定和非当前Buffer' },
      ['c'] = { '<cmd>BufferCloseAllButCurrent<cr>', '只保留当前buffer' },
      ['v'] = { '<cmd>BufferCloseAllButVisible<cr>', '只保留可见buffer' },
    },
    ['p'] = { '<cmd>BufferPin<cr>', '固定Buffer' },
    ['j'] = { '<cmd>BufferPick<cr>', 'Buffer跳转' },
    ['1'] = { '<cmd>BufferGoto 1<cr>', '移动到buffer1' },
    ['2'] = { '<cmd>BufferGoto 2<cr>', '移动到buffer2' },
    ['3'] = { '<cmd>BufferGoto 3<cr>', '移动到buffer3' },
    ['4'] = { '<cmd>BufferGoto 4<cr>', '移动到buffer4' },
    ['5'] = { '<cmd>BufferGoto 5<cr>', '移动到buffer5' },
    ['6'] = { '<cmd>BufferGoto 6<cr>', '移动到buffer6' },
    ['7'] = { '<cmd>BufferGoto 7<cr>', '移动到buffer7' },
    ['8'] = { '<cmd>BufferGoto 8<cr>', '移动到buffer8' },
  },
}, { prefix = '<space>' })
