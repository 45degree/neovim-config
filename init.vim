" =============================================================
"           __  __             __     ___
"          |  \/  |_   _    __ \ \   / (_)_ __ ___
"          | |\/| | | | |  / _` \ \ / /| | '_ ` _ \
"          | |  | | |_| | | (_| |\ V / | | | | | | |
"          |_|  |_|\__, |  \__, | \_/  |_|_| |_| |_|
"                  |___/      |_|
"
" =============================================================

" =============================================================
" 基本配置
" =============================================================

" 外观配置
set number         " 显示行号
set relativenumber " 显示相对行号 set cursorline     " 高亮当前行
set showmode       " 底部显示命令模式还是插入模式
set showcmd        " 命令模式下显示命令
set encoding=utf-8 " 编码格式为utf-8
set t_Co=256       " 设置为256色
set textwidth=100  " 每行显示100个字符
set cc=100
set wrap           " 折行
set linebreak      " 单词内部不折行
set wrapmargin=2   " 折行边缘字符数
set scrolloff=5    " 垂直翻滚时保留的行数
set laststatus=2   " 显示状态栏 0不显示, 1多窗口显示, 2显示
set ruler          " 状态栏显示光标当前位置
set termguicolors  " 支持24位彩色
set timeoutlen=500

" 缩进设置
" filetype indent on " 文件类型缩进检测
set autoindent     " 格式保持一致
set tabstop=4      " 设置tab键的宽度
set shiftwidth=4   " >> , <<, == 的宽度
set expandtab      " tab转换成空格
set softtabstop=4  " tab转换成空格的数量

" 搜索配置
set showmatch      " 自动高亮匹配括号
set hlsearch       " 高亮搜索结果
set incsearch      " 每输入一个字符自动跳到第一个搜索结果
set noignorecase   " 搜索不忽略大小写
set smartcase      " 搜索时智能忽略大小写

" 编辑
" set spell spelllang=en_us,cjk  " 英语单词拼写检查
set nobackup                   " 不创建备份文件
set noswapfile                 " 不创建交换文件
set undofile                   " 保留撤销历史
set autochdir                  " 自动切换工作目录
set noerrorbells               " 出错不发出响声
set visualbell                 " 出错时发出视觉提示
set history=1000               " 记住1000次历史操作
set autoread                   " 打开文件监视
set listchars=tab:>-,trail:-   " 末尾空格、tab用-高亮
set list
set wildmenu
set wildmode=longest:list,full " 底部命令tab自动补全
set clipboard=unnamedplus      " 设置vim使用系统剪切板

" 禁止使用方向键
nnoremap <Up> :echo "use k"<CR>
nnoremap <Left> :echo "use h"<CR>
nnoremap <Right> :echo "use l"<CR>
nnoremap <Down> :echo "use j"<CR>

inoremap jj <ESC>

" 解决插入模式下delete/backspace键失效问题
set backspace=2

" 启动鼠标支持
set mouse=a

" leader设置为空格
let g:mapleader="\<space>"
let g:maplocalleader = ","

" " =============================================================
" " 插件配置
" " =============================================================

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" let g:ale_disable_lsp = 1

lua option_config = require('option_config')
lua option_config.read(vim.api.nvim_eval('stdpath("config")') .. '/option_config.json')

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    call dein#load_toml(stdpath('config').'/modules/appearance.toml')
    call dein#load_toml(stdpath('config').'/modules/general.toml')
    call dein#load_toml(stdpath('config').'/modules/git.toml')
    call dein#load_toml(stdpath('config').'/modules/textobj.toml')

    call dein#load_toml(stdpath('config').'/modules/code.toml')
    call dein#load_toml(stdpath('config').'/modules/lang/cpp.toml')
    call dein#end()

    call dein#begin('~/.cache/dein')
    if luaeval('option_config.getLanguage("rust")')
        call dein#load_toml(stdpath('config').'/option/lang/rust.toml')
    end

    if luaeval('option_config.getLanguage("vala")')
        call dein#load_toml(stdpath('config').'/option/lang/vala.toml')
    end

    if luaeval('option_config.getLanguage("latex")')
        call dein#load_toml(stdpath('config').'/option/lang/latex.toml')
    end

    if luaeval('option_config.getLanguage("glslx")')
        call dein#load_toml(stdpath('config').'/option/lang/glslx.toml')
    end

    call dein#end()

    call dein#save_state()

endif

syntax on          " 语法高亮

" 加载Config下的.vim文件
for file in split(glob(stdpath('config').'/Config/*.vim'), '\n')
    exe 'source' file
endfor

for file in split(glob(stdpath('config').'/Config/extra/*.vim'), '\n')
    exe 'source' file
endfor

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

let bufferline = get(g:, 'bufferline', {})
let bufferline.icons='both'

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

vim.opt.list = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#666666 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#666666 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#666666 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#666666 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#666666 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#666666 gui=nocombine]]

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
    buftype_exclude = { "terminal", "nofile", "prompt"},
    filetype_exclude = { "dashboard", "coc-explorer"},
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
EOF

if exists('g:nvui')
    set guifontwide=WenQuanYi\ Micro\ Hei
    set guifont=SauceCodePro\ Nerd\ Font
endif
