-- 外观配置

vim.opt.number = true -- 显示行号
vim.opt.relativenumber = true -- 显示相对行号 set cursorline     " 高亮当前行
vim.opt.showmode = true -- 底部显示命令模式还是插入模式
vim.opt.showcmd = true -- 命令模式下显示命令
vim.opt.encoding = 'utf-8' -- 编码格式为utf-8
vim.opt.textwidth = 120 -- 每行显示100个字符
vim.opt.cc = '+1'
vim.opt.wrap = true -- 折行
vim.opt.linebreak = true -- 单词内部不折行
vim.opt.wrapmargin = 2 -- 折行边缘字符数
vim.opt.scrolloff = 5 -- 垂直翻滚时保留的行数
vim.opt.laststatus = 0 -- 显示状态栏 0不显示, 1多窗口显示, 2显示, 3 全局唯一
vim.opt.ruler = true -- 状态栏显示光标当前位置
vim.opt.termguicolors = true -- 支持24位彩色
vim.opt.timeoutlen = 500
vim.cmd([[syntax on]]) -- 语法高亮

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
vim.opt.backup = false -- 不创建备份文件
vim.opt.swapfile = false -- 不创建交换文件
vim.opt.undofile = true -- 保留撤销历史
vim.opt.autochdir = true -- 自动切换工作目录
vim.opt.errorbells = false -- 出错不发出响声
vim.opt.visualbell = true -- 出错时发出视觉提示
vim.opt.history = 1000 -- 记住1000次历史操作
vim.opt.autoread = true -- 打开文件监视
vim.opt.listchars = 'tab:··,trail:·' -- 末尾空格、tab用-高亮
vim.opt.list = true
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:list,full' -- 底部命令tab自动补全
vim.opt.clipboard = 'unnamedplus' -- 设置vim使用系统剪切板
vim.opt.signcolumn = 'auto'
vim.opt.exrc = true -- project local setting

if vim.fn.has('nvim') then
  vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
end

-- 解决插入模式下delete/backspace键失效问题
vim.opt.backspace = '2'

-- leader设置为空格
vim.g.mapleader = ' '

-- 启动鼠标支持
vim.opt.mouse = 'a'

require('config.keymap')
require('config.autocmd')

local option_config = require('option_config')
option_config.read(vim.api.nvim_eval('stdpath("config")') .. '/option_config.json')

local signs = { Error = "󰅚", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
