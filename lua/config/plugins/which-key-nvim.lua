require('which-key').setup({})

--- close all buffer that not visible and not pined
local function close_all_but_visible_and_pin_buf()
  local state = require('bufferline.state')
  local render = require('bufferline.render')
  local Buffer = require('bufferline.buffer')
  local bbye = require('bufferline.bbye')

  for _, bufnr in ipairs(state.buffers) do
    if Buffer.get_activity(bufnr) < 2 and not state.is_pinned(bufnr) then
      bbye.bdelete(false, bufnr)
    end
  end

  render.update()
end

local chooseWin = function()
  local picker = require('window-picker')
  local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end

local wk = require('which-key')
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
    r = { '<cmd>Spectre<cr>', '查找并替换' },
  },
  c = {
    name = '+code',
    g = {
      name = '+git',
      c = { '<cmd>Gitsigns preview_hunk<cr>', '显示Git当前行更改' },
      N = { '<cmd>Gitsigns prev_hunk<cr>', '跳转到Git上一个更改处' },
      n = { '<cmd>Gitsigns next_hunk<cr>', '跳转到Git下一个更改处' },
      sh = { '<cmd>Gitsigns stage_hunk<cr>', '暂存hunk' },
      uh = { '<cmd>Gitsigns undo_stage_hunk<cr>', '撤销暂存hunk' },
      rh = { '<cmd>Gitsigns reset_hunk<cr>', '恢复hunk' },
      d = { '<cmd>Gitsigns diffthis<cr>', '显示当前文件更改' },
      p = { '<cmd>DiffviewOpen<cr>', '显示Git项目更改' },
      h = { '<cmd>DiffviewFileHistory %<cr>', '显示当前文件历史更改' },
    },
    T = { '<cmd>Trouble<cr>', '打开代码诊断' },
    f = { vim.lsp.buf.format, '代码格式化' },
    d = {
      name = '+debug',
      c = { require('dap').terminate, '关闭调试' },
      w = { require('dapui').toggle, '切换调试窗口' },
      ['='] = {
        function()
          require('dapui').open({ reset = true })
        end,
        '平衡调整窗口',
      },
    },
    t = { '<cmd>OverseerToggle<cr>', 'tasks' },
    -- D = { require('neogen').generate, '生成代码文档注释' },
  },
  g = {
    name = '+goto',
    t = { '<cmd>Neotree focus<cr>', '查看文件树' },
  },
  t = { '<cmd>Neotree toggle<cr>', '打开文件树' },
  T = { '<cmd>Outline<cr>', '代码大纲' },
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
      ['c'] = { '<cmd>BufferCloseAllButCurrentOrPinned<cr>', '只保留当前buffer' },
      ['v'] = { close_all_but_visible_and_pin_buf, '只保留可见buffer' },
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
  e = {
    name = '+Extension',
    ['pb'] = { '<cmd>lua require("plenary.profile").start("profile.log", {flame = true})<cr>', 'begin profile' },
    ['pe'] = { '<cmd>lua require("plenary.profile").stop()<cr>', 'end profile' },
  },
}, { prefix = '<space>' })
