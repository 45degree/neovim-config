-- 外观配置

vim.opt.number = true -- 显示行号
vim.opt.relativenumber = true -- 显示相对行号 set cursorline     " 高亮当前行
vim.opt.showmode = true -- 底部显示命令模式还是插入模式
vim.opt.showcmd = true -- 命令模式下显示命令
vim.opt.encoding = 'utf-8' -- 编码格式为utf-8
vim.opt.textwidth = 150 -- 每行显示150个字符
vim.opt.cc = '+1'
vim.opt.wrap = true -- 折行
vim.opt.linebreak = true -- 单词内部不折行
vim.opt.wrapmargin = 2 -- 折行边缘字符数
vim.opt.scrolloff = 5 -- 垂直翻滚时保留的行数
vim.opt.laststatus = 3 -- 显示状态栏 0不显示, 1多窗口显示, 2显示, 3 全局唯一
vim.opt.ruler = true -- 状态栏显示光标当前位置
vim.opt.termguicolors = true -- 支持24位彩色
vim.opt.timeoutlen = 500
vim.opt.showtabline = 2
vim.cmd([[syntax on]]) -- 语法高亮
vim.opt.winborder = require('config').border

-- 缩进设置
vim.opt.autoindent = true -- 格式保持一致
vim.opt.tabstop = 2 -- 设置tab键的宽度
vim.opt.shiftwidth = 2 --  >> , <<, == 的宽度
vim.opt.expandtab = true -- tab转换成空格
vim.opt.softtabstop = 2 -- tab转换成空格的数量

-- 搜索配置
vim.opt.showmatch = true -- 自动高亮匹配括号
vim.opt.hlsearch = true -- 高亮搜索结果
vim.opt.incsearch = true -- 每输入一个字符自动跳到第一个搜索结果
vim.opt.ignorecase = false -- 搜索不忽略大小写
vim.opt.smartcase = true -- 搜索时智能忽略大小写

-- 编辑
-- " set spell spelllang=en_us,cjk  " 英语单词拼写检查
vim.opt.writebackup = false
vim.opt.backup = false -- 不创建备份文件
vim.opt.swapfile = false -- 不创建交换文件
vim.opt.undofile = true -- 保留撤销历史
vim.opt.autochdir = true -- 自动切换工作目录
vim.opt.errorbells = false -- 出错不发出响声
vim.opt.visualbell = true -- 出错时发出视觉提示
vim.opt.history = 1000 -- 记住1000次历史操作
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.list = true
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:list,full' -- 底部命令tab自动补全
vim.opt.clipboard = 'unnamedplus' -- 设置vim使用系统剪切板
vim.opt.signcolumn = 'auto'
vim.opt.exrc = true -- project local setting
vim.opt.jumpoptions = 'stack'

if vim.fn.has('nvim') then vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1 end

-- 解决插入模式下delete/backspace键失效问题
vim.opt.backspace = '2'

-- leader设置为空格
vim.g.mapleader = ' '
vim.g.maplocalleader = '  '

-- 启动鼠标支持
vim.opt.mouse = 'a'

local icons = require('icons')

-- fold
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Source: https://www.reddit.com/r/neovim/comments/1fzn1zt/custom_fold_text_function_with_treesitter_syntax/
local function fold_virt_text(result, start_text, lnum)
  local text = ''
  local hl
  for i = 1, #start_text do
    local char = start_text:sub(i, i)
    local new_hl

    -- if semantic tokens unavailable, use treesitter hl
    local sem_tokens = vim.lsp.semantic_tokens.get_at_pos(0, lnum, i - 1)
    if sem_tokens and #sem_tokens > 0 then
      new_hl = '@' .. sem_tokens[#sem_tokens].type
    else
      local captured_highlights = vim.treesitter.get_captures_at_pos(0, lnum, i - 1)
      if captured_highlights[#captured_highlights] then
        new_hl = '@' .. captured_highlights[#captured_highlights].capture
      end
    end

    if new_hl then
      if new_hl ~= hl then
        -- as soon as new hl appears, push substring with current hl to table
        table.insert(result, { text, hl })
        text = ''
        hl = nil
      end
      text = text .. char
      hl = new_hl
    else
      text = text .. char
    end
  end
  table.insert(result, { text, hl })
end

function _G.custom_foldtext()
  local start_text = vim.fn.getline(vim.v.foldstart):gsub('\t', string.rep(' ', vim.o.tabstop))
  local nline = vim.v.foldend - vim.v.foldstart
  local result = {}
  fold_virt_text(result, start_text, vim.v.foldstart - 1)
  table.insert(result, { ' ', nil })
  table.insert(result, { ('↙ %d lines'):format(nline), '@comment.comment' })
  return result
end
vim.opt.foldtext = 'v:lua.custom_foldtext()'

-- Set diagnostic options
vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = '' },
  float = { severity_sort = true, source = 'if_many' },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostic.error,
      [vim.diagnostic.severity.WARN] = icons.diagnostic.warn,
      [vim.diagnostic.severity.HINT] = icons.diagnostic.hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostic.info,
    },
  },
})
