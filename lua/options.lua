-- 外观配置

vim.o.number = true -- 显示行号
vim.o.relativenumber = true -- 显示相对行号 set cursorline     " 高亮当前行
vim.o.showmode = true -- 底部显示命令模式还是插入模式
vim.o.showcmd = true -- 命令模式下显示命令
vim.o.encoding = 'utf-8' -- 编码格式为utf-8
vim.o.textwidth = 150 -- 每行显示150个字符
vim.o.cc = '+1'
vim.o.wrap = true -- 折行
vim.o.linebreak = true -- 单词内部不折行
vim.o.wrapmargin = 2 -- 折行边缘字符数
vim.o.scrolloff = 5 -- 垂直翻滚时保留的行数
vim.o.laststatus = 3 -- 显示状态栏 0不显示, 1多窗口显示, 2显示, 3 全局唯一
vim.o.ruler = true -- 状态栏显示光标当前位置
vim.o.termguicolors = true -- 支持24位彩色
vim.o.timeoutlen = 500
vim.o.showtabline = 2
vim.cmd([[syntax on]]) -- 语法高亮

-- 缩进设置
vim.o.autoindent = true -- 格式保持一致
vim.o.tabstop = 2 -- 设置tab键的宽度
vim.o.shiftwidth = 2 --  >> , <<, == 的宽度
vim.o.expandtab = true -- tab转换成空格
vim.o.softtabstop = 2 -- tab转换成空格的数量

-- 搜索配置
vim.o.showmatch = true -- 自动高亮匹配括号
vim.o.hlsearch = true -- 高亮搜索结果
vim.o.incsearch = true -- 每输入一个字符自动跳到第一个搜索结果
vim.o.ignorecase = false -- 搜索不忽略大小写
vim.o.smartcase = true -- 搜索时智能忽略大小写

-- 编辑
-- " set spell spelllang=en_us,cjk  " 英语单词拼写检查
vim.o.writebackup = false
vim.o.backup = false -- 不创建备份文件
vim.o.swapfile = false -- 不创建交换文件
vim.o.undofile = true -- 保留撤销历史
vim.o.autochdir = true -- 自动切换工作目录
vim.o.errorbells = false -- 出错不发出响声
vim.o.visualbell = true -- 出错时发出视觉提示
vim.o.history = 1000 -- 记住1000次历史操作
vim.o.listchars = 'tab:··,trail:·' -- 末尾空格、tab用-高亮
vim.o.list = true
vim.o.wildmenu = true
vim.o.wildmode = 'longest:list,full' -- 底部命令tab自动补全
vim.o.clipboard = 'unnamedplus' -- 设置vim使用系统剪切板
vim.o.signcolumn = 'auto'
vim.o.exrc = true -- project local setting
vim.o.jumpoptions = 'stack'

if vim.fn.has('nvim') then vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1 end

-- 解决插入模式下delete/backspace键失效问题
vim.opt.backspace = '2'

-- leader设置为空格
vim.g.mapleader = ' '
vim.g.maplocalleader = '  '

-- 启动鼠标支持
vim.opt.mouse = 'a'

local icons = require('icons')

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
